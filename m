Return-Path: <SRS0=92Yh=F6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9894C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 07:49:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDBF221EA
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 07:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDBF221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 021301857;
	Sat, 26 Dec 2020 08:48:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 021301857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608968943;
	bh=7d8I5hwCZQrMXuSGnzKhBKWfYf74HXgNhPCzh78Ubvw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hvJuV9j8qBZHkZKB2iOJrdIXj4SBFqupaS0cH/Ajyn8iVk6S1D/IYg6cQOSgkPDJ8
	 sfsuYzQ+00mx23VUjQ6fKbQyhFx0KiNyoOVXuc+gaCda714tUznKPcAPqOdb67uz4L
	 2CBdC3hm5rop9fMHno0i7wU7YDxM0t3N/I3tynU0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 942A2F80224;
	Sat, 26 Dec 2020 08:48:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED274F801D5; Fri, 25 Dec 2020 10:13:33 +0100 (CET)
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net
 [IPv6:2a02:6b8:0:801:2::107])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E93BF80128
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 10:13:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E93BF80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru
 header.b="uC1YNTCT"
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
 by forward104j.mail.yandex.net (Yandex) with ESMTP id 352844A2A07
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 12:13:26 +0300 (MSK)
Received: from vla1-0a21544ac5fe.qloud-c.yandex.net
 (vla1-0a21544ac5fe.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:1686:0:640:a21:544a])
 by forward103q.mail.yandex.net (Yandex) with ESMTP id 2E12661E0011
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 12:13:26 +0300 (MSK)
Received: from localhost (localhost [::1])
 by vla1-0a21544ac5fe.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 c1pv0ANLIJ-DPDiIW0A; Fri, 25 Dec 2020 12:13:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1608887605; bh=PZHN7xCECDQlt2YM3FjPxbqyTRVDBp8ahg6QpwQaDo0=;
 h=Message-Id:Date:Subject:To:From;
 b=uC1YNTCTfYjuicBeUgknWZ0YSPHEkAcSCUZVnWBza/kH847esNr1QH8ppwGqSX9W8
 oyoeTWs2kuCH1ciy6mO1OllmFA0vaTP5vqvHnDi76Lo2T4vZucp+5CjzJI8rgubvkh
 juqt1SBBS8kl80zpoAAEknqaFGjXF28obJhxFlNw=
Authentication-Results: vla1-0a21544ac5fe.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by vla1-c7cd0219e008.qloud-c.yandex.net with HTTP;
 Fri, 25 Dec 2020 12:13:25 +0300
From: =?utf-8?B?0KHQu9Cw0LLQsCDQkdCw0L3RidC40LrQvtCy?= <solongoiv@yandex.ru>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: No sound from speakers, only headphones working
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 25 Dec 2020 16:13:25 +0700
Message-Id: <455941608887457@mail.yandex.ru>
X-Mailman-Approved-At: Sat, 26 Dec 2020 08:48:10 +0100
MIME-Version: 1.0
Content-Type: text/plain
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

   Here is the output from alsa-info.sh

   http://alsa-project.org/db/?f=ba0e450b747066e59c76642aa3c9f15a9a9f8a0b
