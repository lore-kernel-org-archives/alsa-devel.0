From: Dan Carpenter <error27@gmail.com>
Subject: Re: bug report: using snd_BUG_ON() instead of	WARN_ON()
Date: Fri, 19 Feb 2010 22:53:37 +0300
Message-ID: <20100219195337.GE17130@bicker>
References: <20100218091936.GA5621@bicker> <4B7ECD42.5050403@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 48B961037F1
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 20:53:51 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so32983eyh.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 11:53:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B7ECD42.5050403@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 19, 2010 at 06:41:22PM +0100, Clemens Ladisch wrote:
> Dan Carpenter wrote:
> > Smatch found a couple places try use the return value for snd_BUG_ON() 
> > without realizing it's always zero
> 
> snd_BUG_ON() returns the return value of WARN() which is the value of the
> condition.
> 

You are right.  I mis-read what was happening there.

I found out the problem in smatch that was causing these false positives
and I have fixed it.

regards,
dan carpenter

> > or that it can be defined away entirely under certain configs.
> 
> This is the point of this debugging macro.
> 
> > sound/drivers/opl3/opl3_midi.c +652 snd_opl3_kill_voice(34) warn: buffer overflow 'opl3->voices' 18 <= 20
> > 
> > 	opl3_midi.c checks the range with snd_BUG_ON() and then adds 3 so 
> > 	it possibly goes out of bounds.  I'm not sure the situation there.
> 
> A four-operator sound needs two voices with that offset.
> opl3_get_voice() takes care of allocating appropriate voices for that,
> but this case is not checked with snd_BUG_ON().  It would be possible to
> add snd_BUG_ON(voice+3) into the if().
> 
> > sound/core/seq/seq_midi.c +403 snd_seq_midisynth_register_port(126) error: buffer overflow 'client->ports_per_device' 8 <= 8
> > sound/core/seq/seq_midi.c +404 snd_seq_midisynth_register_port(127) error: buffer overflow 'client->ports' 8 <= 8
> 
> There is a snd_BUG_ON(device>=8) in line 291, so device can be at most 7.
> 
> > sound/core/info_oss.c +52 snd_oss_info_register(10) error: buffer overflow 'snd_sndstat_strings[num]' 6 <= 6
> > sound/core/info_oss.c +52 snd_oss_info_register(10) error: buffer overflow 'snd_sndstat_strings' 32 <= 32
> > sound/core/info_oss.c +63 snd_oss_info_register(21) error: buffer overflow 'snd_sndstat_strings[num]' 6 <= 6
> > sound/core/info_oss.c +63 snd_oss_info_register(21) error: buffer overflow 'snd_sndstat_strings' 32 <= 32
> > sound/pci/cs46xx/dsp_spos_scb_lib.c +1497 cs46xx_dsp_destroy_pcm_channel(28) error: buffer overflow 'ins->src_scb_slots' 14 <= 14
> 
> Same type of false positive; it looks as if >= in snd_BUG_ON() is not
> handled correctly.
> 
> 
> Regards,
> Clemens
