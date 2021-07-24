Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D489CC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 08:30:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E8B611AD
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 08:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64E8B611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=onet.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5A0E1AFA;
	Tue, 27 Jul 2021 10:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5A0E1AFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627374610;
	bh=90u+wCNqC94Dqs72LcJ8Tsq4P2Ys2+bmuuVBACSJmuM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Dfz0ALDpvF2n5XfC8lyGeZBw1MvkHehjqhWq99u/zErB3RYy1byzwNPMqvdiIHOob
	 j8ORn/9mw/7yrGkdQy+vRE9oR5SxOJnNGVltFpFH/QKrqprzoFrZEiv/K681HFPKLy
	 m3eawDiQ1f2NwNs9mLpZIK5hAZZ0CVupZKlBvn0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5374CF80258;
	Tue, 27 Jul 2021 10:29:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D7E7F80227; Sat, 24 Jul 2021 12:07:24 +0200 (CEST)
Received: from smtpo86.poczta.onet.pl (smtpo86.poczta.onet.pl
 [213.180.149.139])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9A23F800DA
 for <alsa-devel@alsa-project.org>; Sat, 24 Jul 2021 12:07:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9A23F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=onet.eu header.i=@onet.eu
 header.b="iMbiHHx3"
Received: from pmq1v.m5r2.onet (pmq1v.m5r2.onet [10.174.32.67])
 by smtp.poczta.onet.pl (Onet) with ESMTP id 4GX20z0VyVzlj8f1
 for <alsa-devel@alsa-project.org>; Sat, 24 Jul 2021 12:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onet.eu; s=2011;
 t=1627121235; bh=90u+wCNqC94Dqs72LcJ8Tsq4P2Ys2+bmuuVBACSJmuM=;
 h=From:To:Date:Subject:From;
 b=iMbiHHx3Ll1x1pdppSbNB2BWOYShXsBoXiLhWwuLbdae9KySGO8OguDy9xU00YOqC
 /E7Svr7NnJMryqrk9yYSONDWmgItETKOeBn3tubcM/4T56TprHD2JLwTg5vIJy54NM
 czXadO5OgUfXTvN2aYGVVEiXqOwdROA3FtE9LDQs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from [31.0.57.188] by pmq1v.m5r2.onet via HTTP id ;
 Sat, 24 Jul 2021 12:07:15 +0200
From: rv71@onet.eu
X-Priority: 3
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Date: Sat, 24 Jul 2021 12:07:14 +0200
Message-Id: <138065115-be2ec115b2a48297ebd271870a774ed7@pmq1v.m5r2.onet>
X-Mailer: onet.poczta
Subject: MIDI Through Port Number in ALSA Sequencer
X-Onet-PMQ: <rv71@onet.eu>;31.0.57.188;PL;1
X-Mailman-Approved-At: Tue, 27 Jul 2021 10:29:08 +0200
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

Hello,=C2=A0

ALSA Sequencer always creates MIDI Through Port with the id 14:0. However, =
I can't find where it is defined that this special port will have this part=
icular id/number. I also don't see any definition in seq.h regarding this (=
 unlike the timer and announce special port, for example). Can you explain? =


Thanks =


Robert
