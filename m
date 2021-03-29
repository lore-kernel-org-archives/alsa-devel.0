Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE6C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 14:39:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C222361924
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 14:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C222361924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nh6z.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EA811666;
	Mon, 29 Mar 2021 16:38:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EA811666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617028745;
	bh=c2Rv9YYXjZ3E3bJfe7H6ejnj6wFyuD4nNkzo4WBbOdk=;
	h=Subject:From:To:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=YgoKfUeZvmJ05nS0kSqzI+rsQaVWa/RHOgIDhkoDMQFBlln1UskaW6bOcKhii7gEH
	 eLwTaKgUpJ1zeBGcyHUOXRUBYlWo3TP8lvqvOXkEdfnbwmQMOQTxxQS13uheCt5enD
	 k5d7xUD/WMOrudKe0kfI63hIfl8Gi+kj3ntfQ8rw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B56C0F8015A;
	Mon, 29 Mar 2021 16:38:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41FF5F8016E; Mon, 29 Mar 2021 16:38:12 +0200 (CEST)
Received: from a27-228.smtp-out.us-west-2.amazonses.com
 (a27-228.smtp-out.us-west-2.amazonses.com [54.240.27.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDD65F800DD
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 16:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDD65F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nh6z.net header.i=@nh6z.net
 header.b="RgYHc1QQ"; 
 dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com
 header.b="ComI9Gkh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zzmz6pik4loqlrvo6grmnyszsx3fszus; d=nh6z.net; t=1617028685;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
 bh=c2Rv9YYXjZ3E3bJfe7H6ejnj6wFyuD4nNkzo4WBbOdk=;
 b=RgYHc1QQZvuh0+RMT93v7IW+z2i4146JfjCzlNSArTxn1vpdN9FXZl2X51Z5urHg
 Ag1TpPUJdATWq7x8NIyyvTvRTPhDkXOgIAQ5h+4vwifdOlQDphNjjlZQEKckA3v5LpP
 0lrBNcE7uzl90mx0/gUm/lc380WLFXg2dtlCFHb4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1617028685;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
 bh=c2Rv9YYXjZ3E3bJfe7H6ejnj6wFyuD4nNkzo4WBbOdk=;
 b=ComI9Gkhl7LuG7uMMVl+6+P9RUDTcQ2gE1l5MOfUZzsOUWLli2s3CaCHWwQ7g42w
 k2+T5DSp9IHwNLSYeakRSm7UE/AocR17gfH+zS8iUUp8VejTUWCFFKvck/zHUx60gQ7
 CVqBVuXepGx9uSStX5sE62t4uGR8b61bWBb9iOBg=
Subject: [PATCH 0/2] ASoC: tlv320aic32x4: Bugfixes for tlv320aic32x4 driver
From: =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
To: =?UTF-8?Q?alsa-devel=40alsa-project=2Eorg?= <alsa-devel@alsa-project.org>
Date: Mon, 29 Mar 2021 14:38:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <20210329143756.408604-1-nh6z@nh6z.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXJKkg/ojtMl+8SNWm7v/u1huSVg==
Thread-Topic: [PATCH 0/2] ASoC: tlv320aic32x4: Bugfixes for tlv320aic32x4
 driver
X-Original-Mailer: git-send-email 2.27.0
X-Wm-Sent-Timestamp: 1617028684
Message-ID: <010101787e6b9dea-a1eb99e5-069f-4935-82b4-2edc5f07a5c5-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2021.03.29-54.240.27.228
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Cc: =?UTF-8?Q?team=40nwdigitalradio=2Ecom?= <team@nwdigitalradio.com>,
 =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
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

These are a couple of bugfixes for the tlv320aic32x4 driver
that we discovered after the Raspberry Pi Foundation's move to
the 5.10 kernel.

The first increases the maximum value in the regmap configuration
so that the powerup command actually works.

The second changes the ordering of the clock registration in the
module probe function so that the clocks are properly registered
before the component probe function runs.

Annaliese McDermond (2):
  ASoC: tlv320aic32x4: Increase maximum register in regmap
  ASoC: tlv320aic32x4: Register clocks before registering component

 sound/soc/codecs/tlv320aic32x4.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.27.0

