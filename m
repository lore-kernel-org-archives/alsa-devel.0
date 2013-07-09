From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: AT91: DTS: sam9x5: add SSC DMA
	parameters
Date: Tue, 9 Jul 2013 10:27:53 +0200
Message-ID: <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-3-git-send-email-richard.genoud@gmail.com>
 <20130708150756.GL27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D7C265524
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 10:28:14 +0200 (CEST)
Received: by mail-ie0-f177.google.com with SMTP id aq17so11502299iec.8
 for <alsa-devel@alsa-project.org>; Tue, 09 Jul 2013 01:28:13 -0700 (PDT)
In-Reply-To: <20130708150756.GL27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/7/8 Mark Brown <broonie@kernel.org>:
> On Mon, Jul 08, 2013 at 03:29:50PM +0200, Richard Genoud wrote:
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi |    3 +++
>
> There was no binding document in your first patch - there should be one
> for any new DT bindings.
The dma binding is documented here
Documentation/devicetree/bindings/dma/atmel-dma.txt
But you're right, I shoud update
Documentation/devicetree/bindings/misc/atmel-ssc.txt.

Thanks



-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
