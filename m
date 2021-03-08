Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA49EC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:09:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5B6525A
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5B6525A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B13301900;
	Mon,  8 Mar 2021 23:08:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B13301900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615241365;
	bh=WwAL+TTzSVNa/9uYCybIZbpOA0g9tnerO+XakRdHXH0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJnhsDd0jAPM6Z870M/kO9BNFnQIRV+u4OP+UFFmWpl1CeOBdbQm3IaJQa95NJ5Ur
	 +d8eg+UgcNq0/R+PiXoiHlovGP19JroGCB5r44uvlnP6E7Q0OdsTLV1cV0j23+LYUO
	 kZcM4N97c2Dx76+7MWNxUVxcCZAgLtyrAWUS2K8U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81F49F804AD;
	Mon,  8 Mar 2021 23:06:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01FE0F8032C; Mon,  8 Mar 2021 23:06:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5499CF8016C
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 23:06:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5499CF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="UmOa9goZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615241169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnWvyjFQqKM9ujEqfBOs1dQnNNhzC5LgHelymMCKBWM=;
 b=UmOa9goZBPUd3n/x935OCHFTqjFZOl/xaHgztr/07hLiGZsSaJBJKJdVxp225Ywg6rmmAW
 5wafqkmssUKWctE7/yVaLVqD797zSoiH3PoFI8g3n0H4f2bhOVzOce++aG5uUwWv7B1Di3
 jjZWQFmtuagRXjV8n8cYiDmMMfEjd3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-Dms9DB9fOp-lDq31mFo0yw-1; Mon, 08 Mar 2021 17:06:05 -0500
X-MC-Unique: Dms9DB9fOp-lDq31mFo0yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C0D80432E;
 Mon,  8 Mar 2021 22:06:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-220.ams2.redhat.com
 [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23DD25D6D7;
 Mon,  8 Mar 2021 22:06:02 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf v2 5/7] codecs/rt5640: Unify capture volume for
 AIF1 and AIF2 recording paths
Date: Mon,  8 Mar 2021 23:05:52 +0100
Message-Id: <20210308220554.76111-6-hdegoede@redhat.com>
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

The rt5640 codec is sometimes used with AIF1 connected to the
SoC and sometimes with AIF2 connected to the SoC.

The rt5640 UCM configuration deals with this by accepting input from
and sending output to both AIFs, relying on the kernels DAPM framework to
disable parts of the graph which are connected to the unconnected AIF.

Before this commit codecs/rt5640/EnableSeq.conf was adding a +9dB
(digital) boost to recording going through the 'ADC' path to AIF1,
while not touching the 'Mono ADC' path to AIF2.

This was causing recordings on devices using AIF2 to be somewhat soft.

This commit unifies the record volume control settings for both paths by
only using the '[Mono ]ADC Capture Volume' control, which is present
in both paths and setting it to +9dB on both paths.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5640/EnableSeq.conf | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ucm2/codecs/rt5640/EnableSeq.conf b/ucm2/codecs/rt5640/EnableSeq.conf
index 223cceb..49703ae 100644
--- a/ucm2/codecs/rt5640/EnableSeq.conf
+++ b/ucm2/codecs/rt5640/EnableSeq.conf
@@ -39,10 +39,14 @@ EnableSequence [
 	cset "name='Mono ADC R2 Mux' DMIC R1"
 	cset "name='Mono ADC Capture Switch' on"
 
-	# 47=0dB, 0.375 dB/step, set it to 6 dB to help with soft mics
-	cset "name='ADC Capture Volume' 63"
-	# Set ADC Boost Gain to 3dB higher vals result in too much noise
-	cset "name='ADC Boost Gain' 1"
+	# 47=0dB, 0.375 dB/step, set it to 9 dB to help with soft mics
+	cset "name='ADC Capture Volume' 71"
+	cset "name='Mono ADC Capture Volume' 71"
+
+	# The second 'Mono ADC' path does not have a 'Boost Gain',
+	# set this to 0dB so that the volume of the AIF1 and AIF2 paths is equal.
+	cset "name='ADC Boost Gain' 0"
+
 	# Set IN1/IN3 internal mic boost to 8 (max)
 	# Set IN2 headset-mic boost to 1, headset mics are quite loud
 	cset "name='IN1 Boost' 8"
-- 
2.30.1

