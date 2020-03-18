Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D504BC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:26:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF5A2077B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l3aXou5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF5A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAED71750;
	Wed, 18 Mar 2020 11:25:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAED71750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584527209;
	bh=UYBIff4Hu5VaDWZwzPUc1C/PQHQe2bZqXoS4sik0Pso=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l3aXou5CEJRLGWQSzgzOeZZB5YIMXGJqWhdxtTHHtcvwmyVXkC2dZtEk17FduLO88
	 b5wLJlxbgWauqwPBjOv3qXnYPDxpRFK8GVQKnw2XRbxnqezhUWxQXUbWHkd5osB5x8
	 XFa5dhr7kMyNSeSF0lBem5PzSlEWZIDW486/RvDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23D36F800C0;
	Wed, 18 Mar 2020 11:25:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A87B5F80132; Wed, 18 Mar 2020 11:25:56 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45888F800B7
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 11:25:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45888F800B7
IronPort-SDR: do7npLNJtINw7d0tqAGb9sH3f9Hu05y04UBh3ey55T1wRmFDk84crugDWoHy4pKb/73MZjy+uD
 je56jKUKSHHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 03:25:49 -0700
IronPort-SDR: yMgKAtJA5AXW+kn+57lEM8jBfYOpBsjhZ0Y/WUUybU9Vzev+yR4VLwah7TtngQVB/O8BcJnoId
 PDNEqJCwP1PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="444120051"
Received: from mgorski-all-series.igk.intel.com ([10.237.149.201])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2020 03:25:47 -0700
From: Mateusz Gorski <mateusz.gorski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4] ucm2: hdadsp: add basic ucm config
Date: Wed, 18 Mar 2020 11:26:05 +0100
Message-Id: <20200318102605.20146-1-mateusz.gorski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 tiwai@suse.com
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

Basic UCM configuration for Intel Skylake SST with HDA DSP generic
machine driver enabling codec playback and capture on both HDA codec
and DMIC ports.

Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
---

Changes in v4:
- adjusted folder and files names to hda-dsp instead of hdadsp

 ucm2/hda-dsp/Hdmi1.conf   | 24 ++++++++++
 ucm2/hda-dsp/Hdmi2.conf   | 24 ++++++++++
 ucm2/hda-dsp/HiFi.conf    | 96 +++++++++++++++++++++++++++++++++++++++
 ucm2/hda-dsp/hda-dsp.conf | 16 +++++++
 4 files changed, 160 insertions(+)
 create mode 100644 ucm2/hda-dsp/Hdmi1.conf
 create mode 100644 ucm2/hda-dsp/Hdmi2.conf
 create mode 100644 ucm2/hda-dsp/HiFi.conf
 create mode 100644 ucm2/hda-dsp/hda-dsp.conf

diff --git a/ucm2/hda-dsp/Hdmi1.conf b/ucm2/hda-dsp/Hdmi1.conf
new file mode 100644
index 0000000..d402dab
--- /dev/null
+++ b/ucm2/hda-dsp/Hdmi1.conf
@@ -0,0 +1,24 @@
+# Usecase for device HDMI1/Display Port stereo playback on Intel cAVS platforms
+# For Audio in HDA mode
+
+SectionDevice."HDMI1" {
+        Comment "HDMI/Display Port 1 Stereo"
+
+        Value {
+                PlaybackPriority 300
+                PlaybackPCM "hw:${CardId},10"
+                If.1 {
+                        Condition {
+                                Type ControlExists
+                                Control "iface=CARD,name='HDMI/DP,pcm=17 Jack'"
+                        }
+                        True {
+                                JackControl "HDMI/DP,pcm=17 Jack"
+                        }
+                        False {
+                                JackControl "HDMI/DP, pcm=17 Jack"
+                        }
+                }
+        }
+}
+
diff --git a/ucm2/hda-dsp/Hdmi2.conf b/ucm2/hda-dsp/Hdmi2.conf
new file mode 100644
index 0000000..153bbe1
--- /dev/null
+++ b/ucm2/hda-dsp/Hdmi2.conf
@@ -0,0 +1,24 @@
+# Usecase for device HDMI2/Display Port stereo playback on Intel cAVS platforms
+# For Audio in HDA mode
+
+SectionDevice."HDMI2" {
+        Comment "HDMI/Display Port 2 Stereo"
+
+        Value {
+                PlaybackPriority 400
+                PlaybackPCM "hw:${CardId},11"
+                If.1 {
+                        Condition {
+                                Type ControlExists
+                                Control "iface=CARD,name='HDMI/DP,pcm=18 Jack'"
+                        }
+                        True {
+                                JackControl "HDMI/DP,pcm=18 Jack"
+                        }
+                        False {
+                                JackControl "HDMI/DP, pcm=18 Jack"
+                        }
+                }
+        }
+}
+
diff --git a/ucm2/hda-dsp/HiFi.conf b/ucm2/hda-dsp/HiFi.conf
new file mode 100644
index 0000000..cdeb215
--- /dev/null
+++ b/ucm2/hda-dsp/HiFi.conf
@@ -0,0 +1,96 @@
+# Usecase for stereo playback Speaker and Headset, Recording on DMIC and Headset MIC.
+# For Audio in HDA mode on Intel cAVS platforms
+
+SectionVerb {
+
+	EnableSequence [
+		cset "name='mch_cap_out mo mch_cap_in mi Switch' 1"
+	]
+
+	Value {
+		TQ "HiFi"
+	}
+}
+
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	ConflictingDevice [
+		"Speaker"
+	]
+
+	EnableSequence [
+		cset "name='Headphone Playback Switch' 1,1"
+		cset "name='Speaker Playback Switch' 0,0"
+	]
+
+	Value {
+		PlaybackPriority 200
+		PlaybackPCM "hw:${CardId},7"
+		PlaybackMixerElem "Headphone"
+		PlaybackMasterElem "Master"
+		PlaybackVolume "Headphone Playback Volume"
+		PlaybackSwitch "Headphone Playback Switch"
+		JackControl "Front Headphone Jack"
+		JackHWMute "Speaker"
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
+		cset "name='Headphone Playback Switch' 0,0"
+		cset "name='Speaker Playback Switch' 1,1"
+	]
+
+	Value {
+		PlaybackPriority 100
+		PlaybackPCM "hw:${CardId},7"
+		PlaybackMixerElem "Speaker"
+		PlaybackMasterElem "Master"
+		PlaybackVolume "Speaker Playback Volume"
+		PlaybackSwitch "Speaker Playback Switch"
+	}
+}
+
+SectionDevice."Headset" {
+	Comment "Headset Microphone"
+
+	ConflictingDevice [
+		"Mic"
+	]
+
+	EnableSequence [
+		cset "name='media0_out mo codec0_in mi Switch' 1"
+	]
+
+	Value {
+		CapturePriority 200
+		CapturePCM "hw:${CardId},7"
+	}
+}
+
+SectionDevice."Mic" {
+	Comment "Digital Microphone"
+
+	ConflictingDevice [
+		"Headset"
+	]
+
+	EnableSequence [
+		cset "name='mch_cap_out mo mch_cap_in mi Switch' 1"
+	]
+
+	Value {
+		CapturePriority 100
+		CapturePCM "hw:${CardId},13"
+	}
+}
+
+<hda-dsp/Hdmi1.conf>
+<hda-dsp/Hdmi2.conf>
diff --git a/ucm2/hda-dsp/hda-dsp.conf b/ucm2/hda-dsp/hda-dsp.conf
new file mode 100644
index 0000000..48c07c8
--- /dev/null
+++ b/ucm2/hda-dsp/hda-dsp.conf
@@ -0,0 +1,16 @@
+# UCM for Intel CAVS platforms
+# For Audio in HDA and DMIC mode
+
+Syntax 2
+
+SectionUseCase."HiFi" {
+        File "HiFi.conf"
+        Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cset "name='Master Playback Switch' 1"
+	cset "name='codec0_out mo media0_in mi Switch' 1"
+	cset "name='media0_out mo codec0_in mi Switch' 1"
+	cset "name='mch_cap_out mo mch_cap_in mi Switch' 1"
+]
-- 
2.17.1

