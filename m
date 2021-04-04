Return-Path: <SRS0=LXLF=JB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D59C433ED
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 07:46:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E589661359
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 07:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E589661359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9596E166F;
	Sun,  4 Apr 2021 09:45:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9596E166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617522387;
	bh=eNzFiI4m85rK/V4kmNDEsZHFGdVgXKsahOTM9jdF56U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MM7QaalXtVD0YHFI9DqEitW3B80B71fUpWnGHMDqi94GHPgu1THkNENdo4YRCVb+4
	 JFomKJ3l5B8Ro9EycfEpKw6ZUKmbOIxNblwK1IToganWs1Is2MB26xUcfmj6g/7Hn2
	 FX4ChWrQ2+XAk/f/ax5XVQeHjlrAC6EO8YA5LzKk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06825F80147;
	Sun,  4 Apr 2021 09:45:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1DC7F80249; Sun,  4 Apr 2021 09:45:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD26DF80147
 for <alsa-devel@alsa-project.org>; Sun,  4 Apr 2021 09:45:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD26DF80147
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="XAOfHAdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617522329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NykXD7KdPeEthmXhVY6NN8Uf8eI16iElMyYZMEmeiCk=;
 b=XAOfHAdFU27FxSS4XD3TWcs+x2VrbF6TYolYx1AvGzggwwJzqQDkj9K62JTCnlXmHj0QHx
 smx26uAGjk3ye1TD5oFoxy8lNKO2qGFrZfEygCIklMS6mczm2caPt8GlnKDB8rZkTRd5Y/
 5XiUH1v/T9Aw7r+VCfwfpctJQKor8TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-4S6RnT2vNpWOb05e4LVwDw-1; Sun, 04 Apr 2021 03:45:25 -0400
X-MC-Unique: 4S6RnT2vNpWOb05e4LVwDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC2C107ACCA;
 Sun,  4 Apr 2021 07:45:24 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0659059443;
 Sun,  4 Apr 2021 07:45:22 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 0/1] cht-bsw-rt5672: Add support for the
 components string
Date: Sun,  4 Apr 2021 09:45:20 +0200
Message-Id: <20210404074521.3709-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Add support for using the card's components string to figure out the
DMIC and speaker configuration so that we can stop duplicating the kernel's
DMI quirks inside the UCM profile.

The kernel side of this was just merged:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.13&id=e992a51b1d14317f414d4b9935966dca96ac0b36

Regards,

Hans


Hans de Goede (1):
  cht-bsw-rt5672: Add support for the components string

 ucm2/cht-bsw-rt5672/HiFi.conf | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

-- 
2.30.2

