Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD5DC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:27:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4AA61287
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4AA61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6792E1657;
	Mon, 12 Apr 2021 22:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6792E1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618259262;
	bh=VRTKMojKdtuJHFzFHeTyk5iAs1Q1XW/RoReDqe95/PY=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mGY+FIfLepDmnqdeqez2QYLmJzO+V1Y7x2uLKO0UifIT/6YuyCLzVSWvbC4ZTtZXT
	 1X4QsYHjavp2h+iUlp4FLYgCZvGNSHrrZRzHvVA/mK8xpkNdxgd8DlPajmT+JQR57c
	 rJwOGv8DnOZbrIv62u1FfZveijoS0h1yzGJC00lU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DF2AF80273;
	Mon, 12 Apr 2021 22:26:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 821D5F80277; Mon, 12 Apr 2021 22:26:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B719F8025B
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 22:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B719F8025B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a5hbM90j"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5157561287;
 Mon, 12 Apr 2021 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618259190;
 bh=VRTKMojKdtuJHFzFHeTyk5iAs1Q1XW/RoReDqe95/PY=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=a5hbM90jgeBbZy5DXQZpsyRiT8ZFN1jW7xfWb48fGDSVewu1Nlh7spwJ1qNc09oxa
 hHX439tatktCkD5U2cftaq7MlNQsjkmlAQUGLSICT8JPsEI8GS9lnSaFOhoYN/uzDv
 LglgFeGOp75jkVO8WIvHagn2/P89s3J9i4A/K3N1wKDqO6xACbXbgdVDVNmpF+TnoV
 9yMjah6daCGeGLZBPxnSzqIqNPkrvzgKcelcF6dRyiZWtiX3b22cf9ueltiHwQrFuV
 KJ21DEndDqqbkQPfsm3FhdnQW7X6Z16ip8+0UElLY4GTLuZQoyRT8Sn/LBXT/41nN3
 jv9F/WUoSlPXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-3-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-3-jbrunet@baylibre.com>
Subject: Re: [PATCH 2/5] ASoC: wcd934x: use the clock provider API
From: Stephen Boyd <sboyd@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Date: Mon, 12 Apr 2021 13:26:28 -0700
Message-ID: <161825918879.3764895.12600274147776655755@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

Quoting Jerome Brunet (2021-04-10 04:13:53)
> Clock providers should use the clk_hw API

It sort of already is :)

>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
