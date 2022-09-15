Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D535AC54EE9
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Sep 2022 09:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 054BA1A99;
	Fri, 16 Sep 2022 11:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 054BA1A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663322155;
	bh=bPpdmFa0b0G5qqR/+F55Iemq+gPQDO/ZKeK4GM6KN/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cD8MOEdRgw8+UQ8jDOjF4b1qqdh5p1lt87AmAuldram7k+Vqhfh8d+4zd9gNRHS3X
	 V3cyuipMQrLoprhfSgWIDAIM+zna4zo4KuuEjtU48eYYW5zuUklgdBa5CDaCpW/fjz
	 BpHvsWnt1ZSBnbTUBCv+b09MFgkQc1kPyV3EV9+g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6829F80551;
	Fri, 16 Sep 2022 11:53:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAF36F80238; Thu, 15 Sep 2022 05:37:28 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06047F800B5
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 05:37:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06047F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eVEKUBEp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C843FB81D84;
 Thu, 15 Sep 2022 03:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42643C43140;
 Thu, 15 Sep 2022 03:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663213043;
 bh=bPpdmFa0b0G5qqR/+F55Iemq+gPQDO/ZKeK4GM6KN/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eVEKUBEpQ68Xr8xQf73Q97Sydgh6v0J7ROumKfgfCwosFZKBlTE+al0d40JVd1kg4
 JcTKXQijk/OwG8Qz5QhDMm01xiLdLQAVsJVZhZmWvL50Hzk8o7miO0uG3c8EQeFosF
 9P7pM8oEUc0DYes03FH60z+XpKIALIkco43mAot2X+xWMki49Ssnkq0Xrx3r/H+tuj
 gsFT0/OKDuCtN+aEk4Ey/fxo0nbaaDWkMgn+Q/dSAOvkfnK1UTCCzF5PNhpD8BsoJc
 zoSu5TfntS2e9xtVdOh0aITFcHh++WojVLhNmeVAzUtRvhPy66CbLyGvyjpdhR+f5C
 Uf1iUtFa3jt8Q==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org, lgirdwood@gmail.com,
 Bjorn Andersson <andersson@kernel.org>, bgoswami@quicinc.com,
 yassine.oudjana@gmail.com, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, srinivas.kandagatla@linaro.org, perex@perex.cz,
 krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH v2 0/3] ASoC: dt-bindings: Add bindings for
 WCD9335 DAIs
Date: Wed, 14 Sep 2022 22:37:04 -0500
Message-Id: <166321302051.788007.14749048847607855302.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220622161322.168017-1-y.oudjana@protonmail.com>
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Sep 2022 11:53:36 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 y.oudjana@protonmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
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

On Wed, 22 Jun 2022 20:13:19 +0400, Yassine Oudjana wrote:
> Add DT bindings for WCD9335 DAIs and use them in the driver as well
> as all device trees currently using WCD9335.
> 
> Changes since v1:
>  - Make header guard match path
>  - Maintain the alphabetical order in msm8996-xiaomi-gemini includes
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: Use WCD9335 DT bindings
      commit: b504af6c9912502efa9af162b50cd589351b6894

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
