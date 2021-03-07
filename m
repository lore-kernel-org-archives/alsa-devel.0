Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D9C433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 20:04:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0065165
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 20:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D0065165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF1201861;
	Sun,  7 Mar 2021 21:03:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF1201861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615147461;
	bh=9cQuXDXYtBI/5+Mv2MbjeagcAb34uWS5AFgG+CW3MNg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k14o3Iy9dp1CMqVYh2oTmPj/UN7TnGnSgvdg6eP38VaSrdAT7F1e9HPVvlnOYdFL6
	 CzFAko5k+svt/5LylLmj5wKFS4pJmUdaJaKBDrpC76GgCIAbljyflr7qLDv0TAHnU2
	 67Pot8yEe2zW4UHfbKXkSLUyyButgK7XvqHHD5Ws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E37EBF80227;
	Sun,  7 Mar 2021 21:03:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17CA2F8025A; Sun,  7 Mar 2021 21:03:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFE27F80139
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 21:03:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFE27F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Jzi0ZnA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615147398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/TFlUH9Gk1fuXpEFFMu7tW2utKjPa1kbWfSgJ0VOG3E=;
 b=Jzi0ZnA1OyY2o6me5y3lNQzxS1cmPTStviSrUp0pCVY4R+SdCbzDDSHQ9E8yRH/JHoHUvP
 wXOHd62jXXcmIY5tscZt0LTUVuvDb2hIWnntuG+m1he90BV6XZEkSEGJ1g2QpTK0nlyJeD
 +cWrrv0RqGb5n7Lb7m/h+GIkjbKNmKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-ZrPXpFkfPquuJ9hHasj8Qw-1; Sun, 07 Mar 2021 15:03:13 -0500
X-MC-Unique: ZrPXpFkfPquuJ9hHasj8Qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E29431005D45;
 Sun,  7 Mar 2021 20:03:11 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76E210016F8;
 Sun,  7 Mar 2021 20:03:09 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 1/3] codecs/es8316: Fix capture settings
Date: Sun,  7 Mar 2021 21:03:06 +0100
Message-Id: <20210307200308.136385-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Fix the following issues with the capture settings:

1. Disable ALC / Auto Level Control, it tries to always get an
   input signal even when the user is not talking into the mic
   leading to it cranking up the volume till there is noise at
   the same level as the user talking.

2. The 'ADC PGA Gain Volume' volume control is not the main
   'ADC vol' control, it is the mic amplifier control and
   setting it to 10 sets it to 24dB not 0dB.
   Adjust the comment and set it to 7 which is 16dB which
   gives a good microphone signal strength without introducing
   too much noise (with 'ADC Capture Volume' set to 0dB).

3. There actually is a main 'ADC vol' control which goes from -96 to 0dB
   which is simply called the 'ADC Capture Volume' and when disabling ALC
   it defaults to -96 dB. Add a line setting it to 0dB.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/es8316/EnableSeq.conf | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ucm2/codecs/es8316/EnableSeq.conf b/ucm2/codecs/es8316/EnableSeq.conf
index 97ccfc9..272ef1a 100644
--- a/ucm2/codecs/es8316/EnableSeq.conf
+++ b/ucm2/codecs/es8316/EnableSeq.conf
@@ -11,11 +11,15 @@ EnableSequence [
 	cset "name='Headphone Mixer Volume' 4"
 	# Set DAC vol to 0 dB (192/192)
 	cset "name='DAC Playback Volume' 192"
-	# Set ADC vold to 0 dB (10/10)
-	cset "name='ADC PGA Gain Volume' 10"
+
+	# Disable Auto Level Control
+	cset "name='ALC Capture Switch' off"
+	# Set ADC vol to 0 dB (192/192)
+	cset "name='ADC Capture Volume' 192"
+	# Set Mic amplifier to +16 dB
+	cset "name='ADC PGA Gain Volume' 7"
 
 	# Setup muxes / switches
 	cset "name='Left Headphone Mixer Left DAC Switch' on"
 	cset "name='Right Headphone Mixer Right DAC Switch' on"
-	cset "name='ALC Capture Switch' on"
 ]
-- 
2.30.1

