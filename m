Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC88C2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 14:45:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD8E61284
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 14:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD8E61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B8AA1732;
	Tue, 25 May 2021 16:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B8AA1732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621953952;
	bh=NJdUar8af0rdZYBLwdPudA7NpymLsCZxH70tBGhysbc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pqLhnfg8NwibRdAI+/HnwRcM2efk7e6P9uijgLt4aZt+zVjRn4dI+hG0E0eOyc9PR
	 xuhSjISJYYayw2spQJYCoUue9F5nwDHQPllKetxxdlPMGv0mLgGGuPAx4VoCBZFkUv
	 XOLxnrBUtl6cmr5PhJrmJBoClSZub2xNHxdtBf6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6C0DF800F9;
	Tue, 25 May 2021 16:44:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EF1BF800FA; Tue, 25 May 2021 16:44:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66E26F800F7
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 16:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66E26F800F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="2kKHVtuP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C9C61284;
 Tue, 25 May 2021 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1621953859;
 bh=NJdUar8af0rdZYBLwdPudA7NpymLsCZxH70tBGhysbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2kKHVtuPcKdBu8+eEcJTppd47tQR4i/DIUwvrkzHptaah21baBrjuoVqKn5IzbP4h
 PXM3ew0KIW4KO1L38va50OfU9kxMI0n/mdwy7ygCB9p+Ewblsa6QycIYJffOiQzGp+
 trfPiuPrrOiadUanaAWsWpgeUUcx8cZfygolx2c0=
Date: Tue, 25 May 2021 16:44:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.12 30/63] ASoC: rt5645: add error checking to
 rt5645_probe function
Message-ID: <YK0NQXRPpFl2Q1ut@kroah.com>
References: <20210524144620.2497249-1-sashal@kernel.org>
 <20210524144620.2497249-30-sashal@kernel.org>
 <YK0DRL1hXkWnIjOA@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK0DRL1hXkWnIjOA@sirena.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Phillip Potter <phil@philpotter.co.uk>
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

On Tue, May 25, 2021 at 03:01:40PM +0100, Mark Brown wrote:
> On Mon, May 24, 2021 at 10:45:47AM -0400, Sasha Levin wrote:
> > From: Phillip Potter <phil@philpotter.co.uk>
> > 
> > [ Upstream commit 5e70b8e22b64eed13d5bbebcb5911dae65bf8c6b ]
> > 
> > Check for return value from various snd_soc_dapm_* calls, as many of
> > them can return errors and this should be handled. Also, reintroduce
> > the allocation failure check for rt5645->eq_param as well. Make all
> 
> I also don't have this commit and can't see any sign of it
> having been submitted upstream.

I cc:ed you on it, as it was part of the larger "revert the umn.edu"
mess.  It's now in 5.13-rc3.

thanks,

greg k-h
