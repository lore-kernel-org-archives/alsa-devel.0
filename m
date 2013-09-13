From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Fri, 13 Sep 2013 13:50:31 +0300
Message-ID: <5232EDF7.2010000@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
 <20130912110800.GI29403@sirena.org.uk>
 <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
 <20130912115626.GO29403@sirena.org.uk>
 <49bf24974af0ff34d2be7db97e04f2a9@kapsi.fi>
 <20130913103431.GG29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id AA0E62608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:50:35 +0200 (CEST)
In-Reply-To: <20130913103431.GG29403@sirena.org.uk>
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
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <oku@iki.fi>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 09/13/2013 01:34 PM, Mark Brown wrote:
> On Thu, Sep 12, 2013 at 03:10:12PM +0300, Jyri Sarha wrote:
>> On 2013-09-12 14:56, Mark Brown wrote:
>
>>> What exactly is the dma register location here - what hardware is being
>>> controlled?
>
>> They is the McASP-bus receive/transmit buffer data port addresses.
>> So those
>> are McASP entity specific properties that need to be passed to
>> DMA-engine.
>
> OK, and presumably this is just part of the main McASP register block
> and doesn't need to go into DT?
>

Not really. For instance on am33xx SoCs the MPU usually accesses McASP 
registers trough L4 interconnect, which is not accessible by DMA 
controller. For DMA controller the data port is also mapped trough L3 
bus to entirely different address and a simple register offset is not 
enough. Naturally this mapping may change SoC to SoC.

I have been working with OMAP family chips so long that I start think 
everybody would know their internal workings. Sorry about that.

Best regards,
Jyri
