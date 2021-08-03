Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEF3C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 07:53:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E9060EC0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 07:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3E9060EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanheusden.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 834821706;
	Tue,  3 Aug 2021 09:53:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 834821706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627977232;
	bh=Dms3MSQeavPrWK3Nre/eetyLttQ+isBIdqFB0n7N8wk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2qBcKU25EPmJdHLHB+2BIbJ4H53mkLzT0MUvRX3UtPpumJFPNPgL3l0gdYa9H2H1
	 kBaYT/H3KENqu5iPbP9HaAeLXg3brzUOKNMJ7RaNSg5MyPr2V4Tg4dv9G1/+SGC9ie
	 SITeR6neI6eEkoTfty6byDybA7Qzyft1EpwxE/NI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2357EF8016D;
	Tue,  3 Aug 2021 09:53:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B9C9F802E8; Tue,  3 Aug 2021 09:53:00 +0200 (CEST)
Received: from lb1-smtp-cloud8.xs4all.net (lb1-smtp-cloud8.xs4all.net
 [194.109.24.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 178DCF80082
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 09:52:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 178DCF80082
Received: from cust-b66e5d83 ([IPv6:fc0c:c157:b88d:62c6:5e3c:5f07:82d0:1b4])
 by smtp-cloud8.xs4all.net with ESMTPA
 id ApEOmStFrXTlcApEPmkI8G; Tue, 03 Aug 2021 09:52:57 +0200
Received: from localhost (localhost [127.0.0.1])
 by keetweej.vanheusden.com (Postfix) with ESMTP id 6DB8A1626C3;
 Tue,  3 Aug 2021 09:52:56 +0200 (CEST)
Received: from keetweej.vanheusden.com ([127.0.0.1])
 by localhost (mauer.intranet.vanheusden.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id IqUjvcgxgJ8e; Tue,  3 Aug 2021 09:52:55 +0200 (CEST)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com
 [192.168.64.100])
 by keetweej.vanheusden.com (Postfix) with ESMTP id BEB0E162670;
 Tue,  3 Aug 2021 09:52:55 +0200 (CEST)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
 id B127D16097B; Tue,  3 Aug 2021 09:52:55 +0200 (CEST)
Date: Tue, 3 Aug 2021 09:52:55 +0200
From: folkert <folkert@vanheusden.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: aconnect occasionally causes kernel oopses
Message-ID: <20210803075255.GZ890690@belle.intranet.vanheusden.com>
References: <20210802091012.GR890690@belle.intranet.vanheusden.com>
 <s5hczqvyj8m.wl-tiwai@suse.de>
 <20210802152117.GT890690@belle.intranet.vanheusden.com>
 <s5h5ywnydlz.wl-tiwai@suse.de>
 <20210802195349.GV890690@belle.intranet.vanheusden.com>
 <s5h1r7bxbiv.wl-tiwai@suse.de>
 <20210803074050.GX890690@belle.intranet.vanheusden.com>
 <s5ho8afvuqg.wl-tiwai@suse.de>
 <20210803074451.GY890690@belle.intranet.vanheusden.com>
 <s5hlf5jvuhf.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlf5jvuhf.wl-tiwai@suse.de>
Reply-By: Fri 16 Jul 2021 08:34:34 AM CEST
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4xfPLxQ4pjFfc7Qs7F0+IcRqlchgJk/Y7FW+YTOxNVJMFfLNaHmrdEJrMpcx7vUtdmUkItTZJdm/OsadAqMpy+4e0QSEaJ1+YNp/VqhY/bkv5rSdRc+eYz
 k0khZuP5bvBKmivV8L+LkTcyWopYNfHyNxPAPZfKA4kVo49KLMQ4xUBn1JRg3DyTa562GKOfJFm4n9X8HCTYKB1d2SIzc5OgFGrLzf/qi4jcVhC3spk7ANBx
 Q8nXjA1TvcKsad4fPEQ20A==
Cc: alsa-devel@alsa-project.org
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

> > I did.
> > It also fails on 5.13.7.
> 
> Weird, here it's applied cleanly on my machine with every kernel
> version.  Double-check whether you really have any other changes.
> I attach the patch again but with an attachment just to be sure.

It now applies fine!
Strange. Most likely I made a mistake before. Anyway, it is now
compiling.
