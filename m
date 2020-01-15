Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10BEC32771
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA80214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lA7v9zO3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egBQn4xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA80214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86F0D17A0;
	Wed, 15 Jan 2020 17:46:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86F0D17A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579106843;
	bh=Ll1tJjublKz4AGbee3MYsgEam+nDNQANv/XRsStEQVw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lA7v9zO3ys/InOnQrpE/hH3XufwcyCUeE1lgtvSkCQozCMGKosEeZ19k4e3z1Ee2Y
	 wGdKfTYs1cbmvhBqbHTEYpa2GhEd8ngIPfYsmVQBj3uBcRWLqBR/leAJ0NEAQkIMF6
	 x8P4ZIla16/vc5JVLWUsefg5vzIjVeVnDJNtUdpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E49E8F8014B;
	Wed, 15 Jan 2020 17:46:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B42CDF801EB; Wed, 15 Jan 2020 17:46:31 +0100 (CET)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA88DF800B9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 17:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA88DF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="egBQn4xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579106786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PEG8CacqQVH9TiLszO0tdarMoHc+/+Yv1EQWn+Q2gb8=;
 b=egBQn4xdcBOdIbEkCiYOrFsgt/vFMLHMhHJVwe7qgpA/heiY1mB+TjQ23ydQXOCHU1dsAc
 awXxgKFjuy7bQQkZUahF6UonbNQQKyOoiqS6RoNWuR2ie7a0kC2tZwAxzXFIs8CQGkmmMo
 1/4dVeyKidCBmzaMDqCd/c8IJqeUjik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-klh7osqkPki3NLr-AbIUyQ-1; Wed, 15 Jan 2020 11:46:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F34263AD7;
 Wed, 15 Jan 2020 16:46:23 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com
 [10.36.116.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA9588890;
 Wed, 15 Jan 2020 16:46:20 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Date: Wed, 15 Jan 2020 17:46:15 +0100
Message-Id: <20200115164619.101705-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: klh7osqkPki3NLr-AbIUyQ-1
X-Mimecast-Spam-Score: 0
Cc: Nariman Etemadi <narimantos@gmail.com>, alsa-devel@alsa-project.org,
 Jordy Ubink <jordyubink@hotmail.nl>, Hans de Goede <hdegoede@redhat.com>,
 Damian van Soelen <dj.vsoelen@gmail.com>,
 Erik Bussing <eabbussing@outlook.com>
Subject: [alsa-devel] [PATCH 0/4] ASoC: Intel: 4 small cleanups
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi All,

Here are 4 ASoC/Intel cleanup patches, these were written to
get to know the kernel-devel process by a group of students
which I was coaching on a kernel project.

Their original submission needed some cleanup which they never
got around to. So I've done the cleanup now and I'm submitting
a cleaned-up version of the cleanup patches.

Regards,

Hans

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
