Return-Path: <SRS0=PHkf=MK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF76C636C8
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Jul 2021 17:59:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D856F61003
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Jul 2021 17:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D856F61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 836051658;
	Sun, 18 Jul 2021 19:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 836051658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626631188;
	bh=ClESuv63cHd3zQY0G0vHNVEnTexDu9RWhR1UtxNg6UI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f9f9/iu7qtVdbOywvoVygUphcqzJjDMiQVd8rM5cXlPMFTDImniWYRPusKD3jWw/L
	 kmBdznx7hdTHsFCi7fy807Mq9NQoq5JuuGcjQie7V3a7iV5EETjS3+MV8TFvhZdSBn
	 JTdGrjr3+FI8ZBP8Vl5pmtr8jBjoUe0O6Qwn7N50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8378F804A9;
	Sun, 18 Jul 2021 19:58:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E44BF8032B; Sun, 18 Jul 2021 19:58:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81E6FF800DA
 for <alsa-devel@alsa-project.org>; Sun, 18 Jul 2021 19:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81E6FF800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="BWmRtom7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626631077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pMXqtNQYb8pZOIOQkMH7F6H0o9rVPHyBAyEGKrjx3nk=;
 b=BWmRtom7I1odhppCwdcpmG2iXiuCynCkVLMoGgicUPPJ2jNzBnW1pFVx8ar0BTTaYOfPer
 2g616zP/f+Q4UxUfkx+RITnwZtVX1fqMHNl66DX+q9KzYTTgTMJMLbB9BQVZQ/+YLeubed
 20mI4Q8EJwGaGmhtKF2yMFwH1poZNHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-dVFi_CGuP3OG2SQKgrl8UQ-1; Sun, 18 Jul 2021 13:57:54 -0400
X-MC-Unique: dVFi_CGuP3OG2SQKgrl8UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D56701800D41;
 Sun, 18 Jul 2021 17:57:52 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6702060871;
 Sun, 18 Jul 2021 17:57:51 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 1/2] bytcr-rt5640: Fix 'Headphone Switch' /
 'Headset Mic Switch' no longer getting set
Date: Sun, 18 Jul 2021 19:57:49 +0200
Message-Id: <20210718175750.12353-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Osipenko <digetx@gmail.com>,
 alsa-devel@alsa-project.org,
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

Commit 446d0a71b47f ("codecs/rt5640: Move out BayTrail-specific pin switches")
moved the setting of the 'Headphone Switch' / 'Headset Mic Switch' into
"If.hp" resp "If.hsmic" blocks. But instead of making them part of the
True {} block inside that If, the statements where added add the top-level
of the If {} block where they are no-ops.

Move them to inside the True blocks so that these Switches again get
properly turned on/off. This fixes the Headphones and Headset-mic no longer
working on bytcr-rt5640 devices.

Cc: Dmitry Osipenko <digetx@gmail.com>
Fixes: 446d0a71b47f ("codecs/rt5640: Move out BayTrail-specific pin switches")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/bytcr-rt5640/HiFi.conf | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/ucm2/bytcr-rt5640/HiFi.conf b/ucm2/bytcr-rt5640/HiFi.conf
index a5b47df..08127e0 100644
--- a/ucm2/bytcr-rt5640/HiFi.conf
+++ b/ucm2/bytcr-rt5640/HiFi.conf
@@ -100,16 +100,18 @@ If.mono {
 
 If.hp {
 	Condition { Type String Empty "" }
-	True.Include.hs.File "/codecs/rt5640/HeadPhones.conf"
+	True {
+		Include.hs.File "/codecs/rt5640/HeadPhones.conf"
 
-	SectionDevice."Headphones" {
-		EnableSequence [
-			cset "name='Headphone Switch' on"
-		]
+		SectionDevice."Headphones" {
+			EnableSequence [
+				cset "name='Headphone Switch' on"
+			]
 
-		DisableSequence [
-			cset "name='Headphone Switch' off"
-		]
+			DisableSequence [
+				cset "name='Headphone Switch' off"
+			]
+		}
 	}
 }
 
@@ -178,15 +180,17 @@ If.in3 {
 
 If.hsmic {
 	Condition { Type String Empty "" }
-	True.Include.hsmic.File "/codecs/rt5640/HeadsetMic.conf"
+	True {
+		Include.hsmic.File "/codecs/rt5640/HeadsetMic.conf"
 
-	SectionDevice."Headset" {
-		EnableSequence [
-			cset "name='Headset Mic Switch' on"
-		]
+		SectionDevice."Headset" {
+			EnableSequence [
+				cset "name='Headset Mic Switch' on"
+			]
 
-		DisableSequence [
-			cset "name='Headset Mic Switch' off"
-		]
+			DisableSequence [
+				cset "name='Headset Mic Switch' off"
+			]
+		}
 	}
 }
-- 
2.31.1

