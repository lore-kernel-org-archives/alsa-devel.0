From: Dan Carpenter <error27@gmail.com>
Subject: bug report:  using snd_BUG_ON() instead of WARN_ON()
Date: Thu, 18 Feb 2010 12:19:36 +0300
Message-ID: <20100218091936.GA5621@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f225.google.com (mail-fx0-f225.google.com
	[209.85.220.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 142D71038E8
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 10:20:54 +0100 (CET)
Received: by fxm25 with SMTP id 25so1000241fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 01:20:52 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Smatch found a couple places try use the return value for snd_BUG_ON() 
without realizing it's always zero or that it can be defined away entirely
under certain configs.

sound/core/info_oss.c
    46          if (snd_BUG_ON(dev < 0 || dev >= SNDRV_OSS_INFO_DEV_COUNT))
    47                  return -ENXIO;
    48          if (snd_BUG_ON(num < 0 || num >= SNDRV_CARDS))
    49                  return -ENXIO;

sound/drivers/opl3/opl3_midi.c +652 snd_opl3_kill_voice(34) warn: buffer overflow 'opl3->voices' 18 <= 20

	opl3_midi.c checks the range with snd_BUG_ON() and then adds 3 so 
	it possibly goes out of bounds.  I'm not sure the situation there.

sound/core/seq/seq_midi.c +403 snd_seq_midisynth_register_port(126) error: buffer overflow 'client->ports_per_device' 8 <= 8
sound/core/seq/seq_midi.c +404 snd_seq_midisynth_register_port(127) error: buffer overflow 'client->ports' 8 <= 8
sound/core/info_oss.c +52 snd_oss_info_register(10) error: buffer overflow 'snd_sndstat_strings[num]' 6 <= 6
sound/core/info_oss.c +52 snd_oss_info_register(10) error: buffer overflow 'snd_sndstat_strings' 32 <= 32
sound/core/info_oss.c +63 snd_oss_info_register(21) error: buffer overflow 'snd_sndstat_strings[num]' 6 <= 6
sound/core/info_oss.c +63 snd_oss_info_register(21) error: buffer overflow 'snd_sndstat_strings' 32 <= 32
sound/pci/cs46xx/dsp_spos_scb_lib.c +1497 cs46xx_dsp_destroy_pcm_channel(28) error: buffer overflow 'ins->src_scb_slots' 14 <= 14

regards,
dan carpenter
