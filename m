Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDDBC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:26:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D43611C9
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D43611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6D78950;
	Mon, 12 Apr 2021 22:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6D78950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618259211;
	bh=r9UKdIFOgp7BUaHYAHhj7B4vhiYePgsCQ4+XN5Emsd4=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LN02FwmxW4tOOiB9S8om0ra+P7Zj7I59VhQeOthdlDr2bZ4YZLgXn4XrjutUFn9kT
	 dCbrBCWA/BCGTdMM/Rys4OQde+lgWnupobnDHDqQej7B/CrUklz9X7QogUtuFb2ivL
	 tSeaf7Jh5awM+xNzuJvzeZ719JDbBx6gl+YF4OCA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D91CF800FF;
	Mon, 12 Apr 2021 22:26:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DE23F80269; Mon, 12 Apr 2021 22:25:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 026A1F800FF
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 22:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 026A1F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AYOwAoNu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E5FC61352;
 Mon, 12 Apr 2021 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618259147;
 bh=r9UKdIFOgp7BUaHYAHhj7B4vhiYePgsCQ4+XN5Emsd4=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=AYOwAoNutSyEqKl/2oZRcdM3qcas7yBRs2LDYEwXIM1B/XVxzEl710EIpG4BJL07Q
 1ifr2J6YaQnGYpAXvTakowZHoxrqrGofbVULEDDEA1Zw3JpwTS69a33HxXjrC4JU4x
 jCiFPin/JuJjKnVCLBfaWMI9kcdGVshDDFvc4Q6MDPQNQYjmPskTjauto+klyqj87V
 9HLCjUvaW3V7CXhRXaggpGYwOzrAFsQcTffpcGt/0jfr9QqgtVb8wR8rZtwg9hvEY9
 rC9mU/TBKWlojN3qhx9uYtXE7U6hJA7xWpXHUW00J5qg2cu04dOI6149IJM/gdkCMM
 Adz/rWlUZEWzA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-2-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-2-jbrunet@baylibre.com>
Subject: Re: [PATCH 1/5] ASoC: stm32: properly get clk from the provider
From: Stephen Boyd <sboyd@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Date: Mon, 12 Apr 2021 13:25:45 -0700
Message-ID: <161825914594.3764895.14268186433795123078@swboyd.mtv.corp.google.com>
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

Quoting Jerome Brunet (2021-04-10 04:13:52)
> Instead of using the clk embedded in the clk_hw (which is meant to go
> away), a clock provider which need to interact with its own clock should
> request clk reference through the clock provider API.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
