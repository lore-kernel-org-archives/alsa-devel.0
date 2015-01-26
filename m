From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] dt: sound: jz4740: Add binding
 documentation for jz4740-i2s
Date: Mon, 26 Jan 2015 12:38:33 +0100
Message-ID: <54C62739.6090902@metafoo.de>
References: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1422267511-6649-3-git-send-email-Zubair.Kakakhel@imgtec.com>
 <54C618ED.1090909@metafoo.de> <54C625DE.7030500@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-156.synserver.de (smtp-out-156.synserver.de
 [212.40.185.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 09BB92604BB
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 12:38:35 +0100 (CET)
In-Reply-To: <54C625DE.7030500@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, tiwai@suse.de, perex@perex.cz
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/26/2015 12:32 PM, Zubair Lutfullah Kakakhel wrote:
>
> On 26/01/15 10:37, Lars-Peter Clausen wrote:
>> On 01/26/2015 11:18 AM, Zubair Lutfullah Kakakhel wrote:
>> [...]
>>> +Required properties:
>>> +- compatible : "ingenic,jz4740-i2s"
>>> +- reg : I2S registers location and length
>>> +- clocks : AIC and I2S PLL clock specifiers.
>>> +- clock-names: "aic" and "i2s"
>>
>> We also need a handle to the DMA channels. Currently the request ids are hardcoded in the driver, but that needs to go away once the driver starts to support multiple SoCs with different request lines.
>
> I know. I've left DMA until we push the jz4780-dma driver upstream and see how things fit..

It doesn't hurt to put it in the spec. It will be two DMA channels one for 
rx, one for tx. See for example 
Documentation/devicetree/bindings/sound/bcm2835-i2s.txt

- Lars
