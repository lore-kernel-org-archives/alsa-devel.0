Return-Path: <SRS0=4hHz=GM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23377C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Jan 2021 21:04:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5608E20729
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Jan 2021 21:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5608E20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 898941731;
	Sat,  9 Jan 2021 22:03:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 898941731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610226267;
	bh=GzZJExIryUdWh6fr1HKfieNkK+t3GE0JIEkBIGay/U4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gy7vfY9kYRwyVjpFdoTr3e4Eu9vr88NJya6I8MAZVKnzZctqePjZDvRTym0dJsZo/
	 a0jVrQM5F3jv/BkEy/ecyz3INUAk8pgvz+xmXv+l+031BdOeCQuC6QWe7RaZeQvs31
	 eVq5OnkZYXgmtxOPn2FgKy7RBdsKLv2to964LlsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26CA5F80258;
	Sat,  9 Jan 2021 22:03:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 986C9F804D6; Sat,  9 Jan 2021 22:03:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD75DF801F5
 for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2021 22:03:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD75DF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="HqnosZLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610226179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPSBsAF1/mETDKSW+428hPTt3J6wkJb+epDI/JbPG/4=;
 b=HqnosZLm9RSMpzPiyvz4yot4oB3Sj1r6umRVmo3zBB5NP5lyGToEKigh9abvI9Hm8M7YVE
 xXgQFhKG09QaDb9JsCu622FD5SRlzsUsuul9q4aU/rQ1F1EIglEX60jjiwFcIw4jj4DMT6
 MOAq49tqnD+W6TRgTxIjzHGxb00o6KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ekyHrc9UM6Gb8xDVus-a6g-1; Sat, 09 Jan 2021 16:02:57 -0500
X-MC-Unique: ekyHrc9UM6Gb8xDVus-a6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7606E801A9D;
 Sat,  9 Jan 2021 21:02:56 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EC6C648A8;
 Sat,  9 Jan 2021 21:02:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 2/2] rt5640: Move standard DAC setup to
 EnableSeq.conf
Date: Sat,  9 Jan 2021 22:02:52 +0100
Message-Id: <20210109210252.159162-2-hdegoede@redhat.com>
In-Reply-To: <20210109210252.159162-1-hdegoede@redhat.com>
References: <20210109210252.159162-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

No matter which output is used, we always need to setup the standard
DAC config. Move this to the shared EnableSeq.conf to avoid having
to duplicate it in various places.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5640/EnableSeq.conf   | 6 ++++++
 ucm2/codecs/rt5640/HeadPhones.conf  | 6 ------
 ucm2/codecs/rt5640/MonoSpeaker.conf | 6 ------
 ucm2/codecs/rt5640/Speaker.conf     | 6 ------
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/ucm2/codecs/rt5640/EnableSeq.conf b/ucm2/codecs/rt5640/EnableSeq.conf
index cbf4038..145a23b 100644
--- a/ucm2/codecs/rt5640/EnableSeq.conf
+++ b/ucm2/codecs/rt5640/EnableSeq.conf
@@ -1,5 +1,11 @@
 EnableSequence [
 	# RT5640 default output routing
+	cset "name='DAC MIXL INF1 Switch' on"
+	cset "name='DAC MIXR INF1 Switch' on"
+	cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+	cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+	cset "name='Stereo DAC MIXL DAC L2 Switch' on"
+	cset "name='Stereo DAC MIXR DAC R2 Switch' on"
 	cset "name='OUT MIXL DAC L1 Switch'  on"
 	cset "name='OUT MIXR DAC R1 Switch'  on"
 
diff --git a/ucm2/codecs/rt5640/HeadPhones.conf b/ucm2/codecs/rt5640/HeadPhones.conf
index b7707e5..a9e4d20 100644
--- a/ucm2/codecs/rt5640/HeadPhones.conf
+++ b/ucm2/codecs/rt5640/HeadPhones.conf
@@ -14,12 +14,6 @@ SectionDevice."Headphones" {
 	}
 
 	EnableSequence [
- 		cset "name='DAC MIXL INF1 Switch'  on"
- 		cset "name='DAC MIXR INF1 Switch'  on"
- 		cset "name='Stereo DAC MIXL DAC L1 Switch'  on"
- 		cset "name='Stereo DAC MIXR DAC R1 Switch'  on"
-		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
- 		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
  		cset "name='HPO MIX HPVOL Switch'  on"
  		cset "name='Headphone Switch'  on"
 		cset "name='HP Channel Switch' on"
diff --git a/ucm2/codecs/rt5640/MonoSpeaker.conf b/ucm2/codecs/rt5640/MonoSpeaker.conf
index ddc7ba8..23cf34c 100644
--- a/ucm2/codecs/rt5640/MonoSpeaker.conf
+++ b/ucm2/codecs/rt5640/MonoSpeaker.conf
@@ -6,12 +6,6 @@ SectionDevice."Speaker" {
 	]
 
 	EnableSequence [
-		cset "name='DAC MIXL INF1 Switch' on"
-		cset "name='DAC MIXR INF1 Switch' on"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
-		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
-		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
 		cset "name='SPK MIXL DAC L1 Switch' on"
 		cset "name='SPK MIXR DAC R1 Switch' on"
 		cset "name='SPOL MIX SPKVOL L Switch' on"
diff --git a/ucm2/codecs/rt5640/Speaker.conf b/ucm2/codecs/rt5640/Speaker.conf
index 411cd13..422cfdf 100644
--- a/ucm2/codecs/rt5640/Speaker.conf
+++ b/ucm2/codecs/rt5640/Speaker.conf
@@ -6,12 +6,6 @@ SectionDevice."Speaker" {
 	]
 
 	EnableSequence [
-		cset "name='DAC MIXL INF1 Switch' on"
-		cset "name='DAC MIXR INF1 Switch' on"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
-		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
- 		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
 		cset "name='SPK MIXL DAC L1 Switch' on"
 		cset "name='SPK MIXR DAC R1 Switch' on"
 		cset "name='SPOL MIX SPKVOL L Switch' on"
-- 
2.28.0

