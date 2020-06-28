Return-Path: <SRS0=3jBL=AJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99DC433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:47:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1FF2053B
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hFJngtH/";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5a6f2fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1FF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DED7B1680;
	Sun, 28 Jun 2020 19:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DED7B1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593366427;
	bh=EATHoULJrE6/XF89BbGJdousPDC0UeUO1tMry5YDs3k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFJngtH/NbftE++TJqrYUEOevsJw8JCmrXZwBgZkeG73P1kcv1HmxDUTkS/l5MciL
	 hMD9doFFCnf51/MpLCtyF32GFrT8E06u2HjUnVrnkRhThADrhVD/EmEk+v+nwe3bFe
	 8YaQXCQBZPvl2GjZlX4VIUXnLU4kIC8wS2tDpn3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86A44F80096;
	Sun, 28 Jun 2020 19:44:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D53D6F800F0; Sun, 28 Jun 2020 19:44:34 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEC0AF800E8
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2020 19:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEC0AF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="H5a6f2fI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593366269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXMJHfA7mGR8OF6QjiFnJTIObwW3Ga7V2OHP8q3xFfc=;
 b=H5a6f2fIuFc4a/yYb0H4lMumSfcoSpjEndaITOsjtW5r7plIbBvXtgvn1qIjbf8hhWS0jt
 5kOtL0Y23wpgPdGm0Ma4fspJIj43Y9MwGigmEJQMKFXzwheYEDcF/1TssCIAVFpDd9BUJs
 hpEgHneCYQ8lY5AiiseyZcfXzrUj7Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-RkUmkuv4MC6k_8ezHokbWQ-1; Sun, 28 Jun 2020 13:44:27 -0400
X-MC-Unique: RkUmkuv4MC6k_8ezHokbWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81437802ED4;
 Sun, 28 Jun 2020 17:44:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB58F5D9D5;
 Sun, 28 Jun 2020 17:44:25 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 3/5] cht-bsw-rt5672: Add Lenovo ThinkPad 10 specific
 configuration
Date: Sun, 28 Jun 2020 19:44:19 +0200
Message-Id: <20200628174421.115133-3-hdegoede@redhat.com>
In-Reply-To: <20200628174421.115133-1-hdegoede@redhat.com>
References: <20200628174421.115133-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
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

The Lenovo ThinkPad 10 (first gen) has stereo speakers and the stereo
DMICs in the top-edge of the tablet are connected to DMIC1.

Add a RegexMatch for this, so that users do not have to select the right
settings manually.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/cht-bsw-rt5672/HiFi.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ucm2/cht-bsw-rt5672/HiFi.conf b/ucm2/cht-bsw-rt5672/HiFi.conf
index 94de7db..5e5f78f 100644
--- a/ucm2/cht-bsw-rt5672/HiFi.conf
+++ b/ucm2/cht-bsw-rt5672/HiFi.conf
@@ -11,7 +11,7 @@ If.cfg-dmic1 {
 	Condition {
 		Type RegexMatch
 		String "${CardLongName}"
-		Regex "(LENOVO.*LenovoMiix210)"
+		Regex "(LENOVO.*LenovoMiix210)|(LENOVO.*ThinkPad10)"
 	}
 	True {
 		Define.MonoSpeaker ""
-- 
2.26.2

