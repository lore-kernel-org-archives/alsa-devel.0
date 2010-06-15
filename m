From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 15:11:10 +1000
Message-ID: <20100615051110.GG7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002734.GB7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 909912452E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 07:11:18 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOQd-0005qV-FB
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:11:15 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOOQc-0007pg-Tc
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:11:15 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOQc-0007pd-Sf
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:11:14 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOQZ-0005oZ-PE
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:11:14 +1000
Content-Disposition: inline
In-Reply-To: <20100615002734.GB7759@www.longlandclan.yi.org>
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

On Tue, Jun 15, 2010 at 10:27:34AM +1000, Stuart Longland wrote:
> On Fri, Jun 11, 2010 at 11:18:04AM +0100, Mark Brown wrote:
> > On Fri, Jun 11, 2010 at 03:55:12PM +1000, Stuart Longland wrote:
> > 
> > > (1)	When using the SOC_DOUBLE_R_SX_TLV controls, I notice there's an
> > > 	odd interaction between the mute switch associated with the
> > > 	control, and its corresponding gain setting.
> > 
> > > 	Nothing changes in the actual registers (except the mute bit of
> > > 	course) but the displayed gain shoots up to infinity if the mute
> > > 	is toggled when the gain associated with that mute control is
> > > 	set below 0dB.  When the gain is at 0dB or above, toggling the
> > > 	mute has no effect on the displayed gain setting.
> > 
> > This is almost always due to having an overlap between the bitfield for
> > the volume and the mute bit.
> 
> I'll have a closer look, perhaps there's some misunderstanding on my
> part as to how the macros work.

Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
are implemented.  I couldn't find where in the git trees the control had
been added, I wound up applying this patch myself in my tree... it
apparently got applied in the official trees, but I cannot find it.

	<http://permalink.gmane.org/gmane.linux.alsa.devel/72893>

Hopefully below is telling everyone what we already know... and I'm just
checking that I understand this code properly.  If I'm misunderstanding
something, please let me know.

So the macro is defined as follows (in include/sound.soc.h):
#define SOC_DOUBLE_R_SX_TLV(xname, xreg_left, xreg_right, xshift,\
                xmin, xmax, tlv_array) \
{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
        .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
                  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
        .tlv.p = (tlv_array), \
        .info = snd_soc_info_volsw_2r_sx, \
        .get = snd_soc_get_volsw_2r_sx, \
        .put = snd_soc_put_volsw_2r_sx, \
        .private_value = (unsigned long)&(struct soc_mixer_control) \
                {.reg = xreg_left, \
                 .rreg = xreg_right, .shift = xshift, \
                 .min = xmin, .max = xmax} }

When a read is performed, this structure points to this function as the
means for reading the register (defined in sound/soc-core.c):

/**
 * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
 *  mixer get callback
 * @kcontrol: mixer control
 * @uinfo: control element information
 *
 * Returns 0 for success.
 */
int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
                        struct snd_ctl_elem_value *ucontrol)
{
        struct soc_mixer_control *mc =
                (struct soc_mixer_control *)kcontrol->private_value;
        struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
        unsigned int mask = (1<<mc->shift)-1;
        int min = mc->min;
        int val = snd_soc_read(codec, mc->reg) & mask;
        int valr = snd_soc_read(codec, mc->rreg) & mask;

        ucontrol->value.integer.value[0] = ((val & 0xff)-min);
        ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
        return 0;
}
EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);

Now for my data, almost all the driver gain registers have the
following format:

	Bit 7	6	5	4	3	2	1	0
	|	|	\					/
	Resvd	Mute	 '------Signed Gain setting in dB------'

Therefore; I want the 'mask' variable in the above function to select
that bottom 6 bits; a hex value of 0x3f... So working backwards to
derive mc->shift...

		mask = 	(1 << mc->shift) - 1	= 0011 1111b
			1 << mc->shift		= 0100 0000b
			mc->shift		= 6

Thus, the macro needs to specify xshift=6.  As for the other settings...
my gain range is -6dB through to 29dB, so those specify the xmin and
xmax as being -6 and 29 respectively.

As for the mute; we define this using the SOC_DOUBLE_R macro; bit 6 is
the mute bit as we can see above.  It's also inverted; turning it on,
turns the output driver off... and it's a single-bit value.

I therefore define the line output driver volume, and its corresponding
mute switch as follows:

/* Left Line Output Gain Setting Register */
#define AIC3204_LOLGAIN                 AIC3204_PGREG(1, 18)
/* Left Line Output Mute */
#define AIC3204_LOLGAIN_MUTE_SHIFT      (6)
/* Left Line Output Gain Mask */
#define AIC3204_LOLGAIN_MASK            (0x3f)

/* Right Line Output Gain Setting Register */
#define AIC3204_LORGAIN                 AIC3204_PGREG(1, 19)
/* Right Line Output Mute */
#define AIC3204_LORGAIN_MUTE_SHIFT      (6)
/* Right Line Output Gain Mask */
#define AIC3204_LORGAIN_MASK            (0x3f)

...
        SOC_DOUBLE_R_SX_TLV("Line Output Playback Volume",
                         AIC3204_LOLGAIN, AIC3204_LORGAIN,
			 6, -6, 29, output_stage_tlv),
        SOC_DOUBLE_R("Line Output Playback Switch", AIC3204_LOLGAIN, 
                        AIC3204_LORGAIN, AIC3204_LOLGAIN_MUTE_SHIFT,
			0x01, 1),

Now, that *mostly* works, except when the gain is set below 0dB, then
strange things occur.  Did I miss something or is the bug elsewhere?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
