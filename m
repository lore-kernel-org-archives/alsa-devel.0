Return-Path: <SRS0=dtPj=J7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B55C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 15:59:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BCC610FC
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 15:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BCC610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 246841695;
	Tue,  4 May 2021 17:58:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 246841695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620143978;
	bh=lEB9iJbJj8TCqGAgBbcMjYWuoHrkbNpiGsJuGytQN9k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l6Q/BzPApoUX7H6dkStdAF6BMoLW6kElb6rbkRXKyn+ab02A+SB8U2ERTjqNMb+4B
	 J49gntiYKi54v/Y0GGzajSYM8WggFsxKmWoh1XSqrmhZeaHsHoDMU0LW+QVsh/A1FY
	 QhkDLZ+ooiScLArErJFaK0IN63O1HvA/UONwom5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA71AF801F7;
	Tue,  4 May 2021 17:58:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02FEDF8021C; Tue,  4 May 2021 17:58:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72F4EF80108
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 17:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72F4EF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="P3TAUSY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620143917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bi4gN+Kl8PJFA4SDDgYRXfgNccKEgcF1NJ7/19vtD1A=;
 b=P3TAUSY5LndjCSDHI3IAijf9z8DNJ0Ed3FFDN+7uZMP3as7z3C0/j3ZVXi/13OxwK5hEl6
 /GBDkHCqkKuDJ+1lQm53M0Dh6fP0vHgfAiGjVVv03fClwLbSUr5BcM08ZtGpLFP+EBunEL
 dRt5bCZoitV3CrYXRsRcxw4g0QBDHvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-SJYBwaXqM_iLlQA9uE7Mww-1; Tue, 04 May 2021 11:58:34 -0400
X-MC-Unique: SJYBwaXqM_iLlQA9uE7Mww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCD26D4E8;
 Tue,  4 May 2021 15:58:32 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE66059446;
 Tue,  4 May 2021 15:58:31 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] mixer: simple - Fix "Capture Volume" and "Capture
 Switch" being seen as global controls
Date: Tue,  4 May 2021 17:58:30 +0200
Message-Id: <20210504155830.112653-1-hdegoede@redhat.com>
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

Fix the "Capture Volume" and "Capture Switch" exceptions no longer
working after commit 86b9c67774bc ("mixer: simple - Unify simple_none:
base_len() exception handling") because they were moved to after the
suffix checking, so they would be treated as CTL_GLOBAL_VOLUME resp.
CTL_GLOBAL_SWITCH based on their suffix before the exception check
has a chance to check for a match.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 71d88486..9b9f0000 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -913,6 +913,16 @@ static int base_len(const char *name, selem_ctl_type_t *type)
 	const struct suf *p;
 	size_t nlen = strlen(name);
 
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
 	for (p = suffixes; p->suffix; p++) {
 		size_t slen = strlen(p->suffix);
 		size_t l;
@@ -926,16 +936,6 @@ static int base_len(const char *name, selem_ctl_type_t *type)
 		}
 	}
 
-	/* exception: "Capture Volume" and "Capture Switch" */
-	if (!strcmp(name, "Capture Volume")) {
-		*type = CTL_CAPTURE_VOLUME;
-		return strlen("Capture");
-	}
-	if (!strcmp(name, "Capture Switch")) {
-		*type = CTL_CAPTURE_SWITCH;
-		return strlen("Capture");
-	}
-
 	/* Special case - handle "Input Source" as a capture route.
 	 * Note that it's *NO* capture source.  A capture source is split over
 	 * sub-elements, and multiple capture-sources will result in an error.
-- 
2.31.1

