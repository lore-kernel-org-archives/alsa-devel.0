Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE2C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 11:48:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309D26323D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 11:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 309D26323D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D1FD16AD;
	Mon, 16 Aug 2021 13:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D1FD16AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629114504;
	bh=sCEcblbWFhKWvxfRnPOhNp3DCUD/10tvJeHSG6qChNc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k8MiEY4W/KahN+sYvEOgGMA+pO9FVOEyv13obdWCzKqeAMXFOhIFTTH5Sk6C+qTZe
	 S9YpVlYbiCNzYWeR07tcF9nCRr0Nz4gm51KIcUR4Phh9BEfT9H00j/tc2FBsrRjlXm
	 RPldvJ4wL8QD+RikkrBZsENlaUrw43esak3++HZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F61CF80246;
	Mon, 16 Aug 2021 13:47:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21FFAF80249; Mon, 16 Aug 2021 13:47:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD03EF80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 13:47:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD03EF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="CyRpyUSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629114448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Aa3auxTjHuy6k6ERuDqF2F4rnTXTnBlYtUI/OgMnAGE=;
 b=CyRpyUSb9IVQaq8CPzBikUG4gPIO0qCMiOjuTDm/yrVGeka74hXgf54NTiXWqxuFVcCYQa
 +mN3i3I3xPAApQiFdsp3Hea2LXknEFTPoZE3EWGN5bD+9vkVipbVDAipsDBJQvNeylvvwa
 77tnM9atswQe5j3UnNHhosrZcOWXzN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-i7Y3KhKFOxqN9EpjXTm0qQ-1; Mon, 16 Aug 2021 07:47:26 -0400
X-MC-Unique: i7Y3KhKFOxqN9EpjXTm0qQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F274E1853026;
 Mon, 16 Aug 2021 11:47:24 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E4695D6A1;
 Mon, 16 Aug 2021 11:47:22 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Use cfg-lineout:2 in the
 components string
Date: Mon, 16 Aug 2021 13:47:22 +0200
Message-Id: <20210816114722.107363-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

Use "cfg-lineout:2" in the components string on boards with a lineout
instead of "cfg-lineout:1", this better mirrors the speaker part of
the components string where we use "cfg-spk:1" for devices with a single
speaker and "cfg-spk:2" for stereo speakers.

The lineout is stereo by default, so using ":2" makes more sense, this
way we keep ":1" reserved in case we ever encounter a device with
a mono lineout.

We can make this change without breaking userspace because no kernel
has shipped with "cfg-lineout:1" in the component-string yet; and there
also are no userspace bits (UCM profiles) checking for this yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 369642c07a5d..f79234f49c7c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1688,7 +1688,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
 			lineout_string = " cfg-hp2:lineout";
 		else
-			lineout_string = " cfg-lineout:1";
+			lineout_string = " cfg-lineout:2";
 	}
 
 	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1)
-- 
2.31.1

