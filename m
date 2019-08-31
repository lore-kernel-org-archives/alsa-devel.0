Return-Path: <SRS0=OpZL=W3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24EC3A5A6
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:00:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6487322D37
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hjjuoBOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6487322D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F3EC1658;
	Sat, 31 Aug 2019 16:59:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F3EC1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567263644;
	bh=oV2xkcxZ9MMTqN05wG7NIgtGZuzsYqe+wnelwAunVrg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjjuoBOEyuenFrDWvLqn/j6+Am5ca/YdCVsmYL2OoRY/v4yWylgvQt4wlJ9INZGh/
	 bqFxRCplcCF4kff4TXrBwFoJBoU+pMWLtf6gemF67KsLjMcfpFWSnSL5Q7Ky5Nokvc
	 N0I2N1YTeWmsBrws6kbi/hqc+obSbZJASdlonRjg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3539DF802BC;
	Sat, 31 Aug 2019 16:59:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFA47F80268; Sat, 31 Aug 2019 16:58:55 +0200 (CEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48C64F800EA
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2019 16:58:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48C64F800EA
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B0495AFE3;
 Sat, 31 Aug 2019 14:58:47 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-39.ams2.redhat.com
 [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22CF25D9D5;
 Sat, 31 Aug 2019 14:58:45 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: alsa-devel@alsa-project.org
Date: Sat, 31 Aug 2019 16:58:42 +0200
Message-Id: <20190831145842.32990-2-hdegoede@redhat.com>
In-Reply-To: <20190831145842.32990-1-hdegoede@redhat.com>
References: <20190831145842.32990-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 31 Aug 2019 14:58:47 +0000 (UTC)
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/2] conf/ucm: cht-bsw-rt5672: Add board
	specific profile for Lenovo Thinkpad 8 tablet
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190831145842.7PyKG0OHjTCX8wBzkQAgDL7CzYUMGsOhQFGmi_XCX5s@z>

The Lenovo Thinkpad 8 tablet has stereo speakers and its internal DMIC
on DMIC1, at a device specific profile for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  1 +
 .../HiFi.conf                                 | 23 +++++++++++++++++++
 ...ENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf |  4 ++++
 .../Makefile.am                               |  4 ++++
 src/conf/ucm/Makefile.am                      |  1 +
 5 files changed, 33 insertions(+)
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am

diff --git a/configure.ac b/configure.ac
index 9ccca7aa..778bc64e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -756,6 +756,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/kblrt5660/Makefile \
+	  src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile \
 	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
new file mode 100644
index 00000000..43c3c0dd
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:chtbswrt5672"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5672/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:chtbswrt5672"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:chtbswrt5672"
+		CapturePCM "hw:chtbswrt5672"
+	}
+}
+
+<codecs/rt5672/Speaker.conf>
+<codecs/rt5672/HeadPhones.conf>
+
+<codecs/rt5672/DMIC2.conf>
+<codecs/rt5672/HeadsetMic.conf>
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
new file mode 100644
index 00000000..1c3a766b
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
@@ -0,0 +1,4 @@
+SectionUseCase."HiFi" {
+	File "../LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am
new file mode 100644
index 00000000..842409e8
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE
+ucm_DATA = LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 2ed4e1a3..7bb8eb1d 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -40,6 +40,7 @@ gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 kblrt5660 \
+LENOVO-20BN002QGE-ThinkPad8-20BN002QGE \
 LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
 PandaBoard \
 PandaBoardES \
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
