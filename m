Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BAC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 19:24:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDFD60FF2
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 19:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CDFD60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C43241684;
	Fri,  8 Oct 2021 21:23:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C43241684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633721046;
	bh=5SF9dAQW84jt+sFJIXPvCVpma/lc66zeyItpvZ+6RXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mBXvd+K+K4mJFSLI13F8PPGN3qJ/RJ2Hk7zyfCtbZcev0Ywt8XqX7dbPr7KlP9ipm
	 rJ6XrSNz0gV867jmrg3zz9+UN9Yp+8Mk+JjUU+BhGqAWt2KsVTGhhlxtpJhphX+NjE
	 6JmJRcTnuXcuAXsfH+1HBOZYqgy1n2SRNOTfvLFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42025F80240;
	Fri,  8 Oct 2021 21:23:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BC93F80246; Fri,  8 Oct 2021 21:23:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96250F80229
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 21:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96250F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="duxnZbDD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04C7061168
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633720985;
 bh=5SF9dAQW84jt+sFJIXPvCVpma/lc66zeyItpvZ+6RXg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=duxnZbDDhRFt2DYY2k+KtpZd341YTFw2E++JmibZxOePdA1uYk7PYUgqqEK7Bxp7g
 48bWedzW1aBv1rDXSdb36hBfz5asvI4lE9nf3AfpPktrMCJeshg6YWA1VQ7hjkLuId
 1XNHLYTXeWj620cGNH6bEJ2Lh7pALoP/CNrbLICZgvXMEPIyD+Mpitt/6/VfIu3xb8
 9kO46AT8ATy71GkJyPiMDTyEBN7BHa6KqeKKh9P58DXcEv6kQ6rQ+HgytPUbNV7wV/
 oAhYrCNta1b+2SAaGKLnpzJXsRUGOgbCytJXVTSIhlVrZOGZLMjOkT2CFbBoBf/tlW
 63MiAgjRue8Ng==
Received: by mail-ed1-f50.google.com with SMTP id g10so39350180edj.1
 for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2021 12:23:04 -0700 (PDT)
X-Gm-Message-State: AOAM531Kn1wIIaGCJvvQ3j0QefcpIgxsQA1QCtCZZSOo2FdeKQ70siqG
 5O/vLrXdXT2a+Nf+C0Zg4JZyeDxH2LhZ7rtO1g==
X-Google-Smtp-Source: ABdhPJxr7vbwJkVU68Z/WBrwgn3iBRzg21K4k9yDQrYFJDFFABiWOPU2nd41CzNLw9EUzaKIPjJsRp/+6QDJwN43BCk=
X-Received: by 2002:a17:906:9399:: with SMTP id
 l25mr6294212ejx.363.1633720983371; 
 Fri, 08 Oct 2021 12:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211006113950.10782-1-srinivas.kandagatla@linaro.org>
 <20211006113950.10782-9-srinivas.kandagatla@linaro.org>
 <1633547293.527218.2218062.nullmailer@robh.at.kernel.org>
 <4e70e1e3-162e-13c0-5cbd-0135d2585e96@linaro.org>
In-Reply-To: <4e70e1e3-162e-13c0-5cbd-0135d2585e96@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Oct 2021 14:22:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6ankPjqXO9jghPQ7y7FHFM-8K-pyPHeE8oNa98eeauQ@mail.gmail.com>
Message-ID: <CAL_JsqK6ankPjqXO9jghPQ7y7FHFM-8K-pyPHeE8oNa98eeauQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/17] ASoC: dt-bindings: add q6apm digital audio
 stream bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Thu, Oct 7, 2021 at 3:23 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 06/10/2021 20:08, Rob Herring wrote:
> > On Wed, 06 Oct 2021 12:39:41 +0100, Srinivas Kandagatla wrote:
> >> On AudioReach audio Framework, Audio Streams (PCM/Compressed) are managed by
> >> Q6APM(Audio Process Manager) service. This patch adds bindings for this DAIs
> >> exposed by the DSP.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> ---
> >>   .../bindings/sound/qcom,q6apm-dai.yaml        | 53 +++++++++++++++++++
> >>   1 file changed, 53 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/sound/qcom,q6apm-dai.example.dts:19:18: fatal error: dt-bindings/soc/qcom,gpr.h: No such file or directory
> >     19 |         #include <dt-bindings/soc/qcom,gpr.h>
>
> This is because QCOM SoC relevant non-audio patches in this series have
> been merged into the Qualcomm drivers-for-5.16 tree, as this series
> depends those patches an immutable tag is available at:
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> tags/20210927135559.738-6-srinivas.kandagatla@linaro.org
>
> which is mentioned in cover-letter.

My bot doesn't know how to read cover letters. I need a clue in the
patch or you get this email to be sure the dependency is known.

Rob
