Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E9C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 10:07:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A4C64ED1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A4C64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC8911676;
	Wed, 24 Feb 2021 11:06:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC8911676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614161216;
	bh=E4CWuuHmPTS+VZ8JcV0Nl28ae2zoDzxCfnvM61EHSz0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J6ZCcY1cP60rBNlL2B9nD7/WN0QxyDzIACs50PJK3JotkpQzGoBJuH2P5oCpLh+E/
	 Bui+17RkSUGN/ep2be83URhykCp+uiA+HaTcfZx6kIhEtpP35NfvAlSzdmO6BkISt9
	 qIbic23MNs7QIP6tuKMrXb7jgMGNeXJ7jhwsXmgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76A6DF8016C;
	Wed, 24 Feb 2021 11:06:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CDE1F8022B; Wed, 24 Feb 2021 11:06:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75982F80159
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 11:05:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75982F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Hb/yylXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614161157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zqYNf7sFdh8qp1/+UHpQTi4e/KbQaUusEFZ/0Cmda0I=;
 b=Hb/yylXmMhsR89ZoXTw0m7eBhw7vJ1Dp7yFoKoaBpUskwlB1pDt8XsvPPK2nxboCsGu81A
 xOCcHlTL9f4N8TiYC1VM0VVUGGpV1ekG68do7Q6ch/wMAYe0UFLmN1O8IJDMxqylSmBVFW
 ruCjufQMOVliA8fqli70pVmwfKUB1KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-IQjQA1OlO6acwRz2mVjl7A-1; Wed, 24 Feb 2021 05:05:55 -0500
X-MC-Unique: IQjQA1OlO6acwRz2mVjl7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7181935799;
 Wed, 24 Feb 2021 10:05:54 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-243.ams2.redhat.com [10.36.113.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 115355D9D0;
 Wed, 24 Feb 2021 10:05:52 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 1/3] mixer: Unify simple_none: base_len() exception
 handling
Date: Wed, 24 Feb 2021 11:05:49 +0100
Message-Id: <20210224100551.15141-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Unify simple_none: base_len() exception handling:

1. In the "Input Source" and "3D Control" cases the base-name is the same
   as the full-name and base_len() simply returns strlen(name).
   Instead of returning 0 when the type is unknown, set the type to
   CTL_SINGLE and return strlen(name). This allows removing the special
   case for base_len() returning 0 in simple_event_add().

2. Move the special handling for "Capture Volume" and "Capture Switch"
   from simple_event_add() to base_len(), so that we handle all exceptions
   inside base_len(). Instead of handling some special cases in base_len()
   and other special cases in simple_event_add().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 43 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index e9dc1730..7da7de1e 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -907,11 +907,22 @@ static const struct suf {
 };
 #endif
 
-/* Return base length or 0 on failure */
+/* Return base length */
 static int base_len(const char *name, selem_ctl_type_t *type)
 {
 	const struct suf *p;
 	size_t nlen = strlen(name);
+
+	/* exception: "Capture Volume" and "Capture Switch" */
+	if (!strcmp(name, "Capture Volume")) {
+		*type = CTL_CAPTURE_VOLUME;
+		return strlen("Capture");
+	}
+	if (!strcmp(name, "Capture Switch")) {
+		*type = CTL_CAPTURE_SWITCH;
+		return strlen("Capture");
+	}
+
 	p = suffixes;
 	while (p->suffix) {
 		size_t slen = strlen(p->suffix);
@@ -944,7 +955,9 @@ static int base_len(const char *name, selem_ctl_type_t *type)
 			return strlen(name);
 		}
 	}
-	return 0;
+
+	*type = CTL_SINGLE;
+	return strlen(name);
 }
 
 
@@ -1605,8 +1618,10 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 {
 	const char *name = snd_hctl_elem_get_name(helem);
+	selem_ctl_type_t type;
+	char ename[128];
 	size_t len;
-	selem_ctl_type_t type = CTL_SINGLE; /* to shut up warning */
+
 	if (snd_hctl_elem_get_interface(helem) != SND_CTL_ELEM_IFACE_MIXER)
 		return 0;
 	if (strcmp(name, "Capture Source") == 0) {
@@ -1633,22 +1648,14 @@ static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 		}
 		return 0;
 	}
+
 	len = base_len(name, &type);
-	if (len == 0) {
-		return simple_add1(class, name, helem, CTL_SINGLE, 0);
-	} else {
-		char ename[128];
-		if (len >= sizeof(ename))
-			len = sizeof(ename) - 1;
-		memcpy(ename, name, len);
-		ename[len] = 0;
-		/* exception: Capture Volume and Capture Switch */
-		if (type == CTL_GLOBAL_VOLUME && !strcmp(ename, "Capture"))
-			type = CTL_CAPTURE_VOLUME;
-		else if (type == CTL_GLOBAL_SWITCH && !strcmp(ename, "Capture"))
-			type = CTL_CAPTURE_SWITCH;
-		return simple_add1(class, ename, helem, type, 0);
-	}
+	if (len >= sizeof(ename))
+		len = sizeof(ename) - 1;
+	memcpy(ename, name, len);
+	ename[len] = 0;
+
+	return simple_add1(class, ename, helem, type, 0);
 }
 
 static int simple_event_remove(snd_hctl_elem_t *helem,
-- 
2.30.1

