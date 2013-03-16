From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: Set SNDRV_PCM_HW_PARAMS_NORESAMPLE
	by default
Date: Sat, 16 Mar 2013 19:59:04 +0000
Message-ID: <CAD-m0i9wjLXjdjBZX6Oc==nMKVcccOoxtc=F+jLiM1xTkUy=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E99D265119
 for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2013 20:59:04 +0100 (CET)
Received: by mail-pb0-f45.google.com with SMTP id ro8so5217238pbb.18
 for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2013 12:59:04 -0700 (PDT)
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

As we don't allow resampling set SNDRV_PCM_HW_PARAMS_NORESAMPLE by
default to respect snd_pcm_hw_rule_noresample in drivers.

--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/src/pcm_params.c
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/pcm_params.c
@@ -436,6 +436,7 @@
 	params->rmask = ~0U;
 	params->cmask = 0;
 	params->info = ~0U;
+	params->flags = SNDRV_PCM_HW_PARAMS_NORESAMPLE;
 }

 int snd_pcm_hw_params_any(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
