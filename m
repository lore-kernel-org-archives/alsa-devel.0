Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3500AC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 20:14:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5545B61976
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 20:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545B61976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B31C71655;
	Mon, 29 Mar 2021 22:13:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B31C71655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617048853;
	bh=8DIZ+JWJBIByTZrkqVmW48ZtUZDoGgeYzah/9SenDlU=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CcpdZhIvA0LcYGFPIWiTvXEanhdmL9/KLs+UOGv8ro21J3HjzeP+c2xH8cD23zXj7
	 2nLvqDyBMTq+jp03KJA/hF6Izt7gX/d7omOC3lKN61CsvAO6I/0yfySyiFhsC7grHe
	 5EE+QUGcV0B1A/W+kEurvPW9Ou7VKAaXeiElR5M0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35D0FF80157;
	Mon, 29 Mar 2021 22:13:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F278F8015A; Mon, 29 Mar 2021 22:13:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC3C4F800DD
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 22:13:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC3C4F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BLH1mnrg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B97A6192F;
 Mon, 29 Mar 2021 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617048792;
 bh=8DIZ+JWJBIByTZrkqVmW48ZtUZDoGgeYzah/9SenDlU=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=BLH1mnrgqNfLqsJpyV75FjuMDEAemH63WsN9V6sDW5QkGAa9feLy1nw27wmaB5ka2
 lcLSyU2kGdEi1Mucg6S36NRSVy2Q4PJYLyJzLraeD8dcAGiFz2mJDfVfwOqQiwVRkh
 arUKknhXiaE/k9A963VgckOXErHAq/ge6Pq0vs9e+BJZIk5sWT8EoIcOwlpqo2Zood
 8aiPdAapd1/XtnWry3K5M6G+Aarau8fzEP0dwMzbAv8TpXl3IAU4XtUPqfz8BJABOT
 996xaMUKFt5unuZ4eC7uejFLBUf1rDqx5AJ7/SuZjEJr5AP7BYHu1L3po96y/c7jmF
 YaqIEaGvuFOvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210327092857.3073879-1-dmitry.baryshkov@linaro.org>
References: <20210327092857.3073879-1-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] ASoC: q6afe-clocks: fix reprobing of the driver
From: Stephen Boyd <sboyd@kernel.org>
To: Banajit Goswami <bgoswami@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
Date: Mon, 29 Mar 2021 13:13:10 -0700
Message-ID: <161704879057.3012082.16461217665128806379@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Takashi Iwai <tiwai@suse.com>
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

Quoting Dmitry Baryshkov (2021-03-27 02:28:57)
> Q6afe-clocks driver can get reprobed. For example if the APR services
> are restarted after the firmware crash. However currently Q6afe-clocks
> driver will oops because hw.init will get cleared during first _probe
> call. Rewrite the driver to fill the clock data at runtime rather than
> using big static array of clocks.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Any fixes tag?

> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
