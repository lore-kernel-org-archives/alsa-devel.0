Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D106C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 08:19:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C018060C3E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 08:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C018060C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 124E21672;
	Tue, 22 Jun 2021 10:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 124E21672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624349984;
	bh=CXW9cZpXgdyfoLvqHv8lArw/LuKGjxTAslkUwfBSbxY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTydIMw90GYGL0GxAnrva0jCv60PUBPhGDzWnZe5XWZGPJbKnxYsvqrN7Pl9zfalH
	 nq4vHXvTXARvW/dhYNl7GhMQwLB+tihl3/c4hdrvBysN7QhtYZytlXLR2EbMhvHTRx
	 EMTcqWjTfWsxZFvtF8rT4fKrFG9xOM7imajTGkm8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF16AF8025F;
	Tue, 22 Jun 2021 10:18:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B6D2F80268; Tue, 22 Jun 2021 10:18:52 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8A9EF80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 10:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8A9EF80161
Received: by m.b4.vu (Postfix, from userid 1000)
 id AABE561E2869; Tue, 22 Jun 2021 17:48:39 +0930 (ACST)
Date: Tue, 22 Jun 2021 17:48:39 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 16/31] ALSA: usb-audio: scarlett2: Add Gen 3 mixer support
Message-ID: <20210622081839.GA13849@m.b4.vu>
References: <cover.1624294591.git.g@b4.vu>
 <fc4bb1e8cfb3019b1033afeed59badb904990115.1624294591.git.g@b4.vu>
 <s5hh7hqs7ss.wl-tiwai@suse.de>
 <0b00f3a5-fe31-0ad5-c723-d354dc724e58@gmail.com>
 <s5hczses67y.wl-tiwai@suse.de> <20210622074454.GB13614@m.b4.vu>
 <s5h4kdqs53w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4kdqs53w.wl-tiwai@suse.de>
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

On Tue, Jun 22, 2021 at 09:58:27AM +0200, Takashi Iwai wrote:
> On Tue, 22 Jun 2021 09:44:54 +0200,
> Geoffrey D. Bennett wrote:
> > 
> > On Tue, Jun 22, 2021 at 09:34:25AM +0200, Takashi Iwai wrote:
> > > On Tue, 22 Jun 2021 09:07:20 +0200,
> > > Vladimir Sadovnikov wrote:
> > > > 
> > > > Hello Takashi!
> > > > 
> > > > Since Focusrite devices are too advanced in settings, the overall
> > > > amount of 256 controls is not enough for these devices (like 18i20).
> > > > I would like also to extend this constant up to 1024 or even more
> > > > since adding support of software configuration of the device also
> > > > can exceed the amount of 512 control elements.
> > > 
> > > This define isn't for the total number of mixer elements.  Instead,
> > > it's just a size of the bitmap table that contains the head of the
> > > linked list for each unit id (in the sense of USB mixer spec).
> > > So the number of mixer elements is unlimited.
> > 
> > Sorry I don't understand what's going on then. Am I calling
> > snd_usb_mixer_add_control() wrong? Because when I called it more than
> > MAX_ID_ELEMS times I got a buffer overflow in mixer->id_elems[] (from
> > memory, I can confirm tonight).
> > 
> > snd_usb_create_mixer() has:
> > 
> >         mixer->id_elems = kcalloc(MAX_ID_ELEMS, sizeof(*mixer->id_elems),
> >                                   GFP_KERNEL);
> > 
> > snd_usb_mixer_add_control() called from mixer_scarlett_gen2.c ends up
> > at snd_usb_mixer_add_list() which does:
> > 
> >         list->next_id_elem = mixer->id_elems[list->id];
> >         mixer->id_elems[list->id] = list;
> > 
> > And list->id was going over MAX_ID_ELEMS.
> 
> Here, list->id is the *USB* mixer unit id, not the ALSA control id or
> whatever the internal index.  The former should be a byte, hence it
> can't be over 256.
> 
> That said, the scarlett2 code calls the function in a wrong way.  It
> has worked casually, so far, just because the core code doesn't use
> the unit id number for significant roles.
> 
> So, as a quick workaround, simply pass 0 or any fixed number under 256
> to list->id (i.e. elem->head.id in scarlett2_add_new_ctl()).  That's
> all, and the elements are chained in the linked list.

Okay, I will fix that tonight.

Were patches 1-15 of this set of 31 acceptable? If so, I will send a
new set with this fix and the remainder of the patches.
