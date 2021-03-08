Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F63EC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:08:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1592965266
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1592965266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A03618FE;
	Mon,  8 Mar 2021 23:07:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A03618FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615241322;
	bh=mLMZkkMl2Bzfh4IVGtjwkAGHpxCWtgNzpg3OrBejrjY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7HZ2TgZ1ace6kiMrR5twnOoATe10czspEegmtHkm/eH4atyEQk+eq8AvKE5lLsU4
	 BVeCz/PcBdPUXeB0QVuwIeE5j7iMsfLtcKj8KKeYCvncdMu7iKr2h1Fw4ts8kDwh5h
	 5emfP+ZpyuJP/ya7DgJKcderbDLtcKaA8ZQeZuOo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E22F5F8042F;
	Mon,  8 Mar 2021 23:06:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F706F8032C; Mon,  8 Mar 2021 23:06:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C97F3F801ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 23:06:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C97F3F801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="hizO1pAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615241167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xd0cfAOXRgCMojRzB8m8hWwaqiVPwUv6bqCEhkbVMI4=;
 b=hizO1pAQFOi611jmpxZT+waMbtnmqXNWCTOY6j1piamNkG98WEJ5PndQ4tcF7zeydapCO/
 PbWNpG8BBDf9wS7YNQh9n10AdcRiOj2eBO99/gTBs08J9SMXwynM0OvPCfUkIWUhqdRq6l
 2XiMPti2687kUKAbxjJgUnQ3mzg8vcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-3vbuoNKiMOORtOT1p_nlEQ-1; Mon, 08 Mar 2021 17:06:04 -0500
X-MC-Unique: 3vbuoNKiMOORtOT1p_nlEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D21BA80432D;
 Mon,  8 Mar 2021 22:06:02 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-220.ams2.redhat.com
 [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCFBD5D6D7;
 Mon,  8 Mar 2021 22:06:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf v2 4/7] codecs/rt5640: Drop bogus 'DIG MIXL DAC
 L2 Switch' setting
Date: Mon,  8 Mar 2021 23:05:51 +0100
Message-Id: <20210308220554.76111-5-hdegoede@redhat.com>
In-Reply-To: <20210308220554.76111-1-hdegoede@redhat.com>
References: <20210308220554.76111-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

The 'DIG MIXL DAC L2 Switch' path is only used for Digital Mixer Path
loopback, which we don't use. Drop it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5640/EnableSeq.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ucm2/codecs/rt5640/EnableSeq.conf b/ucm2/codecs/rt5640/EnableSeq.conf
index 4a355a5..223cceb 100644
--- a/ucm2/codecs/rt5640/EnableSeq.conf
+++ b/ucm2/codecs/rt5640/EnableSeq.conf
@@ -27,7 +27,6 @@ EnableSequence [
 	#cset "name='DAI select' 1"
 
 	cset "name='DAC2 Playback Switch' on"
-	cset "name='DIG MIXL DAC L2 Switch' on"
 
 	# Input Configuration
 	cset "name='Stereo ADC1 Mux' ADC"
-- 
2.30.1

