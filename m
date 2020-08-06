Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB7C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 00:33:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3611D2173E
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 00:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X/R6NEqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyYpl8j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3611D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B27484A;
	Thu,  6 Aug 2020 02:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B27484A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596673979;
	bh=COlM6ZwpJBn0yZ7U5zGmwKi2QBKcTNFY6uKqQQLWL9I=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/R6NEqIVqxijsTz1cXD4Fu1B4BFrC0NchHNndQQN/HDptiH6MsGwFczod/RB4J/C
	 04x5Zps96S+Uu8Q6vGqJO9hIb5LePWkXhYDLRBnrHoNP6t+lLczNJduErHT0x03Rma
	 EEGUrdersYp2jeQLql80n45eUWZXvhwFUSIPHbSI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19A5EF801F7;
	Thu,  6 Aug 2020 02:32:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38826F80218; Thu,  6 Aug 2020 02:32:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C94ADF80124
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 02:32:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C94ADF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NyYpl8j7"
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 741DB2173E;
 Thu,  6 Aug 2020 00:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596673917;
 bh=COlM6ZwpJBn0yZ7U5zGmwKi2QBKcTNFY6uKqQQLWL9I=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=NyYpl8j7GnE0b6Kl9PfXT74TEaVjbKcJZhVIYLuCXYezr42vioZTRPEVqIghVq1F4
 zNIZU0xHD6nN48uda830HuH8BpUcKUyC/m9qlBIBKXRrYYuT+KwRh1A+dNmzWkX2Ye
 KUyGv5thzFRaFuJCm0Wn0WY0Ymm34tc/mAb9/oes=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595413915-17867-2-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-2-git-send-email-rohitkr@codeaurora.org>
Subject: Re: [PATCH v4 01/12] ASoC: qcom: Add common array to initialize soc
 based core clocks
From: Stephen Boyd <sboyd@kernel.org>
To: Rohit kumar <rohitkr@codeaurora.org>, agross@kernel.org,
 alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 bjorn.andersson@linaro.org, broonie@kernel.org, devicetree@vger.kernel.org,
 lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, perex@perex.cz, plai@codeaurora.org,
 robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Date: Wed, 05 Aug 2020 17:31:56 -0700
Message-ID: <159667391634.1360974.15763918681460437981@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: Rohit kumar <rohitkr@codeaurora.org>, Ajit Pandey <ajitp@codeaurora.org>
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

Quoting Rohit kumar (2020-07-22 03:31:44)
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> LPASS variants have their own soc specific clocks that needs to be
> enabled for MI2S audio support. Added a common variable in drvdata to
> initialize such clocks using bulk clk api. Such clock names is
> defined in variants specific data and needs to fetched during init.

Why not just get all the clks and not even care about the names of them?
Use devm_clk_bulk_get_all() for that, unless some clks need to change
rates?
