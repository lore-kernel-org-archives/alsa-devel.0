From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] Allow to switch hardware sampe rate on EMU
Date: Fri, 22 Feb 2013 17:59:38 +0000
Message-ID: <CAD-m0i9NwmVsGH53cphNM3ikDAanBU2bwE7Wa0KTASbwnW-aqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B9C2625CB
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 18:59:39 +0100 (CET)
Received: by mail-qa0-f46.google.com with SMTP id o13so544214qaj.12
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 09:59:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 57e5c63007955838043e34c732d224b2cbbb128f "emu10k1: allow to
disable the SRC"
force hardware use only one rate (48000 hz), but EMU have support two hardware
sampling rates (44100 and 48000 hz).

Signed-off-by: Mihail Zenkov <mihail.zenkov@gmail.com>

--- linux-3.8/sound/pci/emu10k1/emupcm.c
+++ linux-3.8-1/sound/pci/emu10k1/emupcm.c
@@ -1127,7 +1127,7 @@
 	struct snd_emu10k1_pcm *epcm;
 	struct snd_emu10k1_pcm_mixer *mix;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int i, err;
+	int i, err, sample_rate;

 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
@@ -1146,7 +1146,11 @@
 		kfree(epcm);
 		return err;
 	}
-	err = snd_pcm_hw_rule_noresample(runtime, 48000);
+	if (emu->card_capabilities->emu_model && emu->emu1010.internal_clock == 0)
+		sample_rate = 44100;
+	else
+		sample_rate = 48000;
+	err = snd_pcm_hw_rule_noresample(runtime, sample_rate);
 	if (err < 0) {
 		kfree(epcm);
 		return err;
