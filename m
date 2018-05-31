From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Thu, 31 May 2018 22:03:59 +0200
Message-ID: <d5df3c6b-22ae-408b-5727-516fed648b2a@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <20180529112447.GC23509@sirena.org.uk>
 <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
 <20180531170240.GA29973@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B982267928
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 22:04:00 +0200 (CEST)
In-Reply-To: <20180531170240.GA29973@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Thursday, May 31, 2018 07:02 PM, Rob Herring wrote:
> On Tue, May 29, 2018 at 10:23:48PM +0200, Daniel Mack wrote:

>> If that's the case, could you depict how the DT bindings should look like by
>> example?
> 
> In clock providers, you just add #clock-cells. Then the consumer side
> defines 'clocks'. Which clock(s) comes from the dai is defined by the
> index in the 'clocks' property for that node.
> 
> Both ends can be providers, but who is active is determined by defining
> the actual connections with 'clocks'. Or perhaps you have both
> directions shown and there is some other means to select which one is
> active such as solving for who can provide the desired freq.

How about entities that are a clock producer and consume their clocks 
themselves? That's a rather typical thing for DAIs. Is that expressible 
in DT?


Thanks,
Daniel
