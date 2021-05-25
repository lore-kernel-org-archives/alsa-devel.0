Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBAFC2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 14:45:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353416142B
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 14:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353416142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3EED1728;
	Tue, 25 May 2021 16:44:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3EED1728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621953901;
	bh=PKuRkkYVUsjsx8prZ4f2odHDCB8TksLtWQ8YdxSBZWE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDf924kGT6A6SExlqyhjPgUCuxj9KNym5jznTCZOF14PklOl2dlpgQ1XDG+dR1mRx
	 W/CXJtG6omR7dHRTIWFqp2nuOWdmPHCLupgZ0djAUixbfgFzq/9PegTih0vQpzWRmQ
	 3LoB7iTxFQAZj0TRZ2WIlIrCCWlNW6wWqXwgaQaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19540F800C9;
	Tue, 25 May 2021 16:44:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18479F800CB; Tue, 25 May 2021 16:44:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BCF2F800AC
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 16:43:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BCF2F800AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="mfYYI3h3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B87A6141C;
 Tue, 25 May 2021 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1621953835;
 bh=PKuRkkYVUsjsx8prZ4f2odHDCB8TksLtWQ8YdxSBZWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mfYYI3h3CqOHnRs7Q1WE//kdP0frslMGuyujkauCTBsCHJ1JTGRuJuJNS9w0KlrYA
 h11P5RUM73YBiwrrfLgTOvLH3WT29nNgl36DT9oje2EOvl+XZbOb4fHQArIazABedT
 tBCVrmfljZpJ48SarpdR8J0TE8gl+pzPr1Q/8Xjs=
Date: Tue, 25 May 2021 16:43:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.12 32/63] ASoC: cs43130: handle errors in
 cs43130_probe() properly
Message-ID: <YK0NKG0l3a5vjO8K@kroah.com>
References: <20210524144620.2497249-1-sashal@kernel.org>
 <20210524144620.2497249-32-sashal@kernel.org>
 <YK0C/HLiQtt/vyqV@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK0C/HLiQtt/vyqV@sirena.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

On Tue, May 25, 2021 at 03:00:28PM +0100, Mark Brown wrote:
> On Mon, May 24, 2021 at 10:45:49AM -0400, Sasha Levin wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > [ Upstream commit 2da441a6491d93eff8ffff523837fd621dc80389 ]
> > 
> > cs43130_probe() does not do any valid error checking of things it
> > initializes, OR what it does, it does not unwind properly if there are
> > errors.
> 
> I don't have this commit and can't see any sign of it having been
> submitted upstream.  Where is it being backported from?  The last
> commit I can see in -next to this driver is
> d2912cb15bdda8ba4a5dd73396ad62641af2f520 (treewide: Replace GPLv2
> boilerplate/reference with SPDX - rule 500) from 2019.

This is now in 5.13-rc3.

You should have been cc:ed on it a few times already.

thanks,

greg k-h
