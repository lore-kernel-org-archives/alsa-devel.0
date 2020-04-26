Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A89C54FD0
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:09:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97002071C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bEPrMHe0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj/j+alN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97002071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 262971685;
	Sun, 26 Apr 2020 14:08:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 262971685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587902986;
	bh=XDpMHwBcGzmbahFifUcoRQJHhGrmxinsZLq8d75mhRc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEPrMHe0yhJPgXRpNVWLKVcb3r+wtpxNHSgvQHqsjPs2XifRA6jtMtTV+p5yiRqVQ
	 UUE0WdWAuzbijkCW6AT4F5uAgetkXmsKdtzY0MpRQYSCIDHdVhPqai48lSOjI3MwUq
	 SEEjzuZvDaLdzQ1TTp2voeYqz/dihDGqyC+YDfLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C426F802C2;
	Sun, 26 Apr 2020 14:05:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7885F802A1; Sun, 26 Apr 2020 14:05:00 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57396F8028D
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 14:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57396F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fj/j+alN"
Received: by mail-wr1-x443.google.com with SMTP id b11so17110936wrs.6
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z8FDkpOterxD+ozyNdLEoNF3qT9jBBj9bIEzb2R8YME=;
 b=fj/j+alN0ho486l2Xz+rdD9b30m8p8mXtuFuh2lwyX8YqLrZzmlPAFICA/fEmYP9up
 txwyM/no0xzoHKZv8vLBqLNm0L6ZjHdTJR567yserWGOboO5uoweSdKKhCu1O35jbgQw
 4/HD6uzHbX7eTVLyX7mZoqMK9hJYBOOs7EtR1EPQz+n08DG2hxoOxXKL4WTopWPRs+rk
 fcbglCm54D1DlxcBAm1/WtqtWXIqXUSvWylf2MtfJN9xnJs7FUqIxGqTdUX2JQNBKrNT
 gm9wqwGlHHvSd9dqp9grtSLZbWRl48ZqdQhVTvWrogeXsw5zHtGS050Fux8AsP3VCx/m
 Ec1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z8FDkpOterxD+ozyNdLEoNF3qT9jBBj9bIEzb2R8YME=;
 b=PX62tdSKVwabTWvA3UtfwFUNfXNcSGEjiphcyje8MDAIw1m7YnAkP4Nrtbo15tUNgL
 7lGMVQM41KyhZcRtfJtMSEvTS8FL1do6Bal9oQid7bwdBSZPqWXa9OdsqIudli+4tUmk
 3nX2xJNZ6K0OeGKD24eihqrVH41OB5UGO6m/TCa3KPLUsZ6lMA/kbl1iKDdp0hd3PuZq
 3Qf2jJowmuT4OU2Mh9Ml8ertpudrOUc76t/WKpMO93BIhiFBouFirUCLfa6pTsYtmn1p
 EdLH5UVZgOPE+Fp7wQzlkM+D9B/UcNlhRKH0JH18yugz4zfG38S4tdEYQOL96hPpZAx1
 w2VA==
X-Gm-Message-State: AGi0PuZpPbbwiKSnQ4jHjeF1vQjFjm/2Vs9zhhTNcokKWcsi144huPMl
 FsV10Em8gUd0WHYdWcMIFTA=
X-Google-Smtp-Source: APiQypJX89nzq607NY5Wjke/a1jEcpgbysZ4fzF+10u5wlKe8WSHjdGr0Jt93SXlggAfwNVrkI4RBQ==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr21231497wrw.170.1587902694276; 
 Sun, 26 Apr 2020 05:04:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
 by smtp.gmail.com with ESMTPSA id
 s24sm11120026wmj.28.2020.04.26.05.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2020 05:04:53 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 7/7] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date: Sun, 26 Apr 2020 14:04:42 +0200
Message-Id: <20200426120442.11560-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..c5939ba52f19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.20.1

