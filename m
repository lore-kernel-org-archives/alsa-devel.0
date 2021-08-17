Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF08C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 12:52:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64AB60BD3
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D64AB60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87DF71675;
	Tue, 17 Aug 2021 14:51:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87DF71675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629204761;
	bh=78nWWnDgAqcSfFQJhIfNk1zk/lLzYiBi4k088imddSw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HZy9RDXDkp60ycERFmFkHoxY8ZGfdaAoV+ZB0us7dr2vgbExckDcnyErf2fHHhtpp
	 fQR/I6mfqWofechD1eab5Fvl0mIhw1cmafnVGvsQDfmVhWaWCjE8/zzTPwmGPkjSAc
	 7jdm3Z/jEVWp3AV0awDWuIAhZzuXAL/rsV5a13/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04B7DF80134;
	Tue, 17 Aug 2021 14:51:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B398F80272; Tue, 17 Aug 2021 14:51:49 +0200 (CEST)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 344F2F80163
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 14:51:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 344F2F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="hGV5yMd6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j+1kC4HHAD2lR906YjFY/es+SLKcT+7W9dJWw8F3nUM=; b=h
 GV5yMd6UdnjUbpXPe4VhXZRZ7O+Of7NL7Ee4WJEUBjIRBEaEAzlQ4uOtPj5vGVl3aLS34ZdIRP/yM
 LWuBwPzOPPRPkhNHWhk6uxPPYcXTKA8ng4hUauZ86Xp8qfT19qe56lk5EGBXf6PeDQyUL5qGA2i0w
 w4S/j3QTUByurzs7FOFl91SwePsF1nIppoDXNmq+tW1O1LFWQViCK3xTn+9JOGxcklCezM8NGZ+Sh
 fApyPK5LAsBBvkQ+fyoMZWHwRUsCRP9vJjvS8CtCJhyLfkn9Uo3UxtYqYkcgvzAkVKtsKkkOZbFxB
 bLj91CiApPGL7BU6vOdg1hYD2Vmjt3lEA==;
Received: from c83-254-143-147.bredband.tele2.se ([83.254.143.147]
 helo=localhost.localdomain)
 by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <coding@diwic.se>)
 id 1mFyZD-00DMgr-0a; Tue, 17 Aug 2021 14:51:43 +0200
From: David Henningsson <coding@diwic.se>
To: tiwai@suse.de,
	alsa-devel@alsa-project.org,
	perex@perex.cz
Subject: [PATCH v2 0/2] alsa-lib patches for rawmidi tstamp framing
Date: Tue, 17 Aug 2021 14:51:30 +0200
Message-Id: <20210817125132.5737-1-coding@diwic.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: coding@diwic.se
Cc: David Henningsson <coding@diwic.se>
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

v2: Improved commit messages

David Henningsson (2):
  Add rawmidi framing API
  Add test for rawmidi framing API

 include/rawmidi.h           | 26 ++++++++++++
 include/sound/uapi/asound.h | 30 +++++++++++++-
 src/rawmidi/rawmidi.c       | 83 +++++++++++++++++++++++++++++++++++++
 src/rawmidi/rawmidi_hw.c    |  2 +
 src/rawmidi/rawmidi_local.h |  2 +
 test/rawmidi.c              | 65 ++++++++++++++++++++++++++---
 6 files changed, 200 insertions(+), 8 deletions(-)

-- 
2.25.1

