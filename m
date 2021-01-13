Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF24C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:14:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4F322248
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4F322248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDB3B16DB;
	Wed, 13 Jan 2021 16:13:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDB3B16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610550877;
	bh=v86fR0KA75OY/eE4zGqzgcqORHRvLp55YWCmUrvVZRc=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EHDC5yRwyqoqs4QhmQ89Qag3zj7dnUJBrvqEF+mCpsEiZfbwFxfIhG9YZxQe53R2H
	 KZ7DLj++5Pm2xikez1QEBzMKdJ69hfLffAvwUVFf2URjoCRo+p6GEEc9VFUKEx6AR/
	 VapGunc9pVO/zJWbhyTQf4eqYjWvtupJee2zu5tE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8901EF8016D;
	Wed, 13 Jan 2021 16:13:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CA3CF801ED; Wed, 13 Jan 2021 16:13:45 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5BFDF80085
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 16:13:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5BFDF80085
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net
 [82.255.60.242]) (Authenticated sender: hadess@hadess.net)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 357151C000A;
 Wed, 13 Jan 2021 15:13:41 +0000 (UTC)
Message-ID: <06de89645b182ce8367d23c2bb2dbc6e2a895da7.camel@hadess.net>
Subject: Re: USB Wireless device support
From: Bastien Nocera <hadess@hadess.net>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 13 Jan 2021 16:13:40 +0100
In-Reply-To: <s5hv9c0nabg.wl-tiwai@suse.de>
References: <e1e944b48ae44106a57c74de19dd74d6193495fe.camel@hadess.net>
 <3b322bb54a1df4b2a45586bc687fba3be5f9e3d8.camel@hadess.net>
 <s5h4kjkopsu.wl-tiwai@suse.de>
 <8adebcef15874187b18b930d5a71e79c6297ee80.camel@hadess.net>
 <s5hv9c0nabg.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, 2021-01-13 at 16:08 +0100, Takashi Iwai wrote:
> <snip>
> Nothing so far, and that's the problem.  HID is managed in a
> completely different layer, hence the integration needs to be done in
> a higher level like PA, I suppose.  In theory we might be able to
> extend UCM to handle the other external devices, though.

hid-prodikeys.c seems to do some MIDI stuff...

