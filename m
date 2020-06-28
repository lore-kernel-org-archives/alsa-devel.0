Return-Path: <SRS0=3jBL=AJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40970C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 22:03:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8FB20672
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 22:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u6o+9sHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8FB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shiny.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4793F1658;
	Mon, 29 Jun 2020 00:02:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4793F1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593381811;
	bh=AKxB/KByGwKPOZjfElEjXzlOSRyCC4vZgiDhIk3CYu8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u6o+9sHserPsgC35yjuffPKNcch9LCAMlhKOaWraUc7nYIKUztblwLpMuYbHkrdHF
	 dMa3AmeuRF1osdHcTk/fM8WpwWz9MpuF9Z9JNmbzoJdxRatoiDNG5Ezaf52lujb+X6
	 2FEWbzoOBAOJyeV2P9vXp/HmjrF2RLvXOY4jHbmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B868CF800F0;
	Mon, 29 Jun 2020 00:02:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5906F8022D; Mon, 29 Jun 2020 00:02:38 +0200 (CEST)
Received: from denise.shiny.it (denise.shiny.it [185.206.84.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 166D5F800B4
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 00:02:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 166D5F800B4
Received: from wc1 (localhost [127.0.0.1])
 by denise.shiny.it (8.15.2/8.15.2) with ESMTP id 05SM2Rl5008557;
 Mon, 29 Jun 2020 00:02:27 +0200
Date: Mon, 29 Jun 2020 00:02:32 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Mark Hills <mark@xwax.org>
Subject: Re: [PATCH 3/3] echoaudio: Address bugs in the interrupt handling
Message-ID: <20200629000139.0212fa11@wc1>
In-Reply-To: <2006192200200.12984@tamla.localdomain>
References: <2006161409060.30751@stax.localdomain>
 <20200616131743.4793-3-mark@xwax.org> <20200617000134.60c5e2b5@wc1>
 <2006171158070.2561@stax.localdomain> <20200619215655.07b6f3ed@wc1>
 <2006192200200.12984@tamla.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 19 Jun 2020 22:21:54 +0100 (BST)
Mark Hills <mark@xwax.org> wrote:

> On Fri, 19 Jun 2020, Giuliano Pochini wrote:
> 
> > On Wed, 17 Jun 2020 12:14:42 +0100 (BST)
> > Mark Hills <mark@xwax.org> wrote:
> > 
> [...]
> > > You might be able to do the comparison before wrapping pipe_position, 
> > > but hopefully you'll consider my patch in reply to Takashi has more 
> > > clarity.
> > 
> > Your patch is very interesting. I didn't take into account the idea of 
> > advancing the position by full periods only. If the PCM subsystem
> > hasn't changed much since I last checked (I wrote the driver many years
> > ago), it should work fine (and I'm sure you tested it). But I don't
> > know if something else requires better resolution.
> 
> It's funny, but I didn't take account of the opposite; that there was any 
> merits to polling inbetween the interrupts for better resolution.
> 
> Takashi pointed out the need for this and we had some discussion. Check 
> the other thread, where I provided a newer revision of the code.
> 
> The good thing is I think we can have all the things we want and be bug 
> free, just I have to understand the specification.
> 
> It would be great if you would like to take a look at the newer code for 
> any problems you can see. I was going to run it for a few days then turn 
> it into some patches.

I looked at your code and I think it's OK. I'm using it for some days
without any problem. I also stressed it with pretty tight timings and it
worked fine all the time.

Since I could not reproduce that problem before, except in some rare random
circumstances, I'm not a good tester at all. At most I can say that your
patch does not make things worse :)


-- 
Giuliano.
