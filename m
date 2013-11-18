From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3] ASoC: Add support for BCM2835
Date: Mon, 18 Nov 2013 15:06:19 +0000
Message-ID: <20131118150619.GL30853@e106331-lin.cambridge.arm.com>
References: <5289F9DF.8060406@koalo.de>
 <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
 <528A232B.9070402@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 912D4260815
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 16:06:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <528A232B.9070402@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 18, 2013 at 02:24:43PM +0000, Lars-Peter Clausen wrote:
> On 11/18/2013 03:16 PM, Mark Rutland wrote:
> > 
> >> +static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
> >> +{
> >> +       uint32_t clkreg;
> > 
> > s/uint32_t/u32/ (and elsewhere...)
> 
> Please don't do that.
> 

I was under the impression that there was a preference for uXX types
over uintXX_t types, but the replies and Documentation/CodingStyle have
taught me otherwise.

Apologies for the confusion here.

Thanks,
Mark.
