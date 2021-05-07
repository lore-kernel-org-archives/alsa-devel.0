Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA9C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 13:12:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A4061468
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 13:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A4061468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1450A847;
	Fri,  7 May 2021 15:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1450A847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620393137;
	bh=65F8puvwFX8D9ztG8a5TNnRq/ofEbfF6w5kZNfGyUTA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kbsfOjDGA8Az0Chijj56p3LoyVc/3hIMyn77bCsC94xhrzi/SyogJptZgKVfeYYZJ
	 7Ppbr36IiTDP9qjUWL7rk1mQ9VrXk5W/l1AoydWbRF22Xgltc3EUQImzEQxdoDqLW5
	 u+54AoipzqCIgBQehDbTCovFQA134MVrqHo69uME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F38F80257;
	Fri,  7 May 2021 15:11:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA888F8025F; Fri,  7 May 2021 15:11:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ACFAF80108
 for <alsa-devel@alsa-project.org>; Fri,  7 May 2021 15:11:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ACFAF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="QwiSt3ny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620393076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C03uMC8a/jUKZ6fldT3S86p12e1l3qpY6Lq27009iYo=;
 b=QwiSt3nyMg6pUsOZ2pzj3lld06JwxQow0ksOTLfWBssdW0Q8YpD6rChL9WuyZfMw0i5X1F
 dMiMY5qyH67s6jtgjcXDrX4WY+du+9qVuyTpKs8Rld96+R5+dl/9ETVRRz8SD+viooys1q
 dQPqNKAQT2K3gM9bYn4e7uQjrgnKj8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-4x6z8DkCM864K9nX0momqg-1; Fri, 07 May 2021 09:11:14 -0400
X-MC-Unique: 4x6z8DkCM864K9nX0momqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C747A801AE6;
 Fri,  7 May 2021 13:11:12 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE2F5D9CC;
 Fri,  7 May 2021 13:11:10 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 0/3] byt/cht: Add support for controlling mute
 LEDs using the new snd_ctl_led kmod
Date: Fri,  7 May 2021 15:11:04 +0200
Message-Id: <20210507131109.10146-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

This series adds support for controlling spk/mic mute LEDs one some Bay-
and Cherry-Trail devices using the new snd_ctl_led kmod functionality.

This requires the latest alsa-lib and alsa-utils git code and when
running on Fedora it also requires putting selinux in permissive mode
for now. I've filed a bug against the selinux-policy to get this fixed:
https://bugzilla.redhat.com/show_bug.cgi?id=1958210

Note the first patch is mostly unrelated, it is a resend of an earlier
patch which seems to have fallen through the cracks.

Regards,

Hans



Hans de Goede (3):
  cht-bsw-rt5672: Add support for the components string
  cht-bsw-rt5672: Add support for controlling speaker- and mic-mute LEDs
  bytcr-rt5640: Add support for controlling a speaker-mute LED

 ucm2/bytcr-rt5640/bytcr-rt5640.conf     |  6 ++++
 ucm2/cht-bsw-rt5672/HiFi.conf           | 37 +++++++++++++++++++++++--
 ucm2/cht-bsw-rt5672/cht-bsw-rt5672.conf |  6 ++++
 3 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.31.1

