Return-Path: <SRS0=5JY3=NG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD5C4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 15:53:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1146F61214
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 15:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1146F61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FFD51725;
	Sun, 15 Aug 2021 17:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FFD51725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629042821;
	bh=0uJVMlwrOn8GpNBQepSCmTmGaUQwONgnnej/6xijOak=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eZRSWmAxaF0vryRQbwl0Ip2hSMS79gz1lG+5XPNi1LBFvq8sUTo+epvDk54/M/bBm
	 6HkSpUFjPco6aqAJ5Ll0lGDoa/LxGvVPD28oW10ADCaZho97Bd5xTKGjfI/9Vh/7RR
	 /BsUn05zOHuyhvzfNM+AIPlbp4k9NLwtdds9XGWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72D1EF800F8;
	Sun, 15 Aug 2021 17:51:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2010EF8026D; Sun, 15 Aug 2021 17:51:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E760DF80301
 for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2021 17:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E760DF80301
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="NIfpyZq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629042584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cIv7mto7K0oCtVLPCfzcb2rfaoAVLQfQfdk+mXsMgdw=;
 b=NIfpyZq0l99aHssTZGmLUeJ/n+wDY0lCe2tldBPe+JcY+AlueJMs3/cubm5eGBN2jIq6uk
 qhPHRhSnXfch+NEKtHeHEXi3sxAcPa988Y2AhLA3v5a69qXkvL5QRCOqN2CRtQuNvY2+EW
 SimJxuC+LxxwejD1KPeCAKvyp02Gl+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-KVKfU4SINTWlOJb0m5f2uQ-1; Sun, 15 Aug 2021 11:49:41 -0400
X-MC-Unique: KVKfU4SINTWlOJb0m5f2uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 893F1185302F;
 Sun, 15 Aug 2021 15:49:39 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F98960871;
 Sun, 15 Aug 2021 15:49:36 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] ASoC: Intel/rt5640: Add support for HP Elite Pad 1000G2
 jack-detect
Date: Sun, 15 Aug 2021 17:49:30 +0200
Message-Id: <20210815154935.101178-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
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

The HP Elitepad 1000 G2 tablet has 2 headset jacks:

1. on the dock which uses the output of the codecs built-in HP-amp +
the standard IN2 input which is always used with the headset-jack.

2. on the tablet itself, this uses the line-out of the codec + an external
HP-amp, which gets enabled by the ALC5642 codec's GPIO1 pin; and IN1 for
the headset-mic.

The codec's GPIO1 is also its only IRQ output pin, so this means that
the codec's IRQ cannot be used on this tablet. Instead the jack-detect
is connected directly to GPIOs on the main SoC. The dock has a helper
chip which also detects if a headset-mic is present or not, so there
are 2 GPIOs for the jack-detect status of the dock. The tablet jack
uses a single GPIO which indicates if a jack is present or not.

Differentiating between between headphones vs a headset on the tablet jack
is done by using the usual mic-bias over-current-detection mechanism.

Regards,

Hans


Hans de Goede (5):
  ASoC: rt5640: Move rt5640_disable_jack_detect() up in the rt5640.c
    file
  ASoC: rt5640: Delay requesting IRQ until the machine-drv calls
    set_jack
  ASoC: rt5640: Add optional hp_det_gpio parameter to
    rt5640_detect_headset()
  ASoC: rt5640: Add rt5640_set_ovcd_params() helper
  ASoC: Intel: bytcr_rt5640: Add support for HP Elite Pad 1000G2
    jack-detect

 sound/soc/codecs/rt5640.c             | 133 ++++++++++++-----------
 sound/soc/codecs/rt5640.h             |   6 ++
 sound/soc/intel/boards/bytcr_rt5640.c | 146 +++++++++++++++++++++++++-
 3 files changed, 225 insertions(+), 60 deletions(-)

-- 
2.31.1

