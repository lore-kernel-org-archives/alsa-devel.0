Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE4C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:26:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC68206CB
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vfi//Ytv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="gx8T8Ks8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC68206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D14A7165E;
	Wed,  1 Jul 2020 14:25:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D14A7165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593606368;
	bh=JYVSSQtO/RwcvVRvIdI0QBvB82a6/ywGNnfxtcn9LiI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vfi//Ytv7aBwumITybUm11kdj0w7AoqNDq20fCYMRDQkge8fHV6GtPSWj/71xzNTi
	 xQ82bT4QDsdwSyd25LlEU9HMhXaPdrXMDKF15O8lJn+4c1RnjqDWV1XxSr5Z3MNqQb
	 WAVzJR/snzxwX6kKaRtjR3BBWVA9CcSXSOOm4yLg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CC35F8020C;
	Wed,  1 Jul 2020 14:25:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51AD0F80217; Wed,  1 Jul 2020 14:25:17 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4337EF800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 14:25:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4337EF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="gx8T8Ks8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject:
 cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mc6HDnxbd+5F6FfclNbK2ye9A98wzJ1Be1KH6FhtLK0=; b=gx8T8Ks8jmJxewEn01Jzs2PpFK
 wnTH8hLZv0VeJN9LzzY0fLjtUrjgmcgTgMQdAHppH+UBkJcENe34rfAIvQn6hwfxsjQ5BgFAKBvQK
 EYyxI0tfKQ4tneH0VWgEhn1ii8aJlSQzcrRhIVzic3orhoCOTzEOpGvjwGI4KSNWnF1Xu2tv44dY6
 QCck+Rxdkagr0VJe3C25xDGLv62vGMa44iIa/aEbv8ZScQ7rRPsNYAuiudLczKC76w+SaQY9iPuWb
 p0KXSuMLQBQOa8qvy6TS+i+AZCbKV8qIoaPnYaZZxNU/3VMwmdv8tex9+oJB3G2cg1AnJ7/40V26k
 R1BaYjNg==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jqbnX-0009jm-I0; Wed, 01 Jul 2020 13:25:07 +0100
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>)
 id 1jqbnX-0004ax-8B; Wed, 01 Jul 2020 13:25:07 +0100
Date: Wed, 1 Jul 2020 13:25:07 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH 3/3] echoaudio: Address bugs in the interrupt handling
In-Reply-To: <20200629000139.0212fa11@wc1>
Message-ID: <2007011320590.17595@stax.localdomain>
References: <2006161409060.30751@stax.localdomain>
 <20200616131743.4793-3-mark@xwax.org> <20200617000134.60c5e2b5@wc1>
 <2006171158070.2561@stax.localdomain> <20200619215655.07b6f3ed@wc1>
 <2006192200200.12984@tamla.localdomain> <20200629000139.0212fa11@wc1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

On Mon, 29 Jun 2020, Giuliano Pochini wrote:

> On Fri, 19 Jun 2020 22:21:54 +0100 (BST)
> Mark Hills <mark@xwax.org> wrote:
> 
> > On Fri, 19 Jun 2020, Giuliano Pochini wrote:
> > 
> > > On Wed, 17 Jun 2020 12:14:42 +0100 (BST)
> > > Mark Hills <mark@xwax.org> wrote:
> > > 
> > [...]
> > > > You might be able to do the comparison before wrapping pipe_position, 
> > > > but hopefully you'll consider my patch in reply to Takashi has more 
> > > > clarity.
> > > 
> > > Your patch is very interesting. I didn't take into account the idea of 
> > > advancing the position by full periods only. If the PCM subsystem
> > > hasn't changed much since I last checked (I wrote the driver many years
> > > ago), it should work fine (and I'm sure you tested it). But I don't
> > > know if something else requires better resolution.
> > 
> > It's funny, but I didn't take account of the opposite; that there was any 
> > merits to polling inbetween the interrupts for better resolution.
> > 
> > Takashi pointed out the need for this and we had some discussion. Check 
> > the other thread, where I provided a newer revision of the code.
> > 
> > The good thing is I think we can have all the things we want and be bug 
> > free, just I have to understand the specification.
> > 
> > It would be great if you would like to take a look at the newer code for 
> > any problems you can see. I was going to run it for a few days then turn 
> > it into some patches.
> 
> I looked at your code and I think it's OK. I'm using it for some days 
> without any problem. I also stressed it with pretty tight timings and it 
> worked fine all the time.
> 
> Since I could not reproduce that problem before, except in some rare 
> random circumstances, I'm not a good tester at all. At most I can say 
> that your patch does not make things worse :)

What software are you using on the device, and are you using x86_64 and 
dmix?

I think some issues might be exaggerated by dmix which has a unique way of 
opening the device several times. And then chromium exercises dmix a lot 
with all of its threads/forks. That would I presume be how it exercises 
races between pcm_pointer and interrupts.

-- 
Mark
