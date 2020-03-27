Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4EAC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:01:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C14620716
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sVehdO+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="dINhnmPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C14620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C001516DF;
	Fri, 27 Mar 2020 17:00:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C001516DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585324894;
	bh=MX+mORkILjmUZSMVEv3Ioa9yslIfkIHYD+8NZ2isLFg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVehdO+F8J7CeD2T6H0ig5j7y7djgL6XSXaCGPCe3vWSmtBVn9GbAgyFcTuPLxtBl
	 Aa/szAvyMlahp9rQ6o2MlxiEBDjG+VrgaGN6SqtxMJxySvgI3gJ5jdBziV5Hr7YAxh
	 VNKQIDxdmKQ+9UZzSnboFOhre4N3OvHytRvfI7P4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE8CCF80158;
	Fri, 27 Mar 2020 16:50:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CF2CF8015A; Fri, 27 Mar 2020 16:50:20 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0CDAF80147
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 16:50:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0CDAF80147
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="dINhnmPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=879; q=dns/txt; s=axis-central1;
 t=1585324218; x=1616860218;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tUIZ2TlHSplVOSoFJF5jbQyDhEQ5ZLZTcY52D93ZBxU=;
 b=dINhnmPb3/LiBNWRhw/3C/j8g8M3PyNPOdWGfrF1QegHbaNCSRUu6xOg
 in0eBySAgzZbzk25jwk3VXPhE923K+xkAe9Kq5D9c26iVFDqi4MTmqWu3
 NV+n6Bv9KI06dINSYvA5LZq2Q7Z7oxd2tr+QsVi/L/kNbkRBkfsE7TxW8
 BxNJQtVlNo1g2RDo+KwvOmw0fn16WCvpWRatsJ7JriRIuJeCOIgjBWjEl
 jZTsrbIpQm6Mbd7cyvmZOgrsld8XSyrzG+it3NL/lGYm2ycM7qaCmiLu6
 gwQj6tWnKQyyNg/D8JdUnDjSLluVYgxaetyUu9iJh54heiDcMj8wgyJkq g==;
IronPort-SDR: FIxgiDnS3+EMgMl6ypl4iztES7WU6efZqhC7D4DPH8H5PJkOQMG4juf4j0VH3IDOykRIurg82R
 UFcml4+bjyuyfgq24OgPfYGcblUnozt7uPbCcZvrJZnAaoSoHZwHJyGpYkMPQ1EAwJJUPaVoJZ
 yFLOyMv60ONQN+Yb/f/vaudDLyTOI/XGwT2BJsGKsZXry5AlxXlt/QhUKr9UWYprX69FLGUaS7
 VxzmtA2B503gk08HmU3l7RGnTgcq+lzLYBnXFumMeCmXXYfiWbpA6jKxmpFYzFVa+qDgfGsBAb
 Y1w=
X-IronPort-AV: E=Sophos;i="5.72,313,1580770800"; 
   d="scan'208";a="7012894"
Date: Fri, 27 Mar 2020 16:50:13 +0100
From: Jonas Holmberg <jonashg@axis.com>
To: <alsa-devel@alsa-project.org>
Subject: Re: route and chmap
Message-ID: <20200327155013.GA593298@axis.com>
References: <20200326134110.GA3784158@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200326134110.GA3784158@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de
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

CC Takashi.

On Thu, Mar 26, 2020 at 02:41:11PM +0100, Jonas Holmberg wrote:
> Hi,
> I use the route plugin to copy mono to both FL and FR (front left and 
> front right stereo) of the slave during playback. When get_chmap() is 
> called in the route plugin it will call get_chmap() of the slave, 
> which returns 2 channels with FL and FR positions, and then route 
> itself returns 1 channel with FL position. But the application that 
> called snd_pcm_get_chmap() on the playback device expected to get 
> position MONO instead of FL since the number of channels is 1.
> 
> Is the application wrong in not accepting the chmap or should the 
> route plugin have changed position from FL to MONO? Is it possible to 
> add something to the config (asound.conf) to make FL become MONO in 
> the reply of get_chmap() or solve the problem in any other way?
> 
> BR
> /Jonas
