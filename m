Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6225C49EA7
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 07:25:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549996112D
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 07:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549996112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F5051677;
	Tue, 22 Jun 2021 09:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F5051677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624346738;
	bh=cCLHRHFoRVcl2Logdg1B0DP6gklG+JMjFHviRK6p4oY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dV0I/ddwghPjo3W5HmDmMH+zuz35CgU4nPRRAn33Vc0JQ8ZybdUDrrRWKFts77a6/
	 sdOsRm/Qv2LKprn3/2ETgFVX3WgTY1sglSgErkdhz3obeU+G5Kzt1Gxjm+Hgc7lXZQ
	 qXWmvcwjwrvPIgM/8cfdI+HxkqfFoRkNl0zF7nWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4367F8025F;
	Tue, 22 Jun 2021 09:24:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 115BFF80268; Tue, 22 Jun 2021 09:24:46 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FA80F800E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 09:24:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FA80F800E1
Received: by m.b4.vu (Postfix, from userid 1000)
 id ECAFD61E2853; Tue, 22 Jun 2021 16:54:30 +0930 (ACST)
Date: Tue, 22 Jun 2021 16:54:30 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 16/31] ALSA: usb-audio: scarlett2: Add Gen 3 mixer support
Message-ID: <20210622072430.GA13614@m.b4.vu>
References: <cover.1624294591.git.g@b4.vu>
 <fc4bb1e8cfb3019b1033afeed59badb904990115.1624294591.git.g@b4.vu>
 <s5hh7hqs7ss.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7hqs7ss.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, alsa-devel@alsa-project.org,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

On Tue, Jun 22, 2021 at 09:00:19AM +0200, Takashi Iwai wrote:
> On Mon, 21 Jun 2021 20:09:48 +0200,
> Geoffrey D. Bennett wrote:
> > 
> > Add mixer support for the Focusrite Scarlett 4i4, 8i6, 18i8, and 18i20
> > Gen 3 devices.
> > 
> > Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> > ---
> >  sound/usb/mixer.c               |   2 +-
> >  sound/usb/mixer_quirks.c        |   4 +
> >  sound/usb/mixer_scarlett_gen2.c | 260 +++++++++++++++++++++++++++++---
> >  3 files changed, 246 insertions(+), 20 deletions(-)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 428d581f988f..ba4aa1eacb04 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -50,7 +50,7 @@
> >  #include "mixer_quirks.h"
> >  #include "power.h"
> >  
> > -#define MAX_ID_ELEMS	256
> > +#define MAX_ID_ELEMS	512
> 
> This change requires the explanation.
> Usually the unit id is a byte per definition, so it can't be over
> 256.

Before making this change we were getting a buffer overflow in
mixer->id_elems[] (snd_usb_mixer_add_list()) because more than 256
controls were being added for the 18i20 Gen 3 device. I will send a
replacement patch with an updated comment.
