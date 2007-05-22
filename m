From: "Zoltan Devai" <zdevai@gmail.com>
Subject: [PATCH] Fix ASoC s3c24xx-pcm spinlock bug
Date: Tue, 22 May 2007 12:28:28 +0200
Message-ID: <5b7270f40705220328j5007600bm22f06e93472bbba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DFCB244F5
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 12:28:29 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so483101anc
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 03:28:28 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

This should fix a spinlock lockup bug on the s3c24xx arch.

Regards,
Zoltan

---

--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -337,6 +337,8 @@ static int s3c24xx_pcm_open(struct snd_p
        if (prtd == NULL)
                return -ENOMEM;

+       spin_lock_init(&prtd->lock);
+
        runtime->private_data = prtd;
        return 0;
 }
