Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EDC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 14:39:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29C464EF3
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 14:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29C464EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88FDB852;
	Fri, 26 Feb 2021 15:38:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88FDB852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614350365;
	bh=+OMBuTSFR8v56qq9lr6zFBdNvMf+P9SFTnJJta5Hlqc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c+8g+58G7KhoJdVroooEQ4kQdh3T9rE2mlQ5vYZcVf4THkCdtQAHX4OlnwRAk56sK
	 5kVj1/9WlaA/8h1BMeZyMSHI5vk853+zdy8KnbmZ+d+Np+vV7wP3o2Ab+Utrs7DGrt
	 8bNCXmQkMl4IRFwQmxMTXMNFRR2ilRbMk7aamQQ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 045DEF80161;
	Fri, 26 Feb 2021 15:38:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94E3FF8022D; Fri, 26 Feb 2021 15:38:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6E6DF80159
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 15:38:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6E6DF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="PrLF1mXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614350304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ir4n9pV/80/UIAqwqudM2knF96w/6jxh9cw4RfmpH+Q=;
 b=PrLF1mXRyCcvbo/0fl4vCYLDwDTvDgxkvkh+tX7xLJoTp4yiG34Hkr+AWhd4oLJ0rMgmxu
 R0g4p7jDOjfTBY1wOpUjgNXSDDd/57joUT/BSzVFOd2I/E08eCsUgxHRCjLCFK1cck5F5V
 0b1YZ2BLYNWsUMiFS7FkQHXncGpueMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-B1JVukKVMEOZEl3CjKZ22A-1; Fri, 26 Feb 2021 09:38:22 -0500
X-MC-Unique: B1JVukKVMEOZEl3CjKZ22A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A7B801979;
 Fri, 26 Feb 2021 14:38:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52C675D9D2;
 Fri, 26 Feb 2021 14:38:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] AsoC: rt5640/rt5651: Volume control fixes
Date: Fri, 26 Feb 2021 15:38:12 +0100
Message-Id: <20210226143817.84287-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org
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

Here is a series of rt5640/rt5651 volume-control fixes which I wrote
while working on a bytcr-rt5640 UCM profile patch-series adding
hardware-volume control to devices using this UCM profile.

The UCM series will also work on older kernels, but it works best on
kernels with this series applied, giving e.g. finer grained volume
control and support for hardware muting the outputs.

Regards,

Hans


Hans de Goede (5):
  ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor
    of 10
  ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor
    of 10
  ASoC: rt5640: Add emulated 'DAC1 Playback Switch' control
  ASoC: rt5640: Rename 'Mono DAC Playback Volume' to 'DAC2 Playback
    Volume'
  ASoC: Intel: bytcr_rt5640: Add used AIF to the components string

 sound/soc/codecs/rt5640.c             | 106 +++++++++++++++++++++++---
 sound/soc/codecs/rt5640.h             |   4 +
 sound/soc/codecs/rt5651.c             |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c |  11 ++-
 4 files changed, 111 insertions(+), 14 deletions(-)

-- 
2.30.1

