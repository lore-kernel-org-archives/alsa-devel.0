Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:40:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC120722
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C5jQ20/e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ/CeRZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6404A1665;
	Wed,  1 Jul 2020 07:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6404A1665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593582013;
	bh=rAReKMBuPEcSrpqTIyDSz5RppJfxO0qdNn1tZhXgB98=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C5jQ20/eG1IqPqghM+0smKlr9SQvRUyMS5wJ33ZvGF8FNaYG6YLRDmKdEZYcj9eD4
	 7UG0Xxndob+qspm+u8L4r8dqi0WYWEuXvzV1TyIiqTF/R+u79NgVi3Fx5PsNlqAuCh
	 AuiLWcDFr9J8kPE0naHbFuwKgKGlysP5wgZQq0no=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6882F8020C;
	Wed,  1 Jul 2020 07:39:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDE4AF80217; Wed,  1 Jul 2020 07:39:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5C49F800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 07:39:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5C49F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KJ/CeRZm"
Received: from localhost (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E76920722;
 Wed,  1 Jul 2020 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593581955;
 bh=rAReKMBuPEcSrpqTIyDSz5RppJfxO0qdNn1tZhXgB98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KJ/CeRZmrVl3MDu+is500vYr9W8IyBYjUO/J5YEHMGuccoZ7DzqG3L8V3lz+59/Qw
 aIAXZYZDtWWvbmYpj1vbaGzBZgPcspgCRFSXrG0KGBrdJA1zTcjyyLhnZLViqZJm0o
 X2lzSmWcR+F4QEmXU7UdJasB5KQnZcMNdoFFTgUs=
Date: Wed, 1 Jul 2020 11:09:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown
 streams
Message-ID: <20200701053910.GU2599@vkoul-mobl>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
 <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
 <20200630160349.GR2599@vkoul-mobl>
 <5123471d-92f3-8f49-7a2c-d7b70bf442af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5123471d-92f3-8f49-7a2c-d7b70bf442af@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, slawomir.blauciak@intel.com,
 sanyog.r.kale@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 30-06-20, 11:58, Pierre-Louis Bossart wrote:
> > > +int sdw_startup_stream(void *sdw_substream)
> > 
> > Can we have kernel doc style Documentation for exported APIs?
> 
> yes, that's a miss indeed.
> 
> Though if we follow the existing examples it's not going to be very
> informative, e.g.

Yeah but...
> 
> /**
>  * sdw_disable_stream() - Disable SoundWire stream
>  *
>  * @stream: Soundwire stream
>  *
>  * Documentation/driver-api/soundwire/stream.rst explains this API in detail

it would help to have this pointer. I plan to include the kernel-doc
comments in Documentation for sdw so it would great to have these in
place

-- 
~Vinod
