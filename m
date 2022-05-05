Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE97EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  5 May 2022 02:15:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BCD6175C;
	Thu,  5 May 2022 04:14:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BCD6175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651716900;
	bh=03xKb0I5hVrM4a/WrMThNhrl+Req19Cfb9Wi1fu08xk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eqD0WA0V0QCdrCRoiS8kVddB0EN3e/eFA2IM0EQ93K9wTQ/v6WcyxCis5halFtdVF
	 rqRlCTDheubkqZzYShof8Jwkz0jcFWCg7lPrVrK5BesJm+8q7cVq+9kvxwGnpnfA0x
	 3Tud3ZeYQSG2RA329SVqw2o81za5Ne4sLgdln1X8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0E08F8016A;
	Thu,  5 May 2022 04:14:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD3C4F8016B; Thu,  5 May 2022 04:14:05 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9F88F800F0
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2022 04:13:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9F88F800F0
X-UUID: eaa920a7b9914c7fa8bde4e0efc6f109-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:6cfe91a2-dde4-4508-8ff0-da5df5c84a55, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:faefae9, CLOUDID:0dbc9ab2-56b5-4c9e-8d83-0070b288eb6a,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: eaa920a7b9914c7fa8bde4e0efc6f109-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1533016179; Thu, 05 May 2022 10:13:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 5 May 2022 10:13:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 10:13:41 +0800
Message-ID: <97d295bf950ea3dbccbcaa7f5a60ccc7bc0b1cab.camel@mediatek.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Rob Herring <robh@kernel.org>, "=?ISO-8859-1?Q?N=EDcolas?= F. R. A.	Prado"
 <nfraprado@collabora.com>
Date: Thu, 5 May 2022 10:13:42 +0800
In-Reply-To: <YnLkYKmJ0TJ8uyjC@robh.at.kernel.org>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-2-nfraprado@collabora.com>
 <YnLkYKmJ0TJ8uyjC@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Shane Chien <shane.chien@mediatek.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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

On Wed, 2022-05-04 at 15:38 -0500, Rob Herring wrote:
> On Fri, Apr 29, 2022 at 04:30:37PM -0400, Nícolas F. R. A. Prado
> wrote:
> > The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S
> > bus
> > between two busses. Add a pattern for these properties in the
> > dt-binding.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5
> > +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml
> > index 7a25bc9b8060..5b03c8dbf318 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > @@ -54,6 +54,11 @@ properties:
> >        - const: aud_infra_clk
> >        - const: aud_infra_26m_clk
> >  
> > +patternProperties:
> > +  "^i2s[0-35-9]-share$":
> > +    description: Name of the I2S bus that is shared with this bus
> > +    pattern: "^I2S[0-35-9]$"
> 
> Why not a phandle to the the other bus? That would be the DT way to
> do 
> it. But I'm not sure I really understand who is sharing what here.
> 
I can explain the usage of this property. The I2S interface of MT8192
only have 3 pins [bit clock/ frame clock/ data in(or out)]. So if we
want use them as normal I2S that has 4 pins [bit clock/ frame clock/
data in/ data out], we need to combine two MT8192 I2S interface to use.
But we need to specify whose clock they use. E.g. "i2s9-share =
"I2S8"".

> > +
> >  required:
> >    - compatible
> >    - interrupts
> > -- 
> > 2.36.0
> > 
> > 

