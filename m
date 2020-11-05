Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B0C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:14:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A719C20739
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iL/M2Sm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A719C20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1076D82B;
	Thu,  5 Nov 2020 03:13:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1076D82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604542437;
	bh=Pyhj9YWCkvgX0pkTnLeVBzr2+HYQp59ghUB04ZW72FU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iL/M2Sm+SvcttW8Xor2DKjjt+arc6c3xpgQ6wA0j4mfh82ErqFsoYYajggU3z88Yk
	 qnMIvVytLPlp8ja+KWOwQfQjsapArzr9tBi817b0hIfocTbxAQL7DnaElMPL0kD86e
	 9zXdd1pXpFEM+B0pcicG01sGXSpEfacYYnYGm5ro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CE43F80229;
	Thu,  5 Nov 2020 03:13:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66B17F80234; Thu,  5 Nov 2020 03:13:05 +0100 (CET)
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75941F80229
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 03:12:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75941F80229
Received: from b4.vu (localhost.localdomain [127.0.0.1])
 by b4.vu (8.13.8/8.13.8) with ESMTP id 0A52CoiL021586;
 Thu, 5 Nov 2020 12:42:50 +1030
Received: (from g@localhost) by b4.vu (8.13.8/8.13.8/Submit) id 0A52CmRt021585;
 Thu, 5 Nov 2020 12:42:48 +1030
Date: Thu, 5 Nov 2020 12:42:48 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: usb-audio: Add implicit feedback quirk for MODX
Message-ID: <20201105021248.GA21537@b4.vu>
References: <20201104120705.GA19126@b4.vu> <s5hlffhjk6w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlffhjk6w.wl-tiwai@suse.de>
User-Agent: Mutt/1.4.2.2i
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

On Wed, Nov 04, 2020 at 03:00:39PM +0100, Takashi Iwai wrote:
> On Wed, 04 Nov 2020 13:07:05 +0100,
> Geoffrey D. Bennett wrote:
> > 
> > This patch fixes audio distortion on playback for the Yamaha MODX.
> > 
> > Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> > Tested-by: Frank Slotta <frank.slotta@posteo.de>
> 
> Thanks, applied now.

Thanks. Did you see my similar patch that I sent in a few minutes
before that one for the A&H Qu-16?

Geoffrey.
