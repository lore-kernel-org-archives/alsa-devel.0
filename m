From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] Allow to switch hardware sampe rate on EMU
Date: Mon, 25 Feb 2013 10:02:45 +0000
Message-ID: <CAD-m0i9671mr7YG7d7roxWhyNvAPEzi+ggJxq0uwWx9cd2FK1Q@mail.gmail.com>
References: <CAD-m0i9NwmVsGH53cphNM3ikDAanBU2bwE7Wa0KTASbwnW-aqA@mail.gmail.com>
 <s5h8v6cu5oo.wl%tiwai@suse.de>
 <CAD-m0i_fcQM2Cc3LaoZ0AKY4xsu2OHGoV2a+iqdJcJ+SX0chKg@mail.gmail.com>
 <s5hy5ecsonp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 63EBA26514F
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 11:02:46 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id j34so1244971qco.9
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 02:02:45 -0800 (PST)
In-Reply-To: <s5hy5ecsonp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013/2/25, Takashi Iwai <tiwai@suse.de>:
> Ah, OK, then your patch would make sense.  Could you update the patch
> description to elaborate a bit more about this?

Commit 57e5c63007955838043e34c732d224b2cbbb128f "emu10k1: allow to
 disable the SRC" force hardware use only one rate (48000 hz).
EMU 0404/1010/1616 have support two hardware sampling rates (44100 and
48000 hz). This patch add check if we have EMU 0404/1010/1616 and
choose correct sample rate to restrict.

 Signed-off-by: Mihail Zenkov <mihail.zenkov@gmail.com>

 --- linux-3.8/sound/pci/emu10k1/emupcm.c
 +++ linux-3.8-1/sound/pci/emu10k1/emupcm.c
 @@ -1127,7 +1127,7 @@
         struct snd_emu10k1_pcm *epcm;
         struct snd_emu10k1_pcm_mixer *mix;
         struct snd_pcm_runtime *runtime = substream->runtime;
 -       int i, err;
 +       int i, err, sample_rate;

         epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
         if (epcm == NULL)
 @@ -1146,7 +1146,11 @@
                 kfree(epcm);
                 return err;
         }
 -       err = snd_pcm_hw_rule_noresample(runtime, 48000);
 +       if (emu->card_capabilities->emu_model &&
emu->emu1010.internal_clock == 0)
 +               sample_rate = 44100;
 +       else
 +               sample_rate = 48000;
 +       err = snd_pcm_hw_rule_noresample(runtime, sample_rate);
         if (err < 0) {
                 kfree(epcm);
                 return err;
