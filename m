Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E30C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 27 May 2022 19:06:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C22F17BC;
	Fri, 27 May 2022 21:06:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C22F17BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653678411;
	bh=xy2v0UW9OxkQlEpRbg1MC88ziJi3bs138+XfVpOrkC8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfeD+S72YDgwnqNrDe6R8YcsPw1GqdxK44HHfs01vNk7fXLDb1LA1r0s4uNoKqvlC
	 FZdtks05X3iQkb31aS3VrrnR3RMEfRhbLBiMwolfL4OCTfCopNPGlKxKxIIeI6fnC+
	 39t3ckOu7MPwsRxKGraHaH2pjI4MaLT+70LPeNRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11292F801D8;
	Fri, 27 May 2022 21:06:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6047EF802DB; Fri, 27 May 2022 21:05:59 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E60C2F80100
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2022 21:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E60C2F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="mmjaRwBZ"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nfraprado) with ESMTPSA id 6F81D1F464B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1653678348;
 bh=xy2v0UW9OxkQlEpRbg1MC88ziJi3bs138+XfVpOrkC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mmjaRwBZTXfnPJGc8bg4toaoo7Nyy0vzqi4EoQOeXyw9L35qvzztiaTKc8D+3NEUo
 kayJ4EY33oK3oAtrBrOS3xa++5ygl8StkJe0nOsqV/dlMCv6kE7PzCWHRFLNnJzgso
 8GoqNYPkUfFT7ERTn3CO/vwimAsB3k6g/JBpKfALGev0HUY3dP3wUid8ss7xdZvham
 py+/vV1fyzp7V/dx21pD7ADBHmbgZdS05Ve6cgbkDn8SLaeo+rWBgX7DaMKlyNsj4q
 Vii7d9CB0XHlSckHEZBCSUBzrJfH82zot9PVCF+ZLll5iy2uzMFYbHnI0hxOQ4YXXX
 nsKgtruVhfFNg==
Date: Fri, 27 May 2022 15:05:42 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <20220527190542.4jckyflvtkq4n7ie@notapiano>
References: <20220509205847.607076-1-nfraprado@collabora.com>
 <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Shane Chien <shane.chien@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Thu, May 26, 2022 at 08:49:39AM +0200, Krzysztof Kozlowski wrote:
> On 09/05/2022 22:58, Nícolas F. R. A. Prado wrote:
> > The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
> > share the same clock and act as a single interface with both input and
> > output. Add patterns for these properties in the dt-binding. The
> > property is split into two patterns in order to allow all valid
> > interface pairings.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > The series from v1 of this patch was merged although some changes were
> > still needed in this patch, so the v1 of this patch was reverted [1] and
> > this standalone commit addresses the feedback from v1 and readds the
> > property.
> > 
> > [1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com
> > 
> > v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/
> > 
> > Changes in v2:
> > - Added "mediatek," prefix to property
> > - Rewrote and added more information to property description
> > - Split into two patterns to validate that output-input pairings are
> >   done
> > 
> >  .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > index 7a25bc9b8060..2abf43c6c2c3 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > @@ -54,6 +54,22 @@ properties:
> >        - const: aud_infra_clk
> >        - const: aud_infra_26m_clk
> >  
> > +patternProperties:
> > +  "^mediatek,i2s[13579]-share$":
> > +    description:
> > +      Each I2S interface has a single data line, input if its index is even or
> > +      output if the index is odd. An input and an output I2S interface can be
> > +      used together as if they were a single I2S interface with both input and
> > +      output data lines by sharing the same clock. This property represents this
> > +      pairing. The value should be the name of the interface whose clock is
> > +      used, and the property name the other interface that depends on this
> > +      clock.
> > +    pattern: "^I2S[0268]$"
> > +
> > +  "^mediatek,i2s[0268]-share$":
> > +    description: Same as above.
> > +    pattern: "^I2S[13579]$"
> 
> Rob's question is still valid - why these are not phandles?

So, instead of having

	i2s9-share = "I2S8";

on the DT, you want us to have something like this:

        afe_i2s8: mediatek,i2s8 { };

        mediatek,i2s9 {
          mediatek,share-clock = <&afe_i2s8>;
        };

Or do you mean something else?

It seems like a lot more syntax to express the same thing (and the empty node
seems awkward), but if that's the DT way, I can change it no problem.

> 
> In any case you miss $ref.

Indeed, sorry, I'll add it in next version.

Thanks,
Nícolas
