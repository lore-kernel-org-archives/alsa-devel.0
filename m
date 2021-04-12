Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878FC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:28:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE226128E
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE226128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5F3415F2;
	Mon, 12 Apr 2021 22:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5F3415F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618259307;
	bh=EO26agsZ52yk+XYY7+s4dbantb8ueHlmFx9OyyK0kTo=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fbuklV1lPaR//0lnR5DYFO8tprZH524kUmrX0tg9OeWg+Vwbu+2ISjnaF14kNp4aV
	 2KSOzEsVaSQyDVbR+9NGvTWFN6FnhmGYWnHVdSVssHgx53pjmi0PeqO8Vve2Y4ac7W
	 Bl7zess8qtYv8JUg/bQcpZjaNi/IssITb1hVdNPg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D71CF80271;
	Mon, 12 Apr 2021 22:27:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA025F802D2; Mon, 12 Apr 2021 22:27:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79CD3F800D3
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 22:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79CD3F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pLMW7bpy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35E3161287;
 Mon, 12 Apr 2021 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618259251;
 bh=EO26agsZ52yk+XYY7+s4dbantb8ueHlmFx9OyyK0kTo=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=pLMW7bpyTauye9n/tTJLfkCwDAwwFDRQ88/4wo4aaJ5E66wy3JKxheNS4il9Qk/jB
 FH7i3eNyFMEPR5HQKYSmzXvrBJeZvZaZIOH8NGIe5Wy13B+b5rOodzIx371WIlaWPE
 5GGZhIABHHI/15d2qhtkg6H+nrpd4ND+GlyQw/T83gMkQ9t0Fqom4whs/Bi0soRsDv
 5AYmcwoJ9jwmNC1J4/SoIQeoyNU2MG0xXeXfiSImKpuyjBDzLnVV9chQ5GL4NmcTFx
 llEC3+ommCAYxYRR11zwvCB/rvF1yYLA+wJbIeCJygJsCEZLvlMZgMup13UaFxhH1J
 fxSDuy7HnJ4Zw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-6-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-6-jbrunet@baylibre.com>
Subject: Re: [PATCH 5/5] ASoC: da7219: properly get clk from the provider
From: Stephen Boyd <sboyd@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Date: Mon, 12 Apr 2021 13:27:29 -0700
Message-ID: <161825924986.3764895.15935511179507514937@swboyd.mtv.corp.google.com>
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

Quoting Jerome Brunet (2021-04-10 04:13:56)
> Instead of using the clk embedded in the clk_hw (which is meant to go
> away), a clock provider which need to interact with its own clock should
> request clk reference through the clock provider API.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
