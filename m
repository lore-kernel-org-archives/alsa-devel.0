Return-Path: <SRS0=kQrV=I7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC15C433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 14:08:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFC3610E7
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFC3610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34DDD16AF;
	Fri,  2 Apr 2021 16:08:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34DDD16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617372535;
	bh=luB7V6ROXLNKZE9rqxooUQbSbmi/OrbsGpJiuY4/CLU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dDzEt4YmiIO18frOMIYjNOjgKWIszuvGnHxBGmj+K/2VoK6hZpNJ/C1Yc/SqbC40G
	 WjtsPECqQ8iP/MOU517lT5gUgdn2LcYFHSvJEC6CaDx2nrTrW46TXG6HnyoI8CmCHG
	 AddyFwwwfk3m8cfJfkzPMp+lv4TpSVfByi4ZHQBY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99C1DF80229;
	Fri,  2 Apr 2021 16:08:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C36E4F80259; Fri,  2 Apr 2021 16:08:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C275F800F5
 for <alsa-devel@alsa-project.org>; Fri,  2 Apr 2021 16:07:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C275F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="MsjCKacT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617372476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9V2Vi+f0cJik/wESpPmI01nP5gtpJOTKqbLxm5GoAy0=;
 b=MsjCKacT6dwaaIGBS7fdYa8WPIZgeD9ljpc5xFqE2+knma09HlUuquA2t0ZOEYJnNp0FBf
 MMJD7ei6rZvOBDbj2JEF+HqDSPnMUWhJYH0HHNsmmkPZrUNdFUPeNe9uuYJi7Bh0i+kpmE
 SYeKo4U/AKgm0Otl6IEqafTYyvGKPr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-XqCPB6oiPKiZd7XnNIIJZQ-1; Fri, 02 Apr 2021 10:07:52 -0400
X-MC-Unique: XqCPB6oiPKiZd7XnNIIJZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B71F107ACCA;
 Fri,  2 Apr 2021 14:07:50 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED14D10023AC;
 Fri,  2 Apr 2021 14:07:47 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] ASoC: rt5670/Intel: Add support for Bay Trail CR / Dell
 Venue 10 Pro 5055 tablet
Date: Fri,  2 Apr 2021 16:07:41 +0200
Message-Id: <20210402140747.174716-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Here is a patch series to enable sound on the Dell Venue 10 Pro 5055 tablet
this series also includes 2 generic improvements to rt5672 support:

1. Add support for boards using Bay Trail CR (SSP0) in combination with a rt5672 codec
2. Set the card's components string based on the DMI info, so that we don't need to
duplicate the DMI quirks in userspace (in the UCM profile)

I've a patch to add support for the components string to the UCM profile for
these boards available here:
https://github.com/jwrdegoede/alsa-ucm-conf/commit/fedacc2bdc530b6febac665db27aab60e03ec840

I will submit this upstream once the kernel side has landed.

Regards,

Hans


Hans de Goede (6):
  ASoC: Intel: Unify the thinkpad10 and aegex10 byt-match quirks
  ASoC: Intel: Baytrail: Add quirk for the Dell Venue 10 Pro 5055 tablet
  ASoC: Intel: cht_bsw_rt5672: Add support for Bay Trail CR / SSP0
  ASoC: rt5670: Add a quirk for the Dell Venue 10 Pro 5055
  ASoC: rt5670: Add a rt5670_components() helper
  ASoC: Intel: cht_bsw_rt5672: Set card.components string

 sound/soc/codecs/rt5670.c                     | 51 ++++++++++++
 sound/soc/codecs/rt5670.h                     |  2 +
 sound/soc/intel/boards/cht_bsw_rt5672.c       | 77 +++++++++++++++----
 .../intel/common/soc-acpi-intel-byt-match.c   | 40 +++++-----
 4 files changed, 136 insertions(+), 34 deletions(-)

-- 
2.30.2

