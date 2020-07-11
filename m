Return-Path: <SRS0=MUjV=AW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B854C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 03:35:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BF5206F0
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 03:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QZBj6OuX";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5K3F87j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BF5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 750DD15DC;
	Sat, 11 Jul 2020 05:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 750DD15DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594438506;
	bh=d5Ank3CEgpRGIco3O2jFrcl5+zEmO1liq7+RYmg3j74=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QZBj6OuXhzne6tz/RbWXFBJmnLa+/H9pol91jpAwzM+X/OhTlZz4S6Iqft8QOSUiL
	 oR/W9EJ3tEKLjhkO4HdjLJIb8IbqG3VI65VRE8ZVzIrjg1oZhY1jo+TLLFkp3bvJz4
	 SDthqQHmQHL6lF5EgTpo6hGwj2IHEueerFvSW0x0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF0ADF801F9;
	Sat, 11 Jul 2020 05:34:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75492F80216; Sat, 11 Jul 2020 05:34:13 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FB2CF80084
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2020 05:34:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FB2CF80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="f5K3F87j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594438447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=rkxV9wGrbaQjvlwNa9bpSRvCBx9BwmI9mcVo23t8Au0=;
 b=f5K3F87jVzfkbqieA50DNfqLjCBvyS8dPcu1dnBvTZoi/sqmEyEy0mCcnuvPz85NncFLMF
 ICdooGahlR9PspHA8CvbE7Rx2nVUsf5vswnLAeSQhZTvkcOPDA56+EJu2EHVIzv9Nv7etw
 rsoKQYPR0072kgFdlYtD37PI3Z91ol4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-keMQNT7LN7WgirSVBUnglg-1; Fri, 10 Jul 2020 23:34:05 -0400
X-MC-Unique: keMQNT7LN7WgirSVBUnglg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75AD28015F7;
 Sat, 11 Jul 2020 03:34:03 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-95.pek2.redhat.com
 [10.72.12.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6699D5C240;
 Sat, 11 Jul 2020 03:34:00 +0000 (UTC)
Date: Sat, 11 Jul 2020 11:33:56 +0800
From: Dave Young <dyoung@redhat.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Subject: omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!
Message-ID: <20200711033356.GA164619@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Hi,

I'm trying to use g_audio on my Nokia N900 with mainline kernel. Seems
it does not work.  No sound when I play from a laptop, and also see a
lot of error like below:
[ 4729.557647] omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!
...


Is this a know issue?

Thanks
Dave

