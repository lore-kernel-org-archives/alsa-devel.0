Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D90EC27C55
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:32:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD84D852;
	Mon, 10 Jun 2024 17:32:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD84D852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718033536;
	bh=quN3GCu727mkYwNqw2GpV6NVVObYioBkxAul5I2vmcY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HHejG18nFqxHkEUTd4w0f1zMC+/MeLA31urfk2J4hxdPWnLEu3O2Iy0+As8SOfcxj
	 n9JRgezuLykJAW3gs468HeV6+gkrOjPNbb6b/bl8oObkO4ypyf6nhKUsaPoODtinNn
	 dHQ77iMhqkCvorEtAfukJPl0AwjeOdtGjS3INaWY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCE62F80587; Mon, 10 Jun 2024 17:31:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E3D1FF805BE;
	Mon, 10 Jun 2024 17:31:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31B19F80580; Mon, 10 Jun 2024 17:31:38 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F314F80448
	for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2024 17:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F314F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=GGB/tdz9
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 45AEOUoD024008;
	Mon, 10 Jun 2024 10:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=NAQiw9Lfn5b4wkQDfb7cAGW02PiLIbTJ52todkMah9A=; b=
	GGB/tdz9Dsas8EwC4/AEYYeLrptM/V3iSIuPtjBvtr5TBm/0DkV4PQ2J5fqFoXtL
	J55OBFO9zzFX64kNVc2tahtjLoQuBPrqYiCP8toeslyOkZ+bRfJupEwpcHro5ly6
	ACHnnKCaMQccjcA+MREdL7LFlWYjpT+2rXCm6SGRU7N5AA4kaXmE2VJfjhKjBTyy
	ZhloJZyoNKH1x2OIcP+9beyMV/2DT2zqJJEDkdCgIX+h7ejf2k/nFSd9C/NkpuB0
	IVpS0wZ1wuorfkg0yN7kfIL8ZGE4Wi+Uzsn67b+WkAL3WJkz94kFff5REr1GQ6za
	+fCrrrGsJRg48Dvc8j/YHQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhsu8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:31:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 16:31:24 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 10 Jun 2024 16:31:24 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com
 [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C92F982F2A2;
	Mon, 10 Jun 2024 15:31:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <perex@perex.cz>
CC: <pierre-louis.bossart@linux.intel.com>, <bard.liao@intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH 2/2] sof-soundwire: Add support for cs42l43/cs35l56 bridge
 configuration
Date: Mon, 10 Jun 2024 16:31:24 +0100
Message-ID: <20240610153124.1329052-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610153124.1329052-1-ckeepax@opensource.cirrus.com>
References: <20240610153124.1329052-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SMD9oyIG2ZCEdUKqeqQS8jKspMA6NfIb
X-Proofpoint-ORIG-GUID: SMD9oyIG2ZCEdUKqeqQS8jKspMA6NfIb
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: ORZ5VEENF7N556XXIRLASZSNQKPHCZ3E
X-Message-ID-Hash: ORZ5VEENF7N556XXIRLASZSNQKPHCZ3E
X-MailFrom: prvs=3891f53e6a=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ORZ5VEENF7N556XXIRLASZSNQKPHCZ3E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The cs42l43 has both a SPI master and an I2S interface, in some
configurations 2 cs35l56 amplifiers are connected to these to provide
bass speakers whilst the cs42l43's internal speaker drivers are used for
the tweeters. Add UCM configuration for this type of system.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 ucm2/sof-soundwire/cs35l56-bridge.conf | 61 ++++++++++++++++++++++++++
 ucm2/sof-soundwire/sof-soundwire.conf  |  2 +-
 2 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 ucm2/sof-soundwire/cs35l56-bridge.conf

diff --git a/ucm2/sof-soundwire/cs35l56-bridge.conf b/ucm2/sof-soundwire/cs35l56-bridge.conf
new file mode 100644
index 0000000..6fafc80
--- /dev/null
+++ b/ucm2/sof-soundwire/cs35l56-bridge.conf
@@ -0,0 +1,61 @@
+# Use case Configuration for sof-soundwire card
+
+LibraryConfig.remap.Config {
+	ctl.default.map {
+		"name='cs42l43 Bridge Switch'" {
+			"name='AMPL Speaker Switch'".vindex.0 0
+			"name='AMPR Speaker Switch'".vindex.1 0
+		}
+		"name='cs42l43 Bridge Volume'" {
+			"name='AMPL Speaker Volume'".vindex.0 0
+			"name='AMPR Speaker Volume'".vindex.1 0
+		}
+	}
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	ConflictingDevice [
+		"Headphones"
+	]
+
+	EnableSequence [
+		cset "name='cs42l43 Speaker L Input 1' 'ASPRX1'"
+		cset "name='cs42l43 Speaker R Input 1' 'ASPRX2'"
+		cset "name='cs42l43 ASPTX1 Input' 'DP5RX1'"
+		cset "name='cs42l43 ASPTX2 Input' 'DP5RX2'"
+
+		cset "name='AMPL ASP1 TX1 Source' 'DSP1TX1'"
+		cset "name='AMPL ASP1 TX2 Source' 'None'"
+		cset "name='AMPL ASP1 TX3 Source' 'None'"
+		cset "name='AMPL ASP1 TX4 Source' 'None'"
+
+		cset "name='AMPR ASP1 TX1 Source' 'None'"
+		cset "name='AMPR ASP1 TX2 Source' 'DSP1TX1'"
+		cset "name='AMPR ASP1 TX3 Source' 'None'"
+		cset "name='AMPR ASP1 TX4 Source' 'None'"
+
+		cset "name='cs42l43 Speaker Digital Switch' 1"
+		cset "name='cs42l43 Speaker Digital Volume' 128"
+	]
+
+	DisableSequence [
+		cset "name='cs42l43 Speaker Digital Switch' 0"
+
+		cset "name='AMPL ASP1 TX2 Source' 'None'"
+		cset "name='AMPR ASP1 TX1 Source' 'None'"
+
+		cset "name='cs42l43 ASPTX1 Input' 'None'"
+		cset "name='cs42l43 ASPTX2 Input' 'None'"
+		cset "name='cs42l43 Speaker L Input 1' 'None'"
+		cset "name='cs42l43 Speaker R Input 1' 'None'"
+	]
+
+	Value {
+		PlaybackPriority 100
+		PlaybackPCM "hw:${CardId},0"
+		PlaybackMixer "default:${CardId}"
+		PlaybackMixerElem "cs42l43 Bridge"
+	}
+}
diff --git a/ucm2/sof-soundwire/sof-soundwire.conf b/ucm2/sof-soundwire/sof-soundwire.conf
index 2f61d11..2ede1cd 100644
--- a/ucm2/sof-soundwire/sof-soundwire.conf
+++ b/ucm2/sof-soundwire/sof-soundwire.conf
@@ -21,7 +21,7 @@ Define {
 
 DefineRegex {
 	SpeakerCodec {
-		Regex " spk:([a-z0-9]+((-sdca)|(-spk))?)"
+		Regex " spk:([a-z0-9]+((-sdca)|(-spk)|(-bridge))?)"
 		String "${CardComponents}"
 	}
 	SpeakerChannels {
-- 
2.39.2

