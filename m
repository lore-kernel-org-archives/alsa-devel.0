Return-Path: <SRS0=3jBL=AJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F8C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:47:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DAB20772
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mtb6C+41";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/l2AE2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DAB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05D1C1672;
	Sun, 28 Jun 2020 19:46:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05D1C1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593366456;
	bh=3vLHdtbe8I6wc5piqoGw6Z0Rat4Ovta3EIrg+BzEkzU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mtb6C+41hEybIQyW5SnajLpgfMKiBnGQwBwMkIADjwqUbCvhi1BQmhgAe05ycS2BN
	 TyBl1wL2mK8hU3MR0gq/7jB+Eg/xY/NE9F+CbLUofWcUAOar0b4UwVMD6kQDpP8PaU
	 lbBmAu65aeue2KB3BTG5dKE7otLVufhscnrgK5Fo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A5F8F802A9;
	Sun, 28 Jun 2020 19:44:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ADE6F800E8; Sun, 28 Jun 2020 19:44:35 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF8C7F8022D
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2020 19:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF8C7F8022D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="G/l2AE2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593366270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAwEwJJjupzTaezwR7yIngNVexOZCOWPArujMLd3zbc=;
 b=G/l2AE2Wu548jo+zC+qC75+1u5kdeyUiBZpvOzrKm2eUKJnyTaO48i+81I4UpIwKU3zgjw
 JRJs+6/R33cPzLnuXsigjUFZm3GPNEcfVKsp+kZYUKUp6F/sEk4wlZ8coR4vQeolez5Tsx
 K7CvtgkhIMJEEBkKywgsGfbWzhTCtGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-WvJaUwNfNTCR8LnGThZmPg-1; Sun, 28 Jun 2020 13:44:28 -0400
X-MC-Unique: WvJaUwNfNTCR8LnGThZmPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E691800D42;
 Sun, 28 Jun 2020 17:44:27 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51005D9D5;
 Sun, 28 Jun 2020 17:44:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 4/5] cht-bsw-rt5672: Boost ADC volume a bit
Date: Sun, 28 Jun 2020 19:44:20 +0200
Message-Id: <20200628174421.115133-4-hdegoede@redhat.com>
In-Reply-To: <20200628174421.115133-1-hdegoede@redhat.com>
References: <20200628174421.115133-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Both the DMICs and the headset mic are quite soft, even with the 20 dB
IN1 boost we already congfigure for the headset.

This commit sets the ADC Boost gain (range 0-3) to 1 = 12 dB, which makes
the volume a lot better. The next step of the ADC Boost gain setting is
24 dB which is a bit too much.

This has been tested with both the builtin DMIC and with a headset mic
on the following devices:

Lenovo Miix 2 10
Lenovo Thinkpad 8
Lenovo Thinkpad 10 (gen 1)

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5672/EnableSeq.conf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ucm2/codecs/rt5672/EnableSeq.conf b/ucm2/codecs/rt5672/EnableSeq.conf
index a19a982..ddfb1c7 100644
--- a/ucm2/codecs/rt5672/EnableSeq.conf
+++ b/ucm2/codecs/rt5672/EnableSeq.conf
@@ -30,6 +30,11 @@ EnableSequence [
 	cset "name='ADC Capture Volume' 47"
 	cset "name='ADC Capture Switch' on"
 
+	# Both the DMICs and the headset mic (even with the 20 dB boost below)
+	# are quite soft, set the ADC Boost gain (range 0-3) to 1 = 12 dB the
+	# next step is 24 dB which is a bit too much
+	cset "name='STO1 ADC Boost Gain Volume' 1"
+
 	# Headset mic is quite soft, boost it a bit, 1 = 20dB which is the first
 	# available boost step
 	cset "name='IN1 Boost Volume' 1"
-- 
2.26.2

