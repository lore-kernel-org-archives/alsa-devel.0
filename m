Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7270C33CB1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:46:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D44A2064C
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sv7ZbccT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsTtnsoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D44A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EA67179F;
	Thu, 16 Jan 2020 13:45:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EA67179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579178801;
	bh=Pa3Hed+bpBb/RgkVTW2k0cDpCV8t3Kl64+M/RUE0OBk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sv7ZbccTpf2iinvssQ1c8POo/rxlu+iAQAcUuZ4HZqRGE/Ql9GFFZ2zLpt1w1nztm
	 oiWyoYwJAIlMlI014yRx0LnDxDGk6HMgJSvG9aDPOvEYieeg+IEU0K2olNYASnNRCr
	 JeS8S6T5H3MPISbi9hO9tPAd/MKp51B9XSXUdlak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C11FF8014E;
	Thu, 16 Jan 2020 13:45:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14ED2F8016F; Thu, 16 Jan 2020 13:45:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7984F8014D
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 13:45:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7984F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WsTtnsoD"
Received: from localhost (unknown [223.226.122.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8B082073A;
 Thu, 16 Jan 2020 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579176444;
 bh=NmJH2VsZS8uBAylZN1sbCVAnyGcjHMx6DMzTE4g3v6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WsTtnsoDB+3OeE14UNHJK/+eHhzJ+/RkzqfmGgV5HsnhzPd2W3Tqs8bWaPmZsGrng
 aUxiJ83WSe/i8N+mU35eZzbNp+2wtj7kL+JLU6rMEA63xjNhQcP2Dne8p706NxxumT
 8X8rO4X7BZR9r4TVryqHRJ6aGtLkhFzajw+gQ3uE=
Date: Thu, 16 Jan 2020 17:37:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20200116120720.GQ2818@vkoul-mobl>
References: <20200114094806.15846-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114094806.15846-1-srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] dt-bindings: soundwire: fix example
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

On 14-01-20, 09:48, Srinivas Kandagatla wrote:
> As wsa881x schema mentions #sound-dai-cells as required property,
> so update soundwire-controller.yaml example so that dt_bindings_check
> does not fail as below:
> 
> Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
> speaker@0,1: '#sound-dai-cells' is a required property
> Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
> speaker@0,2: '#sound-dai-cells' is a required property

Applied, thanks

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
