Return-Path: <SRS0=nH8J=HR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB32C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 14:25:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9AC64DE0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 14:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9AC64DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 434191695;
	Mon, 15 Feb 2021 15:24:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 434191695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613399123;
	bh=zES7JVFI55A43I6bjbUYUfdiy8HvbFj32DH9YQpAwOE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=maGnEqn25nARC5urMBepHjQpffCfTft0omWwKXoOOkeL334si8qWooqt1YI9VQys+
	 WnTrJnPvb1Pxvy62PBOzahWMp41b6XaPvyy3k/0W2JogKCzveSlrgGcBN7Ks863sU/
	 fCzRzuVmQaEPcukhJq3NZK4Cwd2h/T+Osc7QFiJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7020FF80268;
	Mon, 15 Feb 2021 15:24:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21830F8025B; Mon, 15 Feb 2021 15:24:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABCC1F80089
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2021 15:24:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABCC1F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="IAmPWkkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613399064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uSRutKAX0LVpk5x4JBxPT+okz1ZiEiZRDIswNu92C7A=;
 b=IAmPWkkgmxF68aQ+oNGy/UCVAyWCt+eK9lmX3i7iIZ7ZSimVlptbfr1PUmeBVGhziE7TO1
 sL19f2N1JUqGBXBPTf5VZamXL2+O7I/nd0IchFBm+qbzGPwqAsp61OCCGC3DwRcmdBqRzT
 esHZrTleZRL4rUTTTwTz3wWR3f3Yzdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Q1-yNy8DPfiYBNHxR0aDmQ-1; Mon, 15 Feb 2021 09:24:23 -0500
X-MC-Unique: Q1-yNy8DPfiYBNHxR0aDmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C47A1966320;
 Mon, 15 Feb 2021 14:24:21 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-74.ams2.redhat.com [10.36.115.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4F8517A9E;
 Mon, 15 Feb 2021 14:24:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Oder Chiou <oder_chiou@realtek.com>
Subject: [RFC 0/2] ASoC: rt5670: Add LED trigger support
Date: Mon, 15 Feb 2021 15:24:17 +0100
Message-Id: <20210215142419.308651-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>
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

This series applies on top of the:
"[PATCH 0/4] ASoC: rt5670: Various kcontrol fixes"
series which I just send out;

And it also requires the:
"[PATCH 0/5] ALSA: control - add generic LED trigger code"
from Jaroslav. This second requirement is still being discussed /
reviewed, which is why I split out these 2 patches into a separate
RFC patch series.

Regards,

Hans


Hans de Goede (2):
  ASoC: Add new SOC_DOUBLE*_ACCESS() macros
  ASoC: rt5670: Add LED trigger support

 include/sound/soc.h       | 20 ++++++++++++++++----
 sound/soc/codecs/rt5670.c | 10 +++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.30.1

