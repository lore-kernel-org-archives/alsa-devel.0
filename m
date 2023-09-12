Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7D8CA0EC3
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 11:34:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F53CE9A;
	Tue, 12 Sep 2023 13:33:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F53CE9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694518480;
	bh=SzYup70r8jJshXo3DYNG/cwQspmuxL87Ll8OqIF4be8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GJz0A3/eOQjXxoL/AFLhQ37kDsPmm0zWhhHCtPaWGmlPOzeTxGGFvsqW5oIu32VSk
	 bUsDc8OTI8GR4iH3a3acool+a2x0pmjPy3nsF9Luz9uLZjRHXjCRvmPMAvfAcLDqAM
	 79lDDbDpW4fHcvAU58SUOjkrhWmHJBkbIpo0Z4sM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2F6DF80568; Tue, 12 Sep 2023 13:33:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF278F80425;
	Tue, 12 Sep 2023 13:33:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BD4DF80551; Tue, 12 Sep 2023 13:33:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 599A4F80212
	for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2023 13:33:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 599A4F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=W4M8rVCH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694518380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mLFV6FV8nI8VSSp64ujwn+RCa9pJ6zIGDU83IUIBeZc=;
	b=W4M8rVCH+7JhAk5gvvqbq/0VPnQPYSfmh9BY6mx8MFVt9qAv9S9Ku0V6JqcmZMXcHPESCL
	uNOsDeBKCbq48gK9qH05z0LaSWoQALZo10qCgtlCDzmM06GNfAC3mT3qE/GUyFDjowAEo2
	EEDCgnpQIsrXdFXPxiw+f7vBdhTtbD0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-n6b85sBUOzq7IGiotosAQg-1; Tue, 12 Sep 2023 07:32:56 -0400
X-MC-Unique: n6b85sBUOzq7IGiotosAQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A0AA2932482;
	Tue, 12 Sep 2023 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5AED2026D4B;
	Tue, 12 Sep 2023 11:32:54 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ASoC: rt5640: Fix various IRQ handling issues
Date: Tue, 12 Sep 2023 13:32:39 +0200
Message-ID: <20230912113245.320159-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Message-ID-Hash: K2HXW3STFSRKOL7MPRNCWF75GMUF4A57
X-Message-ID-Hash: K2HXW3STFSRKOL7MPRNCWF75GMUF4A57
X-MailFrom: hdegoede@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K2HXW3STFSRKOL7MPRNCWF75GMUF4A57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi All,

The recent(ish) rt5640 changes to add HDA header jack-detect support
and the related suspend/resume handling fixes have introduced several
issues with IRQ handling on boards not using the HDA header jack-detect
support.

This series fixes these issues, see the individual commit messages
for details.

Regards,

Hans


Hans de Goede (6):
  ASoC: rt5640: Revert "Fix sleep in atomic context"
  ASoC: rt5640: Fix sleep in atomic context
  ASoC: rt5640: Do not disable/enable IRQ twice on suspend/resume
  ASoC: rt5640: Enable the IRQ on resume after configuring jack-detect
  ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode
  ASoC: rt5640: Only cancel jack-detect work on suspend if active

 sound/soc/codecs/rt5640.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

-- 
2.41.0

