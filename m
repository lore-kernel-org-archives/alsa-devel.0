Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE596EB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 15:31:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD06A86F;
	Mon, 10 Jul 2023 17:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD06A86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689003116;
	bh=gsDpUVQyWQItQktaQUVCVeyMm6ywi2DZhlFcVsLabjc=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=owFKc1Vq+SKxJFINFBJ4nFvyEhrDG930txbEqPGgs2NgXnj6OPzNgcUvwd0+XMc9g
	 JVBtHVqilpQTTMNKPoh+3i1vFj2yjj95bhjF2tA3qXO+rnh6kmBcPD8ZZF4HaLwKR2
	 NqApiLxB+G/NPo/kMUO8/hRfd9IrXj5Een/N4aXY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC3F4F80580; Mon, 10 Jul 2023 17:30:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D2A2F8057A;
	Mon, 10 Jul 2023 17:30:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A22FFF80549; Fri,  7 Jul 2023 13:25:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2DEE0F80153
	for <sound-open-firmware@alsa-project.org>;
 Fri,  7 Jul 2023 13:25:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DEE0F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lMYjUh1D
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so1797273f8f.3
        for <sound-open-firmware@alsa-project.org>;
 Fri, 07 Jul 2023 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688729129; x=1691321129;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQkPGD5/eqRL1CiGFWeiMUPmKQY/9u9/vWvSh1GggDE=;
        b=lMYjUh1DQgels50J8Ik5tIQ4VpRzz/pi0P351yaNC0VUTyA2Dxp/1+AGTn/7gg5f71
         S8CF1PnoxlbezYZ4muWjc+Joq/RvpyviY+5XIrW8j/z84la7VdqhOCzrnrhrbssxODCV
         G7wMfWQw4db3IYhw/uayB/H0GfAdOrcRdCTQhPTqK76MdxPwO5ykob5DMg7CwHs6Y16/
         4xBHMPjZW3bMFcaLAbG+bW8YpFzqYqvL46sGrsERtSphekqokTVZoOxDT/ONxh6f5sL6
         uof2biixlSQqHMNoYrLfrtEQnCtJCPboxOwUPgInaVP0sdYQogpZsTwJNidEVfYWz6U9
         qLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729129; x=1691321129;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQkPGD5/eqRL1CiGFWeiMUPmKQY/9u9/vWvSh1GggDE=;
        b=cXTQprhT1qT3icwbv3T0OmOERg23KlnEAwGy1eBqkxsYJ6m+Xh1oM0qvKf+YDTPUIl
         o8LDWvEszf8LwNJVWyWVPHQXvz6oJv0WwewUllA+svolOcKWROHgbFzXSe8pOLfvGTH2
         wSAF2N5u8m8UAKbse8Ugl4LYeSS/v1Th76XqoR9naH0IwZdJof3i/1qlYTuiPpqntvhZ
         4tGgTdpiuy7SaTgav3nPCdMVGgkqhjbquDZONX0QntA5N7aQTsULlO3pZBryl7nSnA9s
         8z4fb3Kc+ATFIF0xHJcliuc2vpyNG7ZE+oOqftmkTU89SqJ+Hy9jWO09RkHqeQ0jqj+u
         SxYA==
X-Gm-Message-State: ABy/qLa0kuQlIzQujnc8rhCeSiy1ZmAcPcY4hMhrni/iTxZXzs89YCUk
	1l0kjERwHBBQzPB1UVrPl4jXLg==
X-Google-Smtp-Source: 
 APBJJlGvlB38IdvqZ4ywf8WZL30A5qwSdsoLNrkiHml15YN1JK3u6HivCYr4mfjrzUKgYMK0dBIN1A==
X-Received: by 2002:a5d:6590:0:b0:314:db7:d132 with SMTP id
 q16-20020a5d6590000000b003140db7d132mr3918714wru.61.1688729129143;
        Fri, 07 Jul 2023 04:25:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 y5-20020a5d6205000000b003145521f4e5sm3080546wru.116.2023.07.07.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:25:27 -0700 (PDT)
Date: Fri, 7 Jul 2023 14:25:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc3-dtrace: uninitialized data in
 dfsentry_trace_filter_write()
Message-ID: <74148292-ce4d-4e01-a1a7-921e6767da14@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-sound-open-firmware.alsa-project.org-0;
 header-match-sound-open-firmware.alsa-project.org-1
Message-ID-Hash: 2PYEIHKXNPU3XILRHJ3KPSSV3NCZS2GW
X-Message-ID-Hash: 2PYEIHKXNPU3XILRHJ3KPSSV3NCZS2GW
X-Mailman-Approved-At: Mon, 10 Jul 2023 15:29:55 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2PYEIHKXNPU3XILRHJ3KPSSV3NCZS2GW/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This doesn't check how many bytes the simple_write_to_buffer() writes to
the buffer.  The only thing that we know is that the first byte is
initialized and the last byte of the buffer is set to NUL.  However
the middle bytes could be uninitialized.

There is no need to use simple_write_to_buffer().  This code does not
support partial writes but instead passes "pos = 0" as the starting
offset regardless of what the user passed as "*ppos".  Just use the
copy_from_user() function and initialize the whole buffer.

Fixes: 671e0b90051e ("ASoC: SOF: Clone the trace code to ipc3-dtrace as fw_tracing implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The nicer thing to do would have been to use strndup_user() but that
comes with a small risk of breaking user space and I can't test this
so I didn't do that.

 sound/soc/sof/ipc3-dtrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index 1d3bca2d28dd..35da85a45a9a 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -186,7 +186,6 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	struct snd_sof_dfsentry *dfse = file->private_data;
 	struct sof_ipc_trace_filter_elem *elems = NULL;
 	struct snd_sof_dev *sdev = dfse->sdev;
-	loff_t pos = 0;
 	int num_elems;
 	char *string;
 	int ret;
@@ -201,11 +200,11 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	if (!string)
 		return -ENOMEM;
 
-	/* assert null termination */
-	string[count] = 0;
-	ret = simple_write_to_buffer(string, count, &pos, from, count);
-	if (ret < 0)
+	if (copy_from_user(string, from, count)) {
+		ret = -EFAULT;
 		goto error;
+	}
+	string[count] = '\0';
 
 	ret = trace_filter_parse(sdev, string, &num_elems, &elems);
 	if (ret < 0)
-- 
2.39.2

