Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EBC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:08:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FB565257
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FB565257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32405189B;
	Mon,  8 Mar 2021 23:07:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32405189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615241314;
	bh=TaKn+fr8LZrQI2znIDQkwH0pTdNa+gGuPIm3hOKrm+w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iov3/c5Xx4f73GpKFBVBFG0gOnxpa72yPIpJWYeZ1qOGNCOTzOXCE39mNUBehWrFK
	 zsZTL+jtq/qJL8wkzcN9Q9K+us2aRM7Ksaakqzm33V9xiUhHqLg806m5W9EJRnSonx
	 SpPZoPtwpmoBV5TmxNYBaWzlNx3hsithXHKSBr6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E317F802E7;
	Mon,  8 Mar 2021 23:06:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FF98F80217; Mon,  8 Mar 2021 23:06:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A140F80217
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 23:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A140F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="jDj5bktn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615241165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0VBWxWJNsaIisKDtr+Dd11Z7wHg8abuGX0PO11D6Yk=;
 b=jDj5bktnqSMzAciqfw6xrpqla+MQYXCmkD+e45lvDPH/1/dprk6kY95zwMPAWubEXeommC
 qp0oEgZZ2R7EYxiyhG4JJmkqUhQXAPvRvT7lRgP9sOu2CC+61xWMtNgJzo2HGLARy6eD3c
 MSydtZazeyPY6Ep3dfES1G14urcyd4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-qIW1BevYMSW8YLVvozxfLw-1; Mon, 08 Mar 2021 17:06:02 -0500
X-MC-Unique: qIW1BevYMSW8YLVvozxfLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7642D81431F;
 Mon,  8 Mar 2021 22:06:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-220.ams2.redhat.com
 [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F53C5D756;
 Mon,  8 Mar 2021 22:06:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf v2 3/7] codecs/rt5640: Cleanup: Move 'SPK MIX'
 setup to main EnableSequene
Date: Mon,  8 Mar 2021 23:05:50 +0100
Message-Id: <20210308220554.76111-4-hdegoede@redhat.com>
In-Reply-To: <20210308220554.76111-1-hdegoede@redhat.com>
References: <20210308220554.76111-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Cleanup: no functional changes intended.

Do the 'SPK MIXL' / 'SPK MIXR' setup only once from the main
EnableSequene, like we do for the 'OUT MIXL' / 'OUT MIXR' setup
used by the headphones already.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5640/EnableSeq.conf   | 6 ++++--
 ucm2/codecs/rt5640/MonoSpeaker.conf | 2 --
 ucm2/codecs/rt5640/Speaker.conf     | 2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/ucm2/codecs/rt5640/EnableSeq.conf b/ucm2/codecs/rt5640/EnableSeq.conf
index 5dc7092..4a355a5 100644
--- a/ucm2/codecs/rt5640/EnableSeq.conf
+++ b/ucm2/codecs/rt5640/EnableSeq.conf
@@ -6,8 +6,10 @@ EnableSequence [
 	cset "name='Stereo DAC MIXR DAC R1 Switch' on"
 	cset "name='Stereo DAC MIXL DAC L2 Switch' on"
 	cset "name='Stereo DAC MIXR DAC R2 Switch' on"
-	cset "name='OUT MIXL DAC L1 Switch'  on"
-	cset "name='OUT MIXR DAC R1 Switch'  on"
+	cset "name='OUT MIXL DAC L1 Switch' on"
+	cset "name='OUT MIXR DAC R1 Switch' on"
+	cset "name='SPK MIXL DAC L1 Switch' on"
+	cset "name='SPK MIXR DAC R1 Switch' on"
 
 	# uncomment for loopback mic->speakers
 	# cset "name='SPOL MIX BST1 Switch' on"
diff --git a/ucm2/codecs/rt5640/MonoSpeaker.conf b/ucm2/codecs/rt5640/MonoSpeaker.conf
index 5035c8d..654edc3 100644
--- a/ucm2/codecs/rt5640/MonoSpeaker.conf
+++ b/ucm2/codecs/rt5640/MonoSpeaker.conf
@@ -6,8 +6,6 @@ SectionDevice."Speaker" {
 	]
 
 	EnableSequence [
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
 		cset "name='SPOL MIX SPKVOL L Switch' on"
 # for mono speaker we apply left on right
 #		cset "name='SPOR MIX SPKVOL R Switch' on"
diff --git a/ucm2/codecs/rt5640/Speaker.conf b/ucm2/codecs/rt5640/Speaker.conf
index fd74994..3264cc3 100644
--- a/ucm2/codecs/rt5640/Speaker.conf
+++ b/ucm2/codecs/rt5640/Speaker.conf
@@ -6,8 +6,6 @@ SectionDevice."Speaker" {
 	]
 
 	EnableSequence [
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
 		cset "name='SPOL MIX SPKVOL L Switch' on"
 		cset "name='SPOR MIX SPKVOL R Switch' on"
 		# undo MonoSpeaker mixing of right channel to left speaker
-- 
2.30.1

