Return-Path: <SRS0=1Izd=FK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE479C433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 12:49:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FBE2310E
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 12:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FBE2310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9561175C;
	Sun,  6 Dec 2020 13:48:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9561175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607258956;
	bh=L3BBYYK4TPGXP5h3blKl4qQRJmTuCUhUXIKKvUFi+GQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XrL1O7HG7T5l9KaHCqiilVN++eegYAeK2GUQVtsJ1OjxiX6kcDVNrpuApzr9iGF7u
	 H/TfNeEMZkYEyw61QbPuQv0o/iiJrUfQ+cEywKRk1KgV/ejciaHohWnIx324PjsFK4
	 UVW61fAFOMj+W+g9G3J2dIFe8ZvY2dr684x3K1g4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49F61F804E1;
	Sun,  6 Dec 2020 13:47:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5511BF804E0; Sun,  6 Dec 2020 13:47:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0300F804D8
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2020 13:47:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0300F804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="PfzRESOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607258842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ip+rEu3WGTBF4375OEUQcNeQRUduLPow3yEgQ34DgmQ=;
 b=PfzRESOYv0GuC/uAs5iR/ElGnf0kfXonLMGx5fHZMYPEO+R98uUNu4Djj7eneezapUL+64
 6FrKHG4XCESiNhmsRK+683/vy4J8yDSXNke6LJDaJu2Q8YoZI13zabK7qXfPAkJKpHlVUQ
 J0HUS4oHRyjI0m7KIKZww3PMCFEiYpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-wiVLaPExMO-oj1B0pkHO4A-1; Sun, 06 Dec 2020 07:47:21 -0500
X-MC-Unique: wiVLaPExMO-oj1B0pkHO4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2042A803638;
 Sun,  6 Dec 2020 12:47:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-98.ams2.redhat.com [10.36.112.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24FD76062F;
 Sun,  6 Dec 2020 12:47:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 1/3] chtnau8824: Fix mono speaker config not working
Date: Sun,  6 Dec 2020 13:47:16 +0100
Message-Id: <20201206124718.14060-1-hdegoede@redhat.com>
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

Fix the Speaker define / var being changed from "Speaker" to "MonoSpeaker"
not having any effect because the variable gets expanded before the if
making the change is interpreted.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/chtnau8824/HiFi.conf | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/ucm2/chtnau8824/HiFi.conf b/ucm2/chtnau8824/HiFi.conf
index 3ccd6b1..d7a5f63 100644
--- a/ucm2/chtnau8824/HiFi.conf
+++ b/ucm2/chtnau8824/HiFi.conf
@@ -34,8 +34,15 @@ SectionVerb {
 	}
 }
 
-Include.spk.File "/codecs/nau8824/${var:Speaker}.conf"
-Include.hp.File "/codecs/nau8824/HeadPhones.conf"
+# The includes using $vars in there path must be conditional otherwise the
+# $var gets expanded before the other If-s above can change the vars.
+If.cfg-includes {
+	Condition { Type String Empty "" }
+	True {
+		Include.spk.File "/codecs/nau8824/${var:Speaker}.conf"
+		Include.hp.File "/codecs/nau8824/HeadPhones.conf"
 
-Include.mic.File "/codecs/nau8824/InternalMic.conf"
-Include.hsmic.File "/codecs/nau8824/HeadsetMic.conf"
+		Include.mic.File "/codecs/nau8824/InternalMic.conf"
+		Include.hsmic.File "/codecs/nau8824/HeadsetMic.conf"
+	}
+}
-- 
2.28.0

