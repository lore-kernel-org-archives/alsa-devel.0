Return-Path: <SRS0=TxyJ=FA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEFAC63798
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 20:31:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23128206B2
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tz3Zv6QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23128206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1E52181C;
	Thu, 26 Nov 2020 21:30:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1E52181C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606422706;
	bh=JdjRRP83vUTON3OwZR0E2PJHRjkYoVWgMMvl+UbXe+I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tz3Zv6QBVT2J2E1j+KAcVmEzAAPAEURAIy4dY2gL+2F+z+4rGX8Q2wXX0LPFX4FrR
	 dYO+twVYNN93DDBlmc/RiM3/NTLi/pZlylN/TZ7Do//J1nKwly9QRILt6YoF+9d8dE
	 plmXHtRjPO2qq0zrMk3JUchsBgTcV2NN8yF0L8Ho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58A52F80128;
	Thu, 26 Nov 2020 21:30:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0C8FF8026F; Thu, 26 Nov 2020 21:30:39 +0100 (CET)
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
 by alsa1.perex.cz (Postfix) with ESMTP id C1AABF80166
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2020 21:30:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1AABF80166
Received: from localhost (118.130.77.188.dynamic.jazztel.es [188.77.130.118])
 by iodev.co.uk (Postfix) with ESMTPSA id 92B6A154FC;
 Thu, 26 Nov 2020 21:30:32 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: alsa-devel@alsa-project.org
Subject: [PATCH] configure: Replace PKG_CONFIG calls with PKG_CHECK_VAR
Date: Thu, 26 Nov 2020 21:30:53 +0100
Message-Id: <20201126203053.12028-1-ismael@iodev.co.uk>
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

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 configure.ac | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 29d043f18950..8e130b3f0775 100644
--- a/configure.ac
+++ b/configure.ac
@@ -204,12 +204,8 @@ AC_ARG_WITH(
         [udev-rules-dir],
         AS_HELP_STRING([--with-udev-rules-dir=DIR],[Directory where to install udev rules to (default=auto)]),
         [udevrulesdir="$withval"],
-        [udevdir=$($PKG_CONFIG udev --variable=udevdir)
-        if test "x$udevdir" = "x"; then
-            udevrulesdir="/lib/udev/rules.d"
-        else
-            udevrulesdir="$udevdir/rules.d"
-        fi])
+        [PKG_CHECK_VAR([udevdir], [udev], [udevdir])
+	 udevrulesdir="${udevdir:-/lib/udev}/rules.d"])
 AC_SUBST(udevrulesdir)
 
 dnl Checks for header files.
@@ -404,10 +400,10 @@ PKG_CHECK_MODULES(SYSTEMD, [systemd >= 18],
         [have_min_systemd="no"])
 AC_ARG_WITH([systemdsystemunitdir],
         AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
-        [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
-if test "x$with_systemdsystemunitdir" != xno; then
-        AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
-fi
+        [], [PKG_CHECK_VAR([with_systemdsystemunitdir], [systemd], [systemdsystemunitdir])])
+AS_IF([test "x$with_systemdsystemunitdir" != xno],
+	[AC_SUBST([systemdsystemunitdir], ["$with_systemdsystemunitdir"])])
+
 AM_CONDITIONAL(HAVE_SYSTEMD, [test "$have_min_systemd" = "yes" \
         -a -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != xno ])
 
-- 
2.28.0

