Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C448C10F05
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Dec 2023 16:47:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 495ECFA;
	Wed,  6 Dec 2023 17:47:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 495ECFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701881234;
	bh=KgK0s07smJ0z+t29MyPrHJyPRjk4cYnj7u9zG1Bef6k=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZQOM3R6UQ7YidUs4BdgePQcBuLi1k5JTxXNGoimxdW3r75PwKzJToWx8ZbWcTOusk
	 WiYPBxZQj4R54bRPaZ3q5kvDhW+yfsL3uP5vTvOxDfF18D76zJM8lV7SPD0BcMC/vp
	 upAbHzd9bzB3a6SghciA9QUodQKCfp36rCnoRS+M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D78CF805A9; Wed,  6 Dec 2023 17:46:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93FAAF80580;
	Wed,  6 Dec 2023 17:46:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CE7AF8025A; Wed,  6 Dec 2023 17:46:25 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0093AF800D2
	for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2023 17:46:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0093AF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=mGd9k0kU
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3B69KGTN027934;
	Wed, 6 Dec 2023 10:46:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=q
	Xrd+BJtW6qu8RfgCScI0xgLBhJNrXZA2bPZfW0VyGg=; b=mGd9k0kUI/EWaYCOs
	GL1rlg/LgOt+n7+pSlV8VzXqq5ETLYr0FTiP7HEC9AHt6duYiaFodYANFSVclTd0
	qnrTnHeJe3xPF3GeuMXQ6F29gOElzEYRDfc8plXP0bxAvExA7wdm0yV0V32A/f1z
	rn+W+x2bxOONjj0hnfudz10S3ILmwKsBybsx2Z32NmfAnh3kXAGb/TBNhkhou3OQ
	zLR77sfeguy6BZadrACO1W828OmTufDL9G7+3Ig/0lsDQMIyKSonp1VaAHao0vS2
	fBvInxxFFBwhE5d40IfPf1+HxjsEeDliy3CansRid4re0BROssKPA1gcCqJF6fo6
	nPMYg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3utd1w90bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 10:46:14 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 16:46:12 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 6 Dec 2023 16:46:12 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 263A811D1;
	Wed,  6 Dec 2023 16:46:12 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <perex@perex.cz>
CC: <pierre-louis.bossart@linux.intel.com>, <bard.liao@intel.com>,
        <mengdong.lin@intel.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH alsa-ucm-conf v3 1/2] sof-soundwire: Add basic support for
 cs42l43
Date: Wed, 6 Dec 2023 16:46:11 +0000
Message-ID: <20231206164612.1362203-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BOiNNdRkYm5PNG3tLpLIvLqgnDc-YYZ9
X-Proofpoint-ORIG-GUID: BOiNNdRkYm5PNG3tLpLIvLqgnDc-YYZ9
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: SLWEN36FV4XVN3RW65BZZP3AHXADEGR6
X-Message-ID-Hash: SLWEN36FV4XVN3RW65BZZP3AHXADEGR6
X-MailFrom: prvs=77042597b4=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SLWEN36FV4XVN3RW65BZZP3AHXADEGR6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

cs42l43 is a codec device, add basic support for it. Including a dual
channel DMIC input, stereo headphones, and a mono headset microphone.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 ucm2/sof-soundwire/cs42l43-dmic.conf | 28 +++++++++++++++++
 ucm2/sof-soundwire/cs42l43.conf      | 47 ++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 ucm2/sof-soundwire/cs42l43-dmic.conf
 create mode 100644 ucm2/sof-soundwire/cs42l43.conf

diff --git a/ucm2/sof-soundwire/cs42l43-dmic.conf b/ucm2/sof-soundwire/cs42l43-dmic.conf
new file mode 100644
index 0000000..bf59eca
--- /dev/null
+++ b/ucm2/sof-soundwire/cs42l43-dmic.conf
@@ -0,0 +1,28 @@
+# Use case Configuration for sof-soundwire card
+
+SectionDevice."Mic" {
+	Comment "Microphones"
+
+	ConflictingDevice [
+		"Headset"
+	]
+
+	EnableSequence [
+		cset "name='cs42l43 DP1TX1 Input' 'Decimator 3'"
+		cset "name='cs42l43 DP1TX2 Input' 'Decimator 4'"
+		cset "name='cs42l43 Decimator 3 Switch' on"
+		cset "name='cs42l43 Decimator 4 Switch' on"
+	]
+
+	DisableSequence [
+		cset "name='cs42l43 Decimator 3 Switch' off"
+		cset "name='cs42l43 Decimator 4 Switch' off"
+		cset "name='cs42l43 DP1TX1 Input' 'None'"
+		cset "name='cs42l43 DP1TX2 Input' 'None'"
+	]
+
+	Value {
+		CapturePriority 100
+		CapturePCM "hw:${CardId},4"
+	}
+}
diff --git a/ucm2/sof-soundwire/cs42l43.conf b/ucm2/sof-soundwire/cs42l43.conf
new file mode 100644
index 0000000..378dbb2
--- /dev/null
+++ b/ucm2/sof-soundwire/cs42l43.conf
@@ -0,0 +1,47 @@
+# Use case Configuration for sof-soundwire card
+
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	EnableSequence [
+		cset "name='cs42l43 Headphone L Input 1' 'DP5RX1'"
+		cset "name='cs42l43 Headphone R Input 1' 'DP5RX2'"
+	]
+
+	DisableSequence [
+		cset "name='cs42l43 Headphone L Input 1' 'None'"
+		cset "name='cs42l43 Headphone R Input 1' 'None'"
+	]
+
+	Value {
+		PlaybackPriority 200
+		PlaybackPCM "hw:${CardId},0"
+		PlaybackVolume "cs42l43 Headphone Digital Volume"
+		JackControl "Headphone Jack"
+	}
+}
+
+SectionDevice."Headset" {
+	Comment "Headset Microphone"
+
+	EnableSequence [
+		cset "name='cs42l43 ADC1 Input' 'IN1'"
+		cset "name='cs42l43 Decimator 1 Mode' 'ADC'"
+
+		cset "name='cs42l43 DP1TX1 Input' 'Decimator 1'"
+		cset "name='cs42l43 DP1TX2 Input' 'Decimator 1'"
+	]
+
+	DisableSequence [
+		cset "name='cs42l43 DP1TX1 Input' 'None'"
+		cset "name='cs42l43 DP1TX2 Input' 'None'"
+	]
+
+	Value {
+		CapturePriority 200
+		CapturePCM "hw:${CardId},4"
+		CaptureVolume "cs42l43 Decimator 1 Volume"
+		CaptureSwitch "cs42l43 Decimator 1 Switch"
+		JackControl "Headset Mic Jack"
+	}
+}
-- 
2.39.2

