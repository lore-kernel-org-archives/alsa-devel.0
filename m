Return-Path: <SRS0=TxyJ=FA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C1C63777
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 20:31:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662BC21D7F
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 20:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tH7fqRaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662BC21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D24B617DC;
	Thu, 26 Nov 2020 21:30:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D24B617DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606422655;
	bh=FZDjzFlewa4Y22amdkR3/EA2GrbazqN5CQSYfokcpII=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tH7fqRaKvhlH1ST1DfncblIBCevKqY0LDjLh50yTcz7nO3/y8kDKQIcdGzqpTxEla
	 FFnrp+MVFnS+RLwXjSsSD1Hj3D/zWKg1KMokzvtlo0NHc5cVm0W8VV0nEZ6sUJhxb/
	 Lj+DRAtww7zgV9AE9ThS9k7UZX6eNDaojRtxMrAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 641E5F800EA;
	Thu, 26 Nov 2020 21:30:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F687F80165; Thu, 26 Nov 2020 21:30:04 +0100 (CET)
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
 by alsa1.perex.cz (Postfix) with ESMTP id 3B394F800EA
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2020 21:29:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B394F800EA
Received: from localhost (118.130.77.188.dynamic.jazztel.es [188.77.130.118])
 by iodev.co.uk (Postfix) with ESMTPSA id 330E6154FB;
 Thu, 26 Nov 2020 21:29:54 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: alsa-devel@alsa-project.org
Subject: [PATCH] configure: Improve failures due to missing pkg-config
Date: Thu, 26 Nov 2020 21:30:17 +0100
Message-Id: <20201126203017.11936-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ismael Luceno <ismael@iodev.co.uk>
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

Output a warning at the beginning, and fill PKG_CONFIG with "false" so
that any auto-configuration attempts fail without bogus messages.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1f119c5baeeb..29d043f18950 100644
--- a/configure.ac
+++ b/configure.ac
@@ -19,6 +19,9 @@ AC_PROG_MKDIR_P
 AC_PROG_LN_S
 AC_PROG_SED
 PKG_PROG_PKG_CONFIG
+AS_IF([test -z "$PKG_CONFIG"],
+  [AC_MSG_WARN([pkg-config is needed for auto-configuration of dependencies])
+   PKG_CONFIG=false])
 AM_PATH_ALSA(1.0.27)
 if test "x$enable_alsatest" = "xyes"; then
 AC_CHECK_FUNC([snd_ctl_elem_add_enumerated],
-- 
2.28.0

