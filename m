Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420CC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567D520720
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X+07+kiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567D520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E743718E6;
	Thu, 25 Jun 2020 14:08:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E743718E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593086951;
	bh=EZryfd/5vIba/NjhnW0kIE8f6OzJvEk9RpCrrki5dAY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+07+kiBpjzDJHGWMO1D0LjtKUZOxkrcD3Dp5t3f/MX1b5i0turJ+AzXxoZMOOBgG
	 WqquHwil4rfbEEE/v+9uSpsi4eTibzRItzfiZjCf7Df7sTizU4+J2ZXlHqVsJoyNSe
	 LIcfsWncMltG64O4o9QIRew4cNRbNgup+PksBNE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3032F802A8;
	Thu, 25 Jun 2020 14:05:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D88B8F802A9; Thu, 25 Jun 2020 14:05:54 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 637D8F80249
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 14:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 637D8F80249
IronPort-SDR: vO5MeeSu00uvab3yZ4Nii7zXRrJVRN/xN8wcd6aEK+4Jt8d4rsTRQS7Qr6tdYsq0f/9K/a8nuJ
 ilQoWEt7rJbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206389938"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="206389938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:05:42 -0700
IronPort-SDR: VeGqjCH9wKlrhIsIm5KW2dueswOFm12zVruaJPAqGuDgCdIZfR0VBj8jr80aZTHYcXL/Jz/Zk2
 rgAk7LRIStPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="354438967"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga001.jf.intel.com with ESMTP; 25 Jun 2020 05:05:40 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 6/8] topology: decode: Print sig_bits field in PCM
 capabilities section
Date: Thu, 25 Jun 2020 13:03:44 +0200
Message-Id: <1593083026-7501-6-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593083026-7501-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1593083026-7501-1-git-send-email-piotrx.maziarz@linux.intel.com>
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
to UML.

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

