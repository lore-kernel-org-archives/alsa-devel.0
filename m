Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E3C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843EF20C09
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oVw9M1C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843EF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shiny.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E1481612;
	Fri, 19 Jun 2020 21:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E1481612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592596674;
	bh=989aojJ33LIOZzi4Fbe8j1Qzg7ol3CQZdYa1ra17wfQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVw9M1C3LBPVQDymsVi49TcID9gjrUasnwjMpZ4BK02sQipjlY3306kRyj9jqV8Fn
	 8+VYGPgprzUHEsqVWuD1RzW7A0ir9osqBsp0IQxrGLscgW9r2P07fSdhg5S3LmoTLj
	 pQwZTmof1t0krhP5iz6uGxzbnw0/cj+SIgNwPCas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 914C2F800EF;
	Fri, 19 Jun 2020 21:57:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 490ADF80252; Fri, 19 Jun 2020 21:57:02 +0200 (CEST)
Received: from denise.shiny.it (denise.shiny.it [185.206.84.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20CA8F800EF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 21:56:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20CA8F800EF
Received: from wc1 (localhost [127.0.0.1])
 by denise.shiny.it (8.15.2/8.15.2) with ESMTP id 05JJunSF029677;
 Fri, 19 Jun 2020 21:56:50 +0200
Date: Fri, 19 Jun 2020 21:56:55 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Mark Hills <mark@xwax.org>
Subject: Re: [PATCH 3/3] echoaudio: Address bugs in the interrupt handling
Message-ID: <20200619215655.07b6f3ed@wc1>
In-Reply-To: <2006171158070.2561@stax.localdomain>
References: <2006161409060.30751@stax.localdomain>
 <20200616131743.4793-3-mark@xwax.org> <20200617000134.60c5e2b5@wc1>
 <2006171158070.2561@stax.localdomain>
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

On Wed, 17 Jun 2020 12:14:42 +0100 (BST)
Mark Hills <mark@xwax.org> wrote:

> On Wed, 17 Jun 2020, Giuliano Pochini wrote:
> [...]
> > -	pipe->position += step;  /* bytes */
> > -
> > -	buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
> > -
> > -	while (pipe->position >= buffer_bytes)
> > -		pipe->position -= buffer_bytes;
> > -
> >  	return 1;
> 
> I think this risks returning to a case where it concludes nothing
> advances if the counter advances by a whole buffer?

Yes, it can, but you can detect that case checking for step >= period_bytes.


> You might be able to do the comparison before wrapping pipe_position, but 
> hopefully you'll consider my patch in reply to Takashi has more clarity.

Your patch is very interesting. I didn't take into account the idea of
advancing the position by full periods only. If the PCM subsystem hasn't
changed much since I last checked (I wrote the driver many years ago), it
should work fine (and I'm sure you tested it). But I don't know if
something else requires better resolution.


-- 
Giuliano.
