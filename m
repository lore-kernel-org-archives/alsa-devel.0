Return-Path: <SRS0=bkJA=HT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FDCC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 14:36:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD3564E02
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD3564E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D506E165E;
	Wed, 17 Feb 2021 15:35:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D506E165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613572592;
	bh=X5YurTV29v/chGaCpQXwi1rN9OtZPu79bGJ8+kYNErY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JKCueiRqQ3cgtk37o2n2+rVja9IeK5QijdVbPBu4YMNtVrNDVVz9RMcSqn3aFa8yI
	 a3LhZvXr3CXQol3Z9PZUKB/SN4/xjzhJfL0yyU4SP+kZUpEn9NUsx37EUQ3Wpw9/zY
	 HbdxCQsI5Z6gy9YTNCQBUv8mVE3pqMeZGioRKVg0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E385F80268;
	Wed, 17 Feb 2021 15:34:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C38BF800AE; Wed, 17 Feb 2021 15:34:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B6B8F800AE
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2021 15:34:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B6B8F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="THUHFcFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613572487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/EezDiuGD1BYCvx7eanLeLUc6cEyrcdVTRhKZfdiMU=;
 b=THUHFcFtCqZGrjXLCzhZEjUTvifG84z5bqhdcK+FZWrDscYqziLM1YyX119dBYsI5yk3hN
 GD4BHgUgC6xSTZhDAOL1LtZ9rF/K0zWJogakzGjPbSRGmaZo1PInP97ML2ogtNKadVev5D
 HQEClds+B/Fm2akbAnBbk5zQYHfnSnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-aDQ4X4OMP7CfxXtLS8MfUA-1; Wed, 17 Feb 2021 09:34:45 -0500
X-MC-Unique: aDQ4X4OMP7CfxXtLS8MfUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA56803F4B;
 Wed, 17 Feb 2021 14:34:43 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-224.ams2.redhat.com [10.36.115.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1C15C27C;
 Wed, 17 Feb 2021 14:34:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 2/2] codecs/rt5672: Add hardware volume-control
 support
Date: Wed, 17 Feb 2021 15:34:36 +0100
Message-Id: <20210217143436.74209-2-hdegoede@redhat.com>
In-Reply-To: <20210217143436.74209-1-hdegoede@redhat.com>
References: <20210217143436.74209-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

For the speaker and DMICs configs this uses "DAC1 Playback Volume"
resp. "ADC Capture Volume" as main mixer elements, since there are
no other volume-controls in their paths.

For the (analog) headset-mic and headphones this used the analog
"IN1 Boost" resp. "HP Playback Volume" controls as main mixer elements
while using the  "ADC Capture Volume" resp. "DAC1 Playback Volume"
(which have the mute switches) as master mixer elements.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5672/DMIC1.conf       | 5 +++++
 ucm2/codecs/rt5672/DMIC2.conf       | 5 +++++
 ucm2/codecs/rt5672/HeadPhones.conf  | 3 +++
 ucm2/codecs/rt5672/HeadsetMic.conf  | 3 +++
 ucm2/codecs/rt5672/MonoSpeaker.conf | 5 +++++
 ucm2/codecs/rt5672/Speaker.conf     | 5 +++++
 6 files changed, 26 insertions(+)

diff --git a/ucm2/codecs/rt5672/DMIC1.conf b/ucm2/codecs/rt5672/DMIC1.conf
index 2018283..ca65d28 100644
--- a/ucm2/codecs/rt5672/DMIC1.conf
+++ b/ucm2/codecs/rt5672/DMIC1.conf
@@ -23,5 +23,10 @@ SectionDevice."Mic1" {
 	Value {
 		CapturePriority 100
 		CapturePCM "hw:${CardId}"
+		# The DMIC ofcourse has no analog volume controls
+		# Use the digital ADC master control as MixerElem
+		CaptureMixerElem "ADC"
+		CaptureVolume "ADC Capture Volume"
+		CaptureSwitch "ADC Capture Switch"
 	}
 }
diff --git a/ucm2/codecs/rt5672/DMIC2.conf b/ucm2/codecs/rt5672/DMIC2.conf
index 48e6170..2a2f9fe 100644
--- a/ucm2/codecs/rt5672/DMIC2.conf
+++ b/ucm2/codecs/rt5672/DMIC2.conf
@@ -23,5 +23,10 @@ SectionDevice."Mic2" {
 	Value {
 		CapturePriority 200
 		CapturePCM "hw:${CardId}"
+		# The DMIC ofcourse has no analog volume controls
+		# Use the digital ADC master control as MixerElem
+		CaptureMixerElem "ADC"
+		CaptureVolume "ADC Capture Volume"
+		CaptureSwitch "ADC Capture Switch"
 	}
 }
diff --git a/ucm2/codecs/rt5672/HeadPhones.conf b/ucm2/codecs/rt5672/HeadPhones.conf
index 2c8d6e8..e22d499 100644
--- a/ucm2/codecs/rt5672/HeadPhones.conf
+++ b/ucm2/codecs/rt5672/HeadPhones.conf
@@ -18,5 +18,8 @@ SectionDevice."Headphones" {
 		PlaybackPriority 300
 		PlaybackPCM "hw:${CardId}"
 		JackControl "Headphone Jack"
+		PlaybackMixerElem "HP"
+		PlaybackMasterElem "DAC1"
+		PlaybackVolume "HP Playback Volume"
 	}
 }
diff --git a/ucm2/codecs/rt5672/HeadsetMic.conf b/ucm2/codecs/rt5672/HeadsetMic.conf
index fc061b0..103e93d 100644
--- a/ucm2/codecs/rt5672/HeadsetMic.conf
+++ b/ucm2/codecs/rt5672/HeadsetMic.conf
@@ -26,5 +26,8 @@ SectionDevice."Headset" {
 		CapturePriority 300
 		CapturePCM "hw:${CardId}"
 		JackControl "Headset Mic Jack"
+		CaptureMixerElem "IN1 Boost"
+		CaptureMasterElem "ADC"
+		CaptureVolume "IN1 Boost Volume"
 	}
 }
diff --git a/ucm2/codecs/rt5672/MonoSpeaker.conf b/ucm2/codecs/rt5672/MonoSpeaker.conf
index f08c9c6..e4addf4 100644
--- a/ucm2/codecs/rt5672/MonoSpeaker.conf
+++ b/ucm2/codecs/rt5672/MonoSpeaker.conf
@@ -21,5 +21,10 @@ SectionDevice."Speaker2" {
 	Value {
 		PlaybackPriority 100
 		PlaybackPCM "hw:${CardId}"
+		# The speaker ampl. path on the 5672 has no speaker vol control
+		# Use the digital DAC1 master control as MixerElem
+		PlaybackMixerElem "DAC1"
+		PlaybackVolume "DAC1 Playback Volume"
+		PlaybackSwitch "DAC1 Playback Switch"
 	}
 }
diff --git a/ucm2/codecs/rt5672/Speaker.conf b/ucm2/codecs/rt5672/Speaker.conf
index 8b7bcf8..9674c6b 100644
--- a/ucm2/codecs/rt5672/Speaker.conf
+++ b/ucm2/codecs/rt5672/Speaker.conf
@@ -17,5 +17,10 @@ SectionDevice."Speaker1" {
 	Value {
 		PlaybackPriority 200
 		PlaybackPCM "hw:${CardId}"
+		# The speaker ampl. path on the 5672 has no speaker vol control
+		# Use the digital DAC1 master control as MixerElem
+		PlaybackMixerElem "DAC1"
+		PlaybackVolume "DAC1 Playback Volume"
+		PlaybackSwitch "DAC1 Playback Switch"
 	}
 }
-- 
2.30.1

