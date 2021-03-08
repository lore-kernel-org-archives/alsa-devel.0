Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:07:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5491565253
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 22:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5491565253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E246E189B;
	Mon,  8 Mar 2021 23:06:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E246E189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615241219;
	bh=sMIciBgRzjdS7rs8cnjRL65CXZoNBO8Kh1XflS5IRXQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H8v3J4qesoq8G2Z1MV4BbK/y6OkvhppYhTB+pjTrHNvK5DdfsvbF5UywxbYv30D3z
	 8PzPp6NKXixYPdFyyphpv64CBzngE9kxXITR0RNuUf5bNyof8mtGoE1fYCMar+yCcv
	 QQ1eA0RkwtqqCWZBfe7X2qDlQvxanotHpUKhFWX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33E9EF800D0;
	Mon,  8 Mar 2021 23:06:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ED25F80139; Mon,  8 Mar 2021 23:06:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13305F80139
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 23:06:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13305F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="NPsy9Ds9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615241161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nxtKAHth2tRAjkgks+km6Isr7Brryt3OVz1rx4WxPhc=;
 b=NPsy9Ds9hUrCHbIMsO1y1iCkHNDWC0ZNeX1foNRdTZgtT+H53sygbDesztniGwMlW8Fob9
 DhvmZAQOsPYBewo9fV4sw/oNv0R9SzyVrdIQ6ZbRRRupY04dCKNBRE1zYwLsMG06kjbOFu
 MM3nhXkbvpqxJhWvt7UvwAOQlsj5fYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-11cWtcQyPlOp3lSKCjh-lQ-1; Mon, 08 Mar 2021 17:05:58 -0500
X-MC-Unique: 11cWtcQyPlOp3lSKCjh-lQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35D7F107B017;
 Mon,  8 Mar 2021 22:05:57 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-220.ams2.redhat.com
 [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6B315D6D7;
 Mon,  8 Mar 2021 22:05:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf v2 0/7] codecs/rt5640: Cleanup + HW volume
 control support
Date: Mon,  8 Mar 2021 23:05:47 +0100
Message-Id: <20210308220554.76111-1-hdegoede@redhat.com>
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

Hi All,

Here is v2 of my patch series consisting of some codecs/rt5640 cleanups
and addition of HW volume control support to the rt5640 .conf snippets.

This new version has been updated to deal with the
"[PATCH 3/5] ASoC: rt5640: Add emulated 'DAC1 Playback Switch' control"
kernel-patch being dropped.

Note patch 7 depends on a new "aif:%d" part being added to the
components string, the kernel patches for this are pending upstream
in the "[PATCH resend 0/2] AsoC: rt5640/rt5651: Volume control fixes"
patch-series.

As such patch 7 should probably not be merged until the kernel patches
have landed, because theoretically the new component string part could
change as part of the review of the kernel patches.

Patches 1-6 are ready to be merged now.

Regards,

Hans



Hans de Goede (7):
  codecs/rt5640: Cleanup: unify Stereo / Mono ADC handling
  codecs/rt5640: Cleanup: Initially disable all inputs and outputs
  codecs/rt5640: Cleanup: Move 'SPK MIX' setup to main EnableSequene
  codecs/rt5640: Drop bogus 'DIG MIXL DAC L2 Switch' setting
  codecs/rt5640: Unify capture volume for AIF1 and AIF2 recording paths
  codecs/rt5640: Add hardware volume-control support
  codecs/rt5640: Specify Playback/CaptureMasterElem for HW
    volume-control

 ucm2/bytcr-rt5640/HiFi.conf             | 21 +++++++++++
 ucm2/codecs/rt5640/DigitalMics.conf     | 18 ++++++++-
 ucm2/codecs/rt5640/EnableSeq.conf       | 50 ++++++++++++++++++++-----
 ucm2/codecs/rt5640/HeadPhones.conf      | 15 +++++++-
 ucm2/codecs/rt5640/HeadsetMic.conf      | 24 ++++++++----
 ucm2/codecs/rt5640/IN1-InternalMic.conf | 27 +++++++------
 ucm2/codecs/rt5640/IN3-InternalMic.conf | 27 +++++++------
 ucm2/codecs/rt5640/MonoSpeaker.conf     | 17 +++++++--
 ucm2/codecs/rt5640/Speaker.conf         | 17 +++++++--
 9 files changed, 167 insertions(+), 49 deletions(-)

-- 
2.30.1

