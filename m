Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F01C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 15:31:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE4F60FD7
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 15:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BE4F60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6DF51678;
	Fri,  8 Oct 2021 17:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6DF51678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633707107;
	bh=8+7ImSJ4m3PvpXuUfyLFMGEhzENQrTkj1pOv+1Kg52I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5uvWBBmd+uJGQj0hot+1mF5cb2utq79ZCc5d3CbPULWvS7XsAgyOPUy6hg0loPdr
	 fsLdhVv5FQS4W6xVmMYin8nkPvPT5y+zkpzB84JwbE9yiKxNNuaTjONxK871bkH/Lu
	 bzI1OiBhNa9nlcod5G+FVwL6pQBzvboSvV5yxEek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29EB7F80240;
	Fri,  8 Oct 2021 17:30:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CC94F80246; Fri,  8 Oct 2021 17:30:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32FBFF80124
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 17:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32FBFF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dyxiipKl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99BB860FD7;
 Fri,  8 Oct 2021 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633707038;
 bh=8+7ImSJ4m3PvpXuUfyLFMGEhzENQrTkj1pOv+1Kg52I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dyxiipKlHhyZPn5jRpNP9wWXumvxzgjOzQMfGY3mYHIMn7r8cca3a8Ra/wYUMXJuR
 4jzbjtWhVz9I+evoy6pDRsjLBpHbq3n/CuCI0AjMCuId56uJZnuNqBGqzgPqRKKiuJ
 Azl7WFQgrvdT4yoNnZ4JDbQujjUbnW+T9CmUtoNtVTY8QDv4BE7cww4xNgT1wvdv52
 8ng+XHoxOXPSq548p697OdRdEEKOBB4xSnAqob/AuWJzJ3JtV9I6GuN+LOYDUx22co
 eXAiuvrfFtj4Z8Hi82eIZssIyiNs7hLKDyapT644nOB4s6jGCcBZHnwyPwFlxyj/C0
 LXRrBsBtbWs6A==
Date: Fri, 8 Oct 2021 16:30:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH v2 4/5] ASoC: codecs: tx-macro: Update tx default values
Message-ID: <YWBkGzwiOeiIdr9F@sirena.org.uk>
References: <agross@kernel.org; bjorn.andersson@linaro.org; lgirdwood@gmail.com;
 broonie@kernel.org; robh+dt@kernel.org; plai@codeaurora.org;
 bgoswami@codeaurora.org; perex@perex.cz; tiwai@suse.com;
 srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org;
 linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org;
 devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; swboyd@chromium.org;
 judyhsiao@chromium.org; >
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
 <1632313878-12089-5-git-send-email-srivasam@codeaurora.org>
 <e65c77f4-766c-a5ce-9cbd-f1697c1be28c@linaro.org>
 <20ddc4ea-e99c-5492-1931-be1999655563@codeaurora.org>
 <da23bfce-23cd-0869-d752-b0713136072a@linaro.org>
 <5748236d-7db2-9d19-a113-6e66b3dee81f@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eXI7rXJOJnv0Yxnj"
Content-Disposition: inline
In-Reply-To: <5748236d-7db2-9d19-a113-6e66b3dee81f@codeaurora.org>
X-Cookie: When your memory goes, forget it!
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Venkata Prasad Potturu <potturu@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
 agross@kernel.org, rohitkr@codeaurora.org, swboyd@chromium.org,
 judyhsiao@chromium.org, linux-kernel@vger.kernel.org
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


--eXI7rXJOJnv0Yxnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 08, 2021 at 07:37:12PM +0530, Srinivasa Rao Mandadapu wrote:
> On 9/28/2021 2:01 PM, Srinivas Kandagatla wrote:

> > In that case you should probably consider using regmap_register_patch()
> > for corrections to the default registers in sm8250 case.

> As regmap_register_patch() not working in this use case, updating defaults
> in probe for sc7280 specific differences.

In what way is regmap_register_patch() not working?

--eXI7rXJOJnv0Yxnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFgZBoACgkQJNaLcl1U
h9C7eAf/XNE/8gWTD1il/H3m6CvBtA6i9ZKiAEK7auQN6RRstOai7B6solohK+n7
+cAuDDJXZhZicTfYD7kb4fxPLPB/qV4c/sdNw1JEBGdbqDDamSwh9ZCfIvzMF24U
pyvxSMqKqhC+sopzP4Nkd2eJ7Wfs5nmoQQmg4USw18bqPXCyYG/0EnFgsUEUGpC1
+9U5zWuOUaN44RZhRsLK5Zc3jkit7XlSON1K4cnFPxadBXaF+uWF3Xo9JayG4Xfy
AQQdTel0p0ed3zbsYkoU7knG6EZXMAC8Td5Dfds//hd7hbf+cD6geeVbmO4LLHUT
MuanBlwPHQ2n6rbj+o4nWyL4jo5+KA==
=do89
-----END PGP SIGNATURE-----

--eXI7rXJOJnv0Yxnj--
