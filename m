Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ED9CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:07:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E418E602B0;
	Tue, 29 Sep 2026 21:07:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E418E602B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708863;
	bh=sd9V/QvVMf4cDvXMBa/UsWtjf2wjncnMpYTMCvePqXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hAC+LxFjZupfk1qPrIP57mDEH8b8nATZI9vdl8fAYuIBvZQTiw7Io/JUtpYY7GW7r
	 2melWEHy30c8T+myhFW2I7SERWnTynurUfbJVE1vTvOZr5INTsY1tzKsPOT7omFTbA
	 jJFB0V0rt/Z6Znz3kzVqMa/WbjbJFls2KFomOKYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D920AF80751; Tue, 29 Sep 2026 21:05:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B7DAF80765;
	Tue, 29 Sep 2026 21:05:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28114F8057F; Mon, 21 Sep 2026 21:38:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.227.149
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790019486;
	b=pd2HrvMKkVzNhsg3RtGmF2LHcNTmMHH5SepeFT6ENeOu+hjK5vZBAtHqSiKNKUSPA+WD
	 56+jEAErjAz2PTRoBU2XkOAObFhETmIZ4S5YhEYM/Xpu8oT/RO0fxm57+Eg3ux7w2+1sY
	 txK33Rj7sGYPzWuqvwc8i53sv9WFFWPe64pfthmLXOEhf0ctlvact/3vrrva8WnadJghn
	 pd36QTmtODeosmiaUlNJwFC4IkPTSBEAoYDGSrFmF71GP3L2OxDoIhmSSdKeijpQMbDdv
	 kwEx8vs3HKKcPXXfHFdcY/WZcSn617syTOhUJlkPWoMnFm//ApuyNuE6P2N12OzOmMA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790019486;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sd9V/QvVMf4cDvXMBa/UsWtjf2wjncnMpYTMCvePqXw=;
	b=dJyBRkMR3aC9RU0crQFKC9AicZSJJrVmH9/k5G3z8/ROvju3/YjP+U1CdK+FkEJuJzgs
	 sqjk1pcjo/MH6EjnIkYOS7PiPS3hOnMYIBaJbEWnVJIFttgWy9TuemAfYQhQkHTroPrJj
	 oJkMGVBkC3XTDRwFLhBJp98lBBt4wNA4eh3NggUTrVZ+y/PcaJwatrJCxCDTMQis0wmPA
	 NHyKH6NOiqUm/JE6ZKuqri+Xq/YeNVTduYn33TI/FbMLYWEWcn+YO8r+uuxOCslZFNVk0
	 SHY97AgaFEfLDo+Fh/ZzBeNCkR3FD1yl6F4vckkEsoBfiE2wJjv/cD6DdU41usg7CtA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=GNJ1obpC;
	arc=none smtp.remote-ip=74.125.227.149
Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com
 [74.125.227.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10454F800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 21:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10454F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=GNJ1obpC
Received: by mail-pj2-f21.google.com with SMTP id
 d9443c01a7336-2d747f0b25dso36591135ad.2
        for <alsa-devel@alsa-project.org>;
 Mon, 21 Sep 2026 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790019483; x=1790624283;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aowiel30ampr5Np1wAm1rSTNGQWP2GBWcWmQbn6pvmU=;
        b=GNJ1obpCkMtZ4pABIoXFaxFNy+B9e0xnSFVWz+4Uysh6DZB+5FJDmyf0P09zNc/HL3
         agQf6V+LS6yp8EYs0GPTqdh1rSLwkMY5gSfnMZfDP9dtBtbmum/QLEScKdIDaeVYhamU
         WeRbbxszupOA7zg10COxSW3EopCikGpVtcxcMfQGZCpaT+60NEXQpEi6ois9Ine/yWRb
         LlZXBsU8lG+HooJAr4iFGk27eKMuTmJjmbfmH/uhWYRa6KwILenJ3RH+QI1dJBDmW3EL
         /vOl3tEYU/Neumuf++zTYxCrTQCOabGiDjiAUbF2RCmkdBebkSJkKMNZI/JJNcUPovHb
         g2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019483; x=1790624283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aowiel30ampr5Np1wAm1rSTNGQWP2GBWcWmQbn6pvmU=;
        b=bQf+KH0yZVomiFk5Md/D/5LofxckGEAOgn91UgZzX4uBP3yD6wO77v6Sa+dYb5Eeb1
         WERQ1dMUB1sfJimayTsUElfndr0tY3qHTQ9tiAOBPP/saEImq2Img1dfNjXAzIp2HDdP
         1x9cOi0cLqSy3+/VQebiVE5Fxi9AQUzy4UibWt7RXrI9LliC8oJIL2mmkcIzGA7R5163
         j+S2XImFsDRZ9apQkeaJWw3UaqR9+suXXNKt6/OZfrIgwkY3hIy+Guv47fqKfd0UUNh4
         dhWIzP7bulqItXTTfEwkk+SU4gCylLbqkJ45muHLkZ2BOYni3nmss7Mg+myLWEPBYkmG
         Ge7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9gtOek+hJqZ5sEjoOlEKjm0emlk8CMj60y7Mn+Dkgvg8i5dLo1CGaKe5AmrP8y/OAIe2+rxtfTESo@alsa-project.org
X-Gm-Message-State: AFuF++nvfGjO4+0zCH60yJBkMK7hn0SLJ7d76UG/RB4UPbxExg2CfOl0
	B7q9eG1jZkHk095ULmcr9w9KZm8jPqoJjEvW6tTkwetl4ZTGuSPjEvjLlqr5G7vggZg=
X-Gm-Gg: AYBFou3dhcML8bM9ZBtwbrYQxm13o50AgZd+T2cK84s5qbdB2hUMjWR6AYPR99pJqIl
	VHOthuTT7tVl+/eOvQt5aQQMuUwMhP1/peTf9DemjHuSRkb9VKpOQpMoJyr3LJMpOF8eBkDbEpf
	9GVRDKBrWto41gCxOBSGhRI1c7n0kxXHhasJf/IZb54KskG1m52pXqekx9EFyCAcAGkj3VnmOB9
	h9E+K9Q3DUBc1cX8egiMIzCRnHoTc2GKDfoKurQJ5k0UQ8JH47QpHMx5q477xk3+FCKETcCw9LA
	keDmNY9He1bPWcBKyXqCoQAhJSpH0lU2HB9qCbyUmUs8hedD12YaN1re3ce+tCMk2I90XofleAb
	oY7GirmAoFhD7X3avjCJJf1vmk1Zhu5cHlhkrNoC+QnBWTamRZlsFbVkuF7CHYU0w+7WWMtFkTc
	zYVJiCd/a+lgwcIxjON/6RRf3l0FxYKQMoULp+VG+ZHbZeiDttQ2b+zDAfys0eywlTPgRw3fvKM
	qgmanvtGUnVBYhbwzvTezDosuEa8Yd0wVf9AHG1qAD6Ri8XEKi+NiYYSEttFJ8KAPv1GAILaL36
	0KMd+A==
X-Received: by 2002:a17:903:bcf:b0:2dd:c100:3141 with SMTP id
 d9443c01a7336-2ddc100323cmr76353145ad.61.1790019483005;
        Mon, 21 Sep 2026 12:38:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e5ebcdbd8sm288500eec.16.2026.09.21.12.38.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 12:38:02 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 6.1.y 2/2] ASoC: SOF: ipc4-topology: Clarify bind failure
 caused by missing fw_module
Date: Mon, 21 Sep 2026 15:37:48 -0400
Message-ID: <20260921193750.82134-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921193750.82134-1-artem@trailofbits.com>
References: <20260921193750.82134-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: artem@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JEB667OUGFP6HYX6FKWE2W5A5QADX7MZ
X-Message-ID-Hash: JEB667OUGFP6HYX6FKWE2W5A5QADX7MZ
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:43 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JEB667OUGFP6HYX6FKWE2W5A5QADX7MZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit de6aa72b265b72bca2b1897d5000c8f0147d3157 ]

The original patch uses a feature in lib/vsprintf.c to handle the invalid
address when tring to print *_fw_module->man4_module_entry.name when the
*rc_fw_module is NULL.
This case is handled by check_pointer_msg() internally and turns the
invalid pointer to '(efault)' for printing but it is hiding useful
information about the circumstances. Change the print to emmit the name
of the widget and a note on which side's fw_module is missing.

Fixes: e3720f92e023 ("ASoC: SOF: avoid a NULL dereference with unsupported widgets")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/alsa-devel/4826f662-42f0-4a82-ba32-8bf5f8a03256@kili.mountain/
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Link: https://lore.kernel.org/r/20230403090909.18233-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

[ Backport to 6.1.y follow-up to e3720f92e023: replace its (efault)
  pointer formatting with source/sink diagnostics; only hunk locations
  differ. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 2/2 in the CVE-2023-54233 series for Linux
6.1.y.

CVE: CVE-2023-54233

Build: This patch was included in the x86_64 allmodconfig and
CONFIG_WERROR=y build.

 sound/soc/sof/ipc4-topology.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 9540ba6ef659e6..ee6f6edec970c4 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1601,10 +1601,12 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 	int ret;
 
 	if (!src_fw_module || !sink_fw_module) {
-		/* The NULL module will print as "(efault)" */
-		dev_err(sdev->dev, "source %s or sink %s widget weren't set up properly\n",
-			src_fw_module->man4_module_entry.name,
-			sink_fw_module->man4_module_entry.name);
+		dev_err(sdev->dev,
+			"cannot bind %s -> %s, no firmware module for: %s%s\n",
+			src_widget->widget->name, sink_widget->widget->name,
+			src_fw_module ? "" : " source",
+			sink_fw_module ? "" : " sink");
+
 		return -ENODEV;
 	}
 
-- 
2.39.5

