From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 001b/003] snd-powermac: style pmac.c
Date: Wed, 16 Apr 2008 10:01:33 +0300
Message-ID: <46e1c7760804160001u257cba57ja48dbd38d77d5cf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 70808103829
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 09:01:35 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so1108630hsb.0
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 00:01:34 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Coding style corrections for pmac.c.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/pmac.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/pmac.c	2008-04-07 12:18:47.503077312 +0300
@@ -214,7 +214,7 @@ static int snd_pmac_pcm_prepare(struct s
 	int rate_index;
 	long offset;
 	struct pmac_stream *astr;
-	
+
 	rec->dma_size = snd_pcm_lib_buffer_bytes(subs);
 	rec->period_size = snd_pcm_lib_period_bytes(subs);
 	rec->nperiods = rec->dma_size / rec->period_size;
@@ -643,7 +643,7 @@ static int snd_pmac_pcm_close(struct snd
 	/* reset constraints */
 	astr->cur_freqs = chip->freqs_ok;
 	astr->cur_formats = chip->formats_ok;
-	
+
 	return 0;
 }
