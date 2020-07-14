Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB78BC433EA
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E63722453
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gD4kIzqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E63722453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E088C1674;
	Tue, 14 Jul 2020 14:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E088C1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594729959;
	bh=+U0deF3Up+U59ER9kXAys8W2xN/sFDNVkxRaIM29sH8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gD4kIzqUhxNCCh8xEjyT0ZR49noxkh0QAONgTUE20wV6WEQD2D5UCVK+IvpKZp2FV
	 00F+U0G8loj0Uo2pulBsC+32wuv6xt35CgW9mYoFsXsX+up/jAdbImfRCZa72XbmEw
	 qGGkQliAwYiAhnEBmODISdfMxiT9FAQMnc63cM84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 780E8F802F7;
	Tue, 14 Jul 2020 14:27:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92644F801F2; Tue, 14 Jul 2020 14:26:50 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88CBFF8016F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 14:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88CBFF8016F
IronPort-SDR: V4t1t8R4cTkS6Y1Z3L31SxV+SBihYyM4cPjt0Ng/ieTG/uA2+U1fvqHyLypgzFNmeqh/mkQgwH
 Pr0YJ2zGq9YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150304988"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="150304988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 05:26:36 -0700
IronPort-SDR: 5HuAMp/plJJsFyYpbfrs1orBC9TnFmSu4D14ZMzpdR5zdrTR4Yzo8kr8EwNsBZgffEWQvdyBwS
 Rk+4kGsiQeyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485860445"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 05:26:35 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 08/10] topology: decode: Print sig_bits field in PCM
 capabilities section
Date: Tue, 14 Jul 2020 13:25:09 +0200
Message-Id: <1594725911-14308-9-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

Not printing this field makes data loss while converting from binary
to standard ALSA configuration file.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
---
 src/topology/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index db40114..49c5eab 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -604,6 +604,9 @@ int tplg_save_stream_caps(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	if (err >= 0 && sc->buffer_size_max)
 		err = tplg_save_printf(dst, pfx, "\tbuffer_size_max %u\n",
 				       sc->buffer_size_max);
+	if (err >= 0 && sc->sig_bits)
+		err = tplg_save_printf(dst, pfx, "\tsig_bits %u\n",
+				       sc->sig_bits);
 	if (err >= 0)
 		err = tplg_save_printf(dst, pfx, "}\n");
 	return err;
-- 
2.7.4

