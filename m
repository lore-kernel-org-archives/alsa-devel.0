Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0125FCA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:07:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F05B60284;
	Tue, 29 Sep 2026 21:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F05B60284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708848;
	bh=+WF0ufBR+LDxG6agMdm+AutmEyBysbg4FlgD0FxUJno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=blEt1k/lDl3JHaZWySrfchYt0H9bbZTEGB72pHm8Zw1RDyZirJTmjwde//qIui2+z
	 HSBfEZgZ8/G/d+oVGs6nPgzvPmglfZvD0hEm0fgY0GbpFGDwSPzpdAFAz9DsECAKDL
	 d6GQv11cQU/vDRyMWG9k+R3YD4VJYNJkgT/fQakk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B287F80722; Tue, 29 Sep 2026 21:05:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C1DDF8071F;
	Tue, 29 Sep 2026 21:05:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2E02F805B2; Mon, 21 Sep 2026 21:38:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.228.43
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790019483;
	b=gMzjcwmd5lCSrOecsUGUVGe7VlOYkSTdmVPJfVraluvUk0qG/bt6V4XsdrihDyhXPCrI
	 OSluahB9AQdrJnyZw7RJTh9JHnK4IB8DoMLMAibALl3TAj9AGF4Z84x4RzIQBYDncqMjR
	 E9yClAD5jVL4tTnNjxOuRxJwfJSgqjCWGbXuc87bgLxMPTM8aEQT4dGWqrEJfD1Ul8ol1
	 Ru1AJFD1TyxoYpLM47XYogWjy5lj3+k3qGuAhnI+mDKA1mI7E9UK1rN4v2iFOTuBjz/C+
	 RktS4rYiuvilxCKZHst+2XycCiu+RXO8OoFb6Hipteyh4YHglN65tdI1FlcymGPgjng==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790019483;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+WF0ufBR+LDxG6agMdm+AutmEyBysbg4FlgD0FxUJno=;
	b=cWurbPkKPy2fDVO1zKSTt3SobfZfPVCdtMNBApqowPf3io/fLHJ49U5ti4hgvmtnTiY5
	 0DpfjYzyW3IfSHWPmajlArkhQiwG2ZkQoPM2PU0Pj+PMVa7BVZ3sf2Y8wsZMxWDiTn4ic
	 HCThUPutNFfv9F5m4X2n14wWPpxC0OViR5oN5BdI0ojg4twLHGBhBBM8lnZhtTGSVhy8M
	 v8H/0Ko4NKjpxcD1Bx1K1hAai1C4nvChRiUwtinycbt+C6wdI99XznlQoMC78axO75/88
	 CvhBfa8mTW/0vd79oJGkOCS3N9ox4GJoHRIqBau3nfGuIxtk0Mn+taSyGjfWC7c6EPg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=g8Okf0hF;
	arc=none smtp.remote-ip=74.125.228.43
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C43FFF800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 21:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C43FFF800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=g8Okf0hF
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2930182b3a.1
        for <alsa-devel@alsa-project.org>;
 Mon, 21 Sep 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790019480; x=1790624280;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38v0xzft1ji55CfZ4GZ3Vuw4C0dyByFRbLq8VXUI3wE=;
        b=g8Okf0hFvdedsaNH2Ykxq9NUo1xgEI2E4wjy8eNbDhljl5SyB5ZRR5zMTuPKGTQYLj
         vZPyU9Ze6BlxF8xf8Dw9PMhnQ2k4cX9liGqIBQ6WPX8+y2u0+sKOz44INFs0TxP4hL4g
         X241OaA1CUQLjic+Ujd8fhtOoFGeZrorU2pRV0K5uKBM3eKldC9NrwXwE63m6eDkbeJM
         4LeaQ5BAqtxMr9mw7zOevBOVFvhqEq4+8oxp+CPdxjmPCUM+XsfM1/1ovZ3KZ7s7atm2
         KgWxj+lja2G+BldkY98ChZkCZXKQfs6OIoYHfSlyF+KhrH67AaYPw0vju8TaM2nbB9xt
         04pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019480; x=1790624280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=38v0xzft1ji55CfZ4GZ3Vuw4C0dyByFRbLq8VXUI3wE=;
        b=iO3+ySXRxmzOiJG9/QOB0pcGutvgzb0CBU4J5Sv6ZF4bqtepksDteG27w9zWNHj9n6
         c12+kQkK9QD3ZX7eBYuctpn4bhggVi/WqqK0yvZFqPa9LrHW7LqjHtC5VWjVQ3Ulp2wB
         9gi1HxY9MO256dqTrEWMkLWbPtMkaKQJ1vD+dODqdB4penAr/peybF76Ezg3xxEqyk7j
         Fw5hIj5ZsFjo8hQ12DNOx+lg5Moh52xcZTPWSaLbYocfW9+h8ofgo7heSOCki8SlR9QM
         uuZYzcqo1Ycwhqwsg2ZFksaooN3DHc0o+WdWf1vZpMZuIbCZ5BlW0AHVwbgPDyBeP62J
         Y4Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByU15CDM0CU/iL3G36eb1ZITzxuseIniOspdNNOdxzZ3mu1kmTs9YdEy/3oVTm47SfhVGniE3iXaKEi@alsa-project.org
X-Gm-Message-State: AFuF++lNC20vEse59+ekumi3X8LWzP7HhKmKpznkAddh7wZTxPrVwPWp
	452svxeoLTYgrU/ZD8a9RbdKkOZoUKZd+JcBMMEMUf6EWfgOYysAVZLrJfnKkSBiv3I=
X-Gm-Gg: AYBFou2+eYsPuU6QO6pq/AZaYMTLIeNHlxWSdqS0bYLbFCLo7OnjDbBPPLMIGAwXu/0
	HDnwKHZ0yQKwzRvzaqjcJzT91ByGQu+6pq5HyAjeNwmtV4t+rm/utHB7odLyQJdSt1DaYEdy0ey
	UZTYJdA0lnhheWMsg+1LAFzzfD22ctHIzB4N+fAl3Nu37dto1B7rGA3WrtAbVKux6HBQDlzM9mo
	EOvZe4I0k3jfEPVyEBTwaZKdWpLV2fXj/haWSLqzIduaSkC8ZoB2ChyXWKsDtv/cb8C6gFeHJGE
	KhcZbPwTuNB80amfBRdg4InBax8/aje8avfbp4jrbW0zFnl2W2EY5ME3HmlruKJb7aIDRYJl5ud
	dcwO7tctPXKE7SEXUBBPj5nNGy+jW9r8XybRHPO+ao9N3RAr9g1E7Mna3v1xMWAxozh/G4OaLKP
	I8irOQ5+snBUk9ksKd2r8GGAgcQ10wBXUA03MpkGcfheTvv47Mo8cC8gChodOIT+DB9AGawlXeR
	h85fq3c6EQjgie8wBUEyCKqrzQrWoWBTNCGZuhikSgWzT6HZ1ZSeuAgeW+VNDDiMDaxbhA=
X-Received: by 2002:a05:6a20:7289:b0:3dd:a196:5393 with SMTP id
 adf61e73a8af0-3dda1965464mr11523095637.53.1790019480599;
        Mon, 21 Sep 2026 12:38:00 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e5ebcdbd8sm288500eec.16.2026.09.21.12.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 12:38:00 -0700 (PDT)
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
Subject: [PATCH 6.1.y 1/2] ASoC: SOF: avoid a NULL dereference with
 unsupported widgets
Date: Mon, 21 Sep 2026 15:37:47 -0400
Message-ID: <20260921193750.82134-2-artem@trailofbits.com>
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
Message-ID-Hash: F4QJHEDGHGICWNMPCBR6L6MXXHLEV5BV
X-Message-ID-Hash: F4QJHEDGHGICWNMPCBR6L6MXXHLEV5BV
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:43 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F4QJHEDGHGICWNMPCBR6L6MXXHLEV5BV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

[ Upstream commit e3720f92e0237921da537e47a0b24e27899203f8 ]

If an IPC4 topology contains an unsupported widget, its .module_info
field won't be set, then sof_ipc4_route_setup() will cause a kernel
Oops trying to dereference it. Add a check for such cases.

Cc: stable@vger.kernel.org # 6.2
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230329113828.28562-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

[ Backport to 6.1.y: although the upstream stable tag names 6.2, the
  same module_info dereference is present here; the source change is
  otherwise unchanged. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 1/2 in the CVE-2023-54233 series for Linux
6.1.y.

CVE: CVE-2023-54233

Build: This patch was included in the x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and 9,075 modules; the same four baseline objtool
notices appeared, with no new warnings or errors.

 sound/soc/sof/ipc4-topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 49289932ba7e69..9540ba6ef659e6 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1600,6 +1600,14 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 	int dst_queue = 0;
 	int ret;
 
+	if (!src_fw_module || !sink_fw_module) {
+		/* The NULL module will print as "(efault)" */
+		dev_err(sdev->dev, "source %s or sink %s widget weren't set up properly\n",
+			src_fw_module->man4_module_entry.name,
+			sink_fw_module->man4_module_entry.name);
+		return -ENODEV;
+	}
+
 	dev_dbg(sdev->dev, "bind %s -> %s\n",
 		src_widget->widget->name, sink_widget->widget->name);
 
-- 
2.39.5

