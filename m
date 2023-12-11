Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BEC4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:29:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89D90A4B;
	Mon, 11 Dec 2023 14:29:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89D90A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702301372;
	bh=0CpLD8dRzQ8OFlBx0wOWEw/1qMni4oZG0S8sbx9hVhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Lo9iAnkapiyyWq2yuOtu/4ta4e2bNxLKXrLKxZLi4jsBDSemu10i0ilv8ik6eaMwg
	 WVkMcwsAM7de7CbYlA0uMLGGYjZNOACTdOa2P3oca9tQ3Oo+bo4Q7ZLYPBqHlaT6RF
	 VgfCQkAkCSrMgxrobs77J5jUq1uZAMJML+3J6/BA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9209F8059F; Mon, 11 Dec 2023 14:29:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ADAB4F80587;
	Mon, 11 Dec 2023 14:28:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C20CF80166; Mon, 11 Dec 2023 14:28:54 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4AEB5F800D2
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AEB5F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dW0Kee/Z
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B5AAD61265;
	Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D2CC433C7;
	Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301327;
	bh=0CpLD8dRzQ8OFlBx0wOWEw/1qMni4oZG0S8sbx9hVhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW0Kee/ZC/h61mXDknAqmvMfOFO0E1U9zx6VF2/UZ9beG6QCr1xu6V0qN73VNbPXx
	 Q+PiKV7Tnabq9/0lDvLtQb7M0kTOW4LKuJtUej29Bw5YRkfw2vnhjg7vEtq6NsLIjD
	 6ipgtF1qCFuxc1ZzywO7uPqpiOwpB5+tkmRVxnnyQulDrtSpW4uRiOUMg/b6+QiSS7
	 bERbLXwUi8b/CjBdwKdzIIgX0+ijf30d2OQ+aUpUhhL1v1lz6IO52hcVdQCFOE39GX
	 dz7BIjQjdDzQ4fXnL/j8SDiuvtMmZZh1AmCdyiTvPZrzTQrsvd5M6KDQnmaAJVdig0
	 S8Kyaih/VTytA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rCgLm-0007HX-1E;
	Mon, 11 Dec 2023 14:29:34 +0100
Date: Mon, 11 Dec 2023 14:29:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <ZXcOvl1tUWmwGalB@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
 <2023121146-hunger-crane-7dee@gregkh>
 <2023121113-walrus-outmost-ec34@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121113-walrus-outmost-ec34@gregkh>
Message-ID-Hash: KY3XPBPGQBNKEF3FTIYYX72IVZU4B2JQ
X-Message-ID-Hash: KY3XPBPGQBNKEF3FTIYYX72IVZU4B2JQ
X-MailFrom: johan@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KY3XPBPGQBNKEF3FTIYYX72IVZU4B2JQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Dec 11, 2023 at 01:54:39PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 01:40:52PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 11, 2023 at 09:08:03AM +0100, Johan Hovold wrote:
> > > On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:

> > > These were unfortunately not marked for stable, but could you pick them
> > > up for 6.6?
> > > 
> > > The upstream commits are:
> > > 
> > > 	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
> > > 	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")
> > 
> > Now queued up, thanks.
> 
> Oops, no, this breaks the build on 6.6.y, can you send a series that is
> at least built for this series successfully?  :)

Sorry about that. I was not aware of the asoc interface rename that went
into 6.7.

Just sent a backport of the series here:

	https://lore.kernel.org/r/20231211132608.27861-1-johan+linaro@kernel.org

Johan
