Return-Path: <SRS0=Hwo1=HL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE6C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 21:02:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793C664E76
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 21:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793C664E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CBEB16B5;
	Tue,  9 Feb 2021 22:01:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CBEB16B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612904524;
	bh=llRCVgl9nU/k5EGaJ8RRMjVjx5Hi5cS3v9HN15PNrHY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mokn9reG9q4wfe8PbaystWjdGukJqj/rSuhtfA10+tZB9VJ/h2Xua86FmNw9QuJ4e
	 6h+oi+oW70z7ckQU9OYHr/PdhJhUTD91Tu9/ONQfiB6GuR3re7IfO7v5AW+tz5m1dG
	 GFQN7T2FLULO8JwmZsBvsQDmtRQZuvc813pmOd1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96739F8016B;
	Tue,  9 Feb 2021 22:01:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 111D3F801D5; Tue,  9 Feb 2021 22:01:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61633F8013A
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 22:01:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61633F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="h3J2QpBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612904467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oYa7hoaWLMRYoujOCepLdszcgiBOCSpwAqKfD++qPtY=;
 b=h3J2QpBRXbYFlmQchHQOg9BhzeDBZ6rXh7OyR7vXz9KLTY4V4tZWvrnol6NASz5Fbcamnb
 uu1brvFcSR6Il0SUtsG6wfxhGbKTw5ttcCegcA6uRakkKCL3l/Jzy0OtoTyi84cxEoWFzO
 chxHmkxAV+pWCG3UZ2OKgfRIjwvH0No=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-4YmZELR8M4aofwS33lBnug-1; Tue, 09 Feb 2021 16:01:05 -0500
X-MC-Unique: 4YmZELR8M4aofwS33lBnug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7EE3BBEE2;
 Tue,  9 Feb 2021 21:01:03 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6865A19C78;
 Tue,  9 Feb 2021 21:01:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf] codecs/rt5672: Remove Intel SST specific
 HeadsetMic workaround
Date: Tue,  9 Feb 2021 22:01:01 +0100
Message-Id: <20210209210101.76119-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

There used to be an issue with the HeadsetMic on BYT devices with
a rt5672 codec only being recorded on the left channel, while the
right channel recorded silence.

The ucm2/codecs/rt5672/HeadsetMic.conf contains a workaround for
this which changes the SST record-stream demuxer settings to
use "slot 0" for both the left and right channels when recording
from the HeadsetMic.

There are 2 problems with this workaround:

1. It uses SST specific mixer settings causing things to break
when using the SOF driver.

2. Files under uc2m/codecs should be architecture agnostic and should
not depend on platform dependent mixer settings such as the SST driver
mixer settings.

The problem which the workaround used to work around has since been
fixed in the kernel by switching the wire format from TDM/DSP A to I2S:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ceb8a36d023d4bb4ffca3474a452fb1dfaa0ef2

This fix has landed in 5.8 and has been backported to all recent
stable kernel releases.

Since this is fixed in the kernel now, we can drop the workaround,
fixing the 2 problems mentioned above.

This was tested on a ThinkPad 8 tablet, which is the same device as
where the HeadsetMic problem was originally noticed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5672/HeadsetMic.conf | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/ucm2/codecs/rt5672/HeadsetMic.conf b/ucm2/codecs/rt5672/HeadsetMic.conf
index a764d82..fc061b0 100644
--- a/ucm2/codecs/rt5672/HeadsetMic.conf
+++ b/ucm2/codecs/rt5672/HeadsetMic.conf
@@ -12,11 +12,6 @@ SectionDevice."Headset" {
 		cset "name='RECMIXR BST1 Switch' on"
 		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
-		# For unknown reasons the headset mic sound is only recorded
-		# on the left channel, we tweak the data-stream reception to
-		# use the left samples for both slots, so that we get a stereo
-		# stream with the mic sound on both channels
-		cset "name='codec_in rx deinterleaver codec_in0_1' 1"
 	]
 
 	DisableSequence [
@@ -25,8 +20,6 @@ SectionDevice."Headset" {
 		cset "name='RECMIXR BST1 Switch' off"
 		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
-		# Undo data-stream reception mono-mix workaround
-		cset "name='codec_in rx deinterleaver codec_in0_1' 2"
 	]
 
 	Value {
-- 
2.30.0

