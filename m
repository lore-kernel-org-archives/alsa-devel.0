From: Stuart Longland <redhatter@gentoo.org>
Subject: SOC_DOUBLE_R_SX_TLV (was Update on TLV320AIC3204
 Driver)
Date: Fri, 18 Jun 2010 12:38:10 +1000
Message-ID: <20100618023810.GS7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id ECF3110380E
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 04:38:17 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OPRTA-0002xb-Q4
	for alsa-devel@alsa-project.org; Fri, 18 Jun 2010 12:38:13 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OPRT9-0002xP-Oh
	for alsa-devel@alsa-project.org; Fri, 18 Jun 2010 12:38:12 +1000
Content-Disposition: inline
In-Reply-To: <20100615051110.GG7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 03:11:10PM +1000, Stuart Longland wrote:
> When a read is performed, this structure points to this function as the
> means for reading the register (defined in sound/soc-core.c):
> 
> /**
>  * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
>  *  mixer get callback
>  * @kcontrol: mixer control
>  * @uinfo: control element information
>  *
>  * Returns 0 for success.
>  */
> int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
>                         struct snd_ctl_elem_value *ucontrol)
> {
>         struct soc_mixer_control *mc =
>                 (struct soc_mixer_control *)kcontrol->private_value;
>         struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>         unsigned int mask = (1<<mc->shift)-1;
>         int min = mc->min;
>         int val = snd_soc_read(codec, mc->reg) & mask;
>         int valr = snd_soc_read(codec, mc->rreg) & mask;
> 
>         ucontrol->value.integer.value[0] = ((val & 0xff)-min);
>         ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
>         return 0;
> }
> EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);

I've figured it out now... and there'll be a patch to fix it.

The mute <--> gain interaction was pure coincidence as it turns out.
There's no interaction between the two, just that when I toggle the
mute, the gain gets re-read, and hence it *appeared* to interact.

Notice the value calculated for the channel is:

	output = ( regval & 0xff ) - minimum

In my case, my minimum is -6.  Suppose I set my driver gain to -1dB, in
hexadecimal, 0x3f.  Since no sign extension is done, (regval & 0xff) =
63.  Adding 6 to this (double negation) you get 69... which is greater
than the maximum gain of 29.  Hence the scale shoots up to maximum.

The fix, is to change the above so that they mask the result; thus
wrapping around the zero point like so:

	output = ( ( regval & 0xff ) - minimum ) & mask

This fixes the problem that I observe, and shouldn't break the other
user of the control.  A patch to fix this issue is coming.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
