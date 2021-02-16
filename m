Return-Path: <SRS0=ZdwS=HS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21456C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 21:37:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8736E64E2B
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 21:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8736E64E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1CA82C;
	Tue, 16 Feb 2021 22:36:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1CA82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613511423;
	bh=ZPGClo/OzSbjpMHVvYzHZk9ObF/SP++P7OiPPY+ljbg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lOEJWE1DR1g0PBNTS02h5uKwg654EslyiPfJL8cKzSQdiHFwnERN+wbwqIvL/1/Cu
	 EWn2F/TON+c0nUzO3QMY/uHtvcDg+a8PV/U5vAoUStm5W1MwX+wLodT8zsTVghQkyR
	 OZA8yyv34VEasHNwOartITh3X6xfPeKZzJMPWk+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BF8DF800AE;
	Tue, 16 Feb 2021 22:36:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE089F800AE; Tue, 16 Feb 2021 22:36:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEAB4F800AE
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2021 22:36:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEAB4F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Yy60Hryz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613511363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iS4KpgJoiq+/yYNhNwdvxBXgfLSPW0Wl1pKH5ILeWBw=;
 b=Yy60HryzGfsyMH4Vsive8G9PaGZYWqHw7dzJiedjbyCsN1Hheoa13V9Qi4PXLQxDybU5WZ
 MYOEPL3UzzLSnbo+7gzXwG1/ObYd324xlZqHrfe3C+XQiHU5IDyS14owT5uB3+Bdj3KZHM
 PKUK7t0MVpQYbV4bmRjrTsssxoO1OuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-EvRdR_JnOxK_TjJNEbmkvA-1; Tue, 16 Feb 2021 16:36:01 -0500
X-MC-Unique: EvRdR_JnOxK_TjJNEbmkvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24AF385EE60;
 Tue, 16 Feb 2021 21:35:59 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE8785D9C0;
 Tue, 16 Feb 2021 21:35:56 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: Intel: bytcr_rt5640: Add quirks for 4 more tablet /
 2-in-1 models
Date: Tue, 16 Feb 2021 22:35:51 +0100
Message-Id: <20210216213555.36555-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, Bard Liao <bard.liao@intel.com>
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

Hi All,

Here is a patch series adding quirks with device-specific settings for
4 more tablet / 2-in-1 models.

Regards,

Hans


Hans de Goede (4):
  ASoC: Intel: bytcr_rt5640: Add quirk for the Estar Beauty HD MID 7316R tablet
  ASoC: Intel: bytcr_rt5640: Add quirk for the Voyo Winpad A15 tablet
  ASoC: Intel: bytcr_rt5651: Add quirk for the Jumper EZpad 7 tablet
  ASoC: Intel: bytcr_rt5640: Add quirk for the Acer One S1002 tablet

 sound/soc/intel/boards/bytcr_rt5640.c | 37 +++++++++++++++++++++++++++
 sound/soc/intel/boards/bytcr_rt5651.c | 13 ++++++++++
 2 files changed, 50 insertions(+)

-- 
2.30.1

