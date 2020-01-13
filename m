Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD0C33CB1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4A9207FD
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZAEDsdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4A9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FAA92273;
	Mon, 13 Jan 2020 18:48:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FAA92273
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BC6AF80149;
	Mon, 13 Jan 2020 18:48:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02FADF80122; Mon, 13 Jan 2020 18:47:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC7C0F80122
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 18:47:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC7C0F80122
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HZAEDsdh"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C3EB207FF
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578937671;
 bh=420Be14jKaTH32OurZrKPNIQub47Hpo3uK0ctqQ8RIM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HZAEDsdhMVkPgxk6sb7TF2ekZG229gzq4+PBS2A/m3G2TCWXNzC39KnHeSACk7336
 CQX0GWK2slaqnHbGILb1N878XJMWsU20XFD9mUIUOsu7QsrJI0reGoCOrQB7env8N6
 9QX59R4Q7fiJ3w/Ms3WKIyGmRjpoePslWtcw1fjk=
Received: by mail-qt1-f171.google.com with SMTP id g1so9801209qtr.13
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 09:47:51 -0800 (PST)
X-Gm-Message-State: APjAAAVQ01x9rY62jJ5fEbml6yqGYYbd8Mwb+s/WUsD5RQ6ghaFHiQej
 e2jaL/SONAuNOWsxoRTTzXXTbj7ZWdsJDda0LA==
X-Google-Smtp-Source: APXvYqyOP02EFeQzZVGOkKcmkWThEByr7yBqlkAW9V7YQ/fRph85ZPueN+tEQJW0P3g/2yrWKgBl4HogT1hbWsd2r8c=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr15250352qtq.143.1578937670237; 
 Mon, 13 Jan 2020 09:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20200107135929.3267-1-srinivas.kandagatla@linaro.org>
 <20200107135929.3267-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200107135929.3267-2-srinivas.kandagatla@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 13 Jan 2020 11:47:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a5idL=R88u=iHfiK_M9wCUn7MLcOJC1v0QXzYV7A-Lw@mail.gmail.com>
Message-ID: <CAL_Jsq+a5idL=R88u=iHfiK_M9wCUn7MLcOJC1v0QXzYV7A-Lw@mail.gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, spapothi@codeaurora.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v11 1/2] dt-bindings: ASoC: Add WSA881x
	bindings
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Jan 7, 2020 at 7:59 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

This schema now is applied to the soundwire-controller.yaml example and fails:

Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
speaker@0,1: '#sound-dai-cells' is a required property
Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
speaker@0,2: '#sound-dai-cells' is a required property

Please fix.

Rob
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
