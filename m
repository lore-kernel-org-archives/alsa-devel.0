Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8B8C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:56:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7322081A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tczl3KJg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="YAs4SfBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7322081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E134167A;
	Fri, 12 Jun 2020 11:55:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E134167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591955789;
	bh=eAUVqNZyLYmdbWi6mDZWThDLmRkqVj/S2aKkk5tnJfg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tczl3KJge33foIOXFFgXUapm+4CreJhO58yQq27X8tJ13Yxr3XMWphj8AH/0bdDvk
	 p5pF3KNQcLLIoVUUv9m3DHaolqabnLdIrwprewcLRp50yuGIXyI99VS6vq3nG8veyE
	 sWsveLouvDKIXK6E1yRDb7LZ/nn7qkTHFF575VH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2F6EF80279;
	Fri, 12 Jun 2020 11:55:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B3C1F80058; Fri, 12 Jun 2020 11:55:35 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8372FF80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 11:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8372FF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="YAs4SfBK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IdS0DDq8gnCnu/u0ux9K37AYsOXCFE94seg+Gqliq/0=; b=YAs4SfBK5+1mHfIrPNCQ6JkcYk
 1qnxqBKwbKyq59nwc+47LwpWYobIZiglN9shb9KKkgES6/+dub6/ZOPjMFhKtL5uSgcXmtDipDDuE
 hGiDSxHYnPT110GtAebwwOcwI9xTxBfqlVj1D24YUwQE6/0fOaL+MGft10yIQn5vDKk/qhv1DKXvt
 eCi0V5YIxiQJMz8wc3NejylxHc2vgEx09HegU8QXKjsHFQdj3gjy3jdFzOxDfofobTU+B2IH6Q1eR
 Rpqt4DxH2yUaT3gYcvDAme7AZiYvF+xSi1ySYd92FRX0sm5Xenb3C1lHIgI5OHbhbZxa3jtAg9rCr
 GzepwPNw==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jjgPK-000ATV-Hv; Fri, 12 Jun 2020 10:55:30 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jjgPK-00012l-6x; Fri, 12 Jun 2020 10:55:30 +0100
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 2/9] control: Fix a bug that prevented namehint behaviour
Date: Fri, 12 Jun 2020 10:55:23 +0100
Message-Id: <20200612095530.3970-2-mark@xwax.org>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <2006121020220.23374@stax.localdomain>
References: <2006121020220.23374@stax.localdomain>
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

Looks like the documented behaviour was broken in commit 1ba513f9 in
2006, with the introduction of multiple fields.

I've chosen to match the described behaviour. Prior to this patch,
using namehint could be made to work by exploiting the lack of escaping
of the "name", populating the other fields:

  "plug:front|DESCDo all conversions for front speakers"

rather than that which is documented and presumed to be the intention
for asoundrc files:

  "plug:front|Do all conversions for front speakers"

Everything seems to strongly suggest nobody is using this feature; I can
find no working examples through a web search and probably someone
would have hit this bug. It's not documented in configuration, only in
the snd_device_name_hint() call. So it would probably clutter things to
provide compatibility for the old behaviour.

I have found it to be very useful since working in Chromium, where it is
the only way to expose chosen ALSA devices to web applications.

A temporary buffer is required to null-terminate the string.  I see no
use of alloca() in the code, presumably to avoid unbounded stack size.
So memory is allocated on the heap.
---
 src/control/namehint.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index d81d3a7e..e4f696ad 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -78,6 +78,31 @@ static int hint_list_add(struct hint_list *list,
 	return 0;
 }
 
+/**
+ * Add a namehint from string given in a user configuration file
+ */
+static int hint_list_add_custom(struct hint_list *list,
+				const char *entry)
+{
+	int err;
+	const char *sep;
+	char *name;
+
+	assert(entry);
+
+	sep = strchr(entry, '|');
+	if (sep == NULL)
+		return hint_list_add(list, entry, NULL);
+
+	name = strndup(entry, sep - entry);
+	if (name == NULL)
+		return -ENOMEM;
+
+	err = hint_list_add(list, name, sep + 1);
+	free(name);
+	return err;
+}
+
 static void zero_handler(const char *file ATTRIBUTE_UNUSED,
 			 int line ATTRIBUTE_UNUSED,
 			 const char *function ATTRIBUTE_UNUSED,
@@ -626,7 +651,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 			if (snd_config_get_string(snd_config_iterator_entry(i),
 						  &str) < 0)
 				continue;
-			err = hint_list_add(&list, str, NULL);
+			err = hint_list_add_custom(&list, str);
 			if (err < 0)
 				goto __error;
 		}
-- 
2.17.5

