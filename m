Return-Path: <SRS0=WmEX=M6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E1C4338F
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Aug 2021 08:17:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E4C61164
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Aug 2021 08:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8E4C61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE80516B1;
	Sat,  7 Aug 2021 10:17:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE80516B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628324270;
	bh=d7H3u7cqpnsZ9Xce5y7GvurT2XWmylBa5mXCyE1ePvQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9W+FEuLjN8W4Xgh9RwNzPoPJO6+5FJ6c4h3k+tytJn+85aww169jvzNky8/HEXN1
	 ElvAgJbsFoluhPcD2pZWFYNLZbgHmASyHVmGPuicRyXuE0FBG8yNymmIeaW1UCT8Vg
	 PPj1Dyb8hmlCitArgC+JWDTX3IcHDgvcK+YmMNiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C205F8016D;
	Sat,  7 Aug 2021 10:17:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A016F8027C; Sat,  7 Aug 2021 10:16:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B110F800FD
 for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2021 10:16:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B110F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="GLjNarE2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF6460F59;
 Sat,  7 Aug 2021 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1628324210;
 bh=d7H3u7cqpnsZ9Xce5y7GvurT2XWmylBa5mXCyE1ePvQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GLjNarE2CCrxFP5ZVjcAo7+4fyzNmsFTceG6YzX+7Y0OCpbHZzu4T5WAzxHq6EWfG
 NZf2UaSTpxVWNALNF1Nf73bPqxwaWYK7tAOdmV7QoaMWcEB7vayxy7vaLdk6Iq12gC
 tF+LQ0eEDfsc4gQ6eRPP4hPs17cfS1mmR7/wo2LE=
Date: Sat, 7 Aug 2021 10:16:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>, Jeff Woods <jwoods@fnordco.com>
Subject: Re: Kernel 5.13.6 breaks mmap with snd-hdsp module
Message-ID: <YQ5Bb+mPgPivLqvX@kroah.com>
References: <17b1f9647ee.1179b6a05461889.5940365952430364689@fnordco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b1f9647ee.1179b6a05461889.5940365952430364689@fnordco.com>
Cc: alsa-devel@alsa-project.org, regressions <regressions@lists.linux.dev>,
 stable <stable@vger.kernel.org>
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

On Sat, Aug 07, 2021 at 12:49:07AM -0700, Jeff Woods wrote:
> Specifically, commit c4824ae7db418aee6f50f308a20b832e58e997fd triggers the problem. Reverting this change restores functionality.
> 
> The device is an RME Multiface II, using the snd-hdsp driver.
> 
> Expected behavior: Device plays sound normally
> 
> Exhibited behavior: When a program attempts to open the device, the following ALSA lib error happens:
> 
> ALSA lib pcm_direct.c:1169:(snd1_pcm_direct_initialize_slave) slave plugin does not support mmap interleaved or mmap noninterleaved access
> 
> This change hasn't affected my other computers with less esoteric hardware, so probably the problem lies with the snd-hdsp driver, but the device is unusable without reverting that commit.
> 
> I am available to test any patches for this issue.

Have you notified the developers involved in this change about this
issue?

Adding them now...

thanks,

greg k-h
