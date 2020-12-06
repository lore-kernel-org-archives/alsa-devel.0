Return-Path: <SRS0=1Izd=FK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5029C433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 12:50:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E14B2310E
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 12:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E14B2310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7013D1768;
	Sun,  6 Dec 2020 13:49:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7013D1768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607259002;
	bh=NhRhWp3TwnTR0SwJfgMQmMo4cZ2msGMJYweLVUiJtRo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwK/oeIhf+1/cEV9j/NtK2sAAloaZF7eYH64HzKvP+sTHU/1v6YfOt7aCuxeACM4Y
	 LujsWT9W/7W/BwuEMGMfLD7uyenuxgTT7pYkRiAS3noCVV2TTBMkmk5rjp6YSHs6Ll
	 OxAbHdLyf1o7obj3zQMWNAPUsDGUHOSARt9sSDqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52B3EF804E6;
	Sun,  6 Dec 2020 13:47:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4F96F804E0; Sun,  6 Dec 2020 13:47:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16129F804DF
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2020 13:47:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16129F804DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="VYB87Z1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607258845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nzW5VRZOLXk00dUUhaziO97yESG6VVkkKOIkNoMtro=;
 b=VYB87Z1FqDV8HqJJ2IzzftyfE15XM0fMi5yPDdqvTCAhngiUJYxzf6ngB2SHDAe2iQfs4n
 4HdYYE9tMxLM7yfPUqxH4Vx74RurQCY5rsP3q0E0EYIV6tpe+ptIIIPR5KwOZHGH5uG7y3
 fEQ9KZKL+lFEbcMzBqzuXMBemOj44+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-q4YP6aIxMlSAMoe6vdxTSQ-1; Sun, 06 Dec 2020 07:47:23 -0500
X-MC-Unique: q4YP6aIxMlSAMoe6vdxTSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F051005504;
 Sun,  6 Dec 2020 12:47:22 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-98.ams2.redhat.com [10.36.112.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B88B6062F;
 Sun,  6 Dec 2020 12:47:21 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 3/3] chtnau8824: Boost analog mic volumes a bit
Date: Sun,  6 Dec 2020 13:47:18 +0100
Message-Id: <20201206124718.14060-3-hdegoede@redhat.com>
In-Reply-To: <20201206124718.14060-1-hdegoede@redhat.com>
References: <20201206124718.14060-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>
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

Both Mic1 (internal analog mic) and Mic2 (headset mic) are a bit soft
with the current settings, boost their volumes a bit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/nau8824/EnableSeq.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ucm2/codecs/nau8824/EnableSeq.conf b/ucm2/codecs/nau8824/EnableSeq.conf
index 433e8e2..3650d06 100644
--- a/ucm2/codecs/nau8824/EnableSeq.conf
+++ b/ucm2/codecs/nau8824/EnableSeq.conf
@@ -7,8 +7,8 @@ EnableSequence [
 	cset "name='DMIC2 Enable Switch' off"
 	cset "name='DMIC3 Enable Switch' off"
 	cset "name='DMIC4 Enable Switch' off"
-	cset "name='MIC1 Volume' 10"
-	cset "name='MIC2 Volume' 10"
+	cset "name='MIC1 Volume' 14"
+	cset "name='MIC2 Volume' 14"
 	# Button Configuration
 	cset "name='THD for key media' 10"
 	cset "name='THD for key voice command' 16"
-- 
2.28.0

