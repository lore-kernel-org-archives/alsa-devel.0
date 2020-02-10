Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCAC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:29:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE96F2082F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qry5aEyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE96F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 501BE168F;
	Mon, 10 Feb 2020 14:28:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 501BE168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581341344;
	bh=JtJkvvTosqYhgxYfWk67dvfppgIRB81IIcL0LIAW9q0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qry5aEyksX8EqQLH5zl+P741rz4HAerh/wEaloHSgX2bxqZsL0tHGqIVD7QuTy+Uy
	 8Racv1dWTsgsXFZbkoL7ZwuUlYkN7jlzq5vz9HQW374WxT3k9Lo8YdIagbXhrH0NgT
	 fcBU1yOQAyaZ9Zx6pbrMXjS3+ZnLHrQSe2tB12IY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00214F80228;
	Mon, 10 Feb 2020 14:26:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84A51F80240; Mon, 10 Feb 2020 14:26:34 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 336B0F8014F
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 14:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 336B0F8014F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0E2D9B1D4
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 13:25:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 10 Feb 2020 14:25:14 +0100
Message-Id: <20200210132516.20221-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200210132516.20221-1-tiwai@suse.de>
References: <20200210132516.20221-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH alsa-lib 1/3] control: Remove access to the
	deprecated dimen fields
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The dimen fields of control element has been deprecated, and it's
finally dropped in kernel 5.6 ABI definition.  Remove the
corresponding accesses in alsa-lib code.

As of this patch, it's disabled via ifdef, just to be sure.  The
disabled code should be removed in a later stage as a cleanup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/control/control.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 33650155cac7..27f421350fb7 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -303,6 +303,7 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 	return ctl->ops->element_info(ctl, info);
 }
 
+#if 0 /* deprecated */
 static bool validate_element_member_dimension(snd_ctl_elem_info_t *info)
 {
 	unsigned int members;
@@ -328,6 +329,9 @@ static bool validate_element_member_dimension(snd_ctl_elem_info_t *info)
 
 	return members == info->count;
 }
+#else /* deprecated */
+#define validate_element_member_dimension(info)		true
+#endif /* deprecated */
 
 /**
  * \brief Create and add some user-defined control elements of integer type.
@@ -2510,11 +2514,12 @@ const char *snd_ctl_elem_info_get_item_name(const snd_ctl_elem_info_t *obj)
  * #snd_ctl_elem_info_get_dimensions is deprecated without any replacement.
  */
 #ifndef DOXYGEN
-EXPORT_SYMBOL int INTERNAL(snd_ctl_elem_info_get_dimensions)(const snd_ctl_elem_info_t *obj)
+EXPORT_SYMBOL int INTERNAL(snd_ctl_elem_info_get_dimensions)(const snd_ctl_elem_info_t *obj ATTRIBUTE_UNUSED)
 #else
 int snd_ctl_elem_info_get_dimensions(const snd_ctl_elem_info_t *obj)
 #endif
 {
+#if 0 /* deprecated */
 	int i;
 
 	assert(obj);
@@ -2522,6 +2527,9 @@ int snd_ctl_elem_info_get_dimensions(const snd_ctl_elem_info_t *obj)
 		if (obj->dimen.d[i])
 			break;
 	return i + 1;
+#else
+	return -EINVAL;
+#endif
 }
 use_default_symbol_version(__snd_ctl_elem_info_get_dimensions, snd_ctl_elem_info_get_dimensions, ALSA_0.9.3);
 
@@ -2535,15 +2543,19 @@ use_default_symbol_version(__snd_ctl_elem_info_get_dimensions, snd_ctl_elem_info
  * #snd_ctl_elem_info_get_dimension is deprecated without any replacement.
  */
 #ifndef DOXYGEN
-EXPORT_SYMBOL int INTERNAL(snd_ctl_elem_info_get_dimension)(const snd_ctl_elem_info_t *obj, unsigned int idx)
+EXPORT_SYMBOL int INTERNAL(snd_ctl_elem_info_get_dimension)(const snd_ctl_elem_info_t *obj ATTRIBUTE_UNUSED, unsigned int idx ATTRIBUTE_UNUSED)
 #else
 int snd_ctl_elem_info_get_dimension(const snd_ctl_elem_info_t *obj, unsigned int idx)
 #endif
 {
+#if 0 /* deprecated */
 	assert(obj);
 	if (idx > 3)
 		return 0;
 	return obj->dimen.d[idx];
+#else /* deprecated */
+	return -EINVAL;
+#endif /* deprecated */
 }
 use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_get_dimension, ALSA_0.9.3);
 
@@ -2565,9 +2577,10 @@ use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_
  * \deprecated Since 1.1.5
  * #snd_ctl_elem_info_set_dimension is deprecated without any replacement.
  */
-int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
-				    const int dimension[4])
+int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info ATTRIBUTE_UNUSED,
+				    const int dimension[4] ATTRIBUTE_UNUSED)
 {
+#if 0 /* deprecated */
 	unsigned int i;
 
 	if (info == NULL)
@@ -2581,6 +2594,9 @@ int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
 	}
 
 	return 0;
+#else /* deprecated */
+	return -EINVAL;
+#endif /* deprecated */
 }
 
 /**
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
