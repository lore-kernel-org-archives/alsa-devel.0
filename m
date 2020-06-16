Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8EC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:30:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720A1208D5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s5IRGnoo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="rqBhaWQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720A1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E33891607;
	Tue, 16 Jun 2020 20:29:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E33891607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592332247;
	bh=/4Cea+h5oFvnpOvKed7L21VpRGeFz4E0so5+LbyMbBs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s5IRGnooJHYn+Wbv5XKrcdIA4j6ruOQGKg+uvwkGahbZuAuy67nB+jiwukDFGiUGi
	 0ireXEgi4UNo72Rsgssz1e4hsUlflmu46xxVK0o4jlc93DLs4RmgagEnbT1q53w7lV
	 IHRtTx31+PeoKquaAxk1IVDvEjBQwMGwZ16V3PfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7856FF80217;
	Tue, 16 Jun 2020 20:29:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FEB2F8022B; Tue, 16 Jun 2020 20:29:53 +0200 (CEST)
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03335F800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 20:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03335F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com
 header.b="rqBhaWQx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
 Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
 In-Reply-To:References; bh=VIe0bQZcvcfjdNQJXJvZjKVciBWksqW8vdNTdZmw4Lg=; b=rq
 BhaWQxySRB2DZWNFd67fu2v1zr+UwxLZLg+gemjDAChPFa/SvCF+GFTFt7rAO9fz5+w+sxYtUf2aX
 HA9KfcNjnR0n0WkhubWWAF8iE+6JIl6zAwOoeqH3rwZ3zvHly9kKqB2zTnApTsQUn0ET0QgVsDSyr
 y7BNeMbZfBw8WNHZEyWzibvVLy7AQRHyPZzO/PMsvZG0frZgJL58TirjQu/yYFnaDTnjssyYDHGkS
 2hk790FjCyNOAjwd3ggbGG+ezkc+LUC0vuarh7m90clhdJvoD7YmXZZUUi52Jwm+MXZ9n3sEshAFS
 Fe6cC1n5M3qdVRFy/roiXM1kAuCD2nbA==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot.metanate.com)
 by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93) (envelope-from <john@metanate.com>)
 id 1jlGLA-0008B7-9x; Tue, 16 Jun 2020 19:29:44 +0100
From: John Keeping <john@metanate.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] control: ctlparse - use type-specific bound on
 element count
Date: Tue, 16 Jun 2020 19:29:30 +0100
Message-Id: <20200616182930.480959-1-john@metanate.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Cc: John Keeping <john@metanate.com>
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

Using a fixed bound of 128 means that too many values may be set for an
INTEGER64 type and that any elements past 128 are out of reach for BYTE
type controls.

Derive the maximum number of elements from the type so that the full
range is parsed for all types.

Signed-off-by: John Keeping <john@metanate.com>
---
 src/control/ctlparse.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index 1ac31bb9..ee1e0602 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -304,6 +304,25 @@ static int get_ctl_enum_item_index(snd_ctl_t *handle,
 	return -1;
 }
 
+static unsigned int get_ctl_type_max_elements(snd_ctl_elem_type_t type)
+{
+	struct snd_ctl_elem_value value;
+
+	switch (type) {
+	case SND_CTL_ELEM_TYPE_BOOLEAN:
+	case SND_CTL_ELEM_TYPE_INTEGER:
+		return ARRAY_SIZE(value.value.integer.value);
+	case SND_CTL_ELEM_TYPE_INTEGER64:
+		return ARRAY_SIZE(value.value.integer64.value);
+	case SND_CTL_ELEM_TYPE_ENUMERATED:
+		return ARRAY_SIZE(value.value.enumerated.item);
+	case SND_CTL_ELEM_TYPE_BYTES:
+		return ARRAY_SIZE(value.value.bytes.data);
+	default:
+		return 0;
+	}
+}
+
 /**
  * \brief parse ASCII string as CTL element value
  * \param handle CTL handle
@@ -331,8 +350,11 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
 	type = snd_ctl_elem_info_get_type(info);
 	count = snd_ctl_elem_info_get_count(info);
 	snd_ctl_elem_value_set_id(dst, &myid);
+
+	if (count > get_ctl_type_max_elements(type))
+		count = get_ctl_type_max_elements(type);
 	
-	for (idx = 0; idx < count && idx < 128 && ptr && *ptr; idx++) {
+	for (idx = 0; idx < count && ptr && *ptr; idx++) {
 		if (*ptr == ',')
 			goto skip;
 		switch (type) {
-- 
2.27.0

