From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Thu, 31 May 2018 12:02:40 -0500
Message-ID: <20180531170240.GA29973@rob-hp-laptop>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <20180529112447.GC23509@sirena.org.uk>
 <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f194.google.com (mail-yb0-f194.google.com
 [209.85.213.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B63BC26795E
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 19:02:43 +0200 (CEST)
Received: by mail-yb0-f194.google.com with SMTP id r13-v6so7812726ybm.12
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 10:02:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 29, 2018 at 10:23:48PM +0200, Daniel Mack wrote:
> On Tuesday, May 29, 2018 01:24 PM, Mark Brown wrote:
> > On Mon, May 28, 2018 at 09:35:02PM +0200, Daniel Mack wrote:
> > > The simple-card driver currently hard-codes the clk_id parameter in
> > > snd_soc_dai_set_sysclk() to 0. Make this configrable for both CPU and
> > > codec dai sub-nodes.
> > 
> > > This still has the limitation that only one clk_id can be configured, but it
> > > should help some more platforms to use simple-card in favor to a more
> > > specific machine driver.
> > 
> > If we want to get more complex usage of clocks in the DT we should be
> > moving the CODECs over to using the standard clock bindings for this
> > stuff rather than inventing custom ASoC clock bindings for it.  That way
> > we don't have to deal with the pain of trying to join things up in the
> > future.
> 
> This will get rather complex too though, because most codec and cpu dais can
> act as clock source xor clock consumer, depending on how the hardware is
> built. Would you want to represent everything, bit clocks, frame clocks,
> master clocks etc as clock nodes?

I have no idea if you need all the clocks or not, but they certainly 
shouldn't be a node per clock. Rather the codec and/or cpu dai should be 
a clock provider and can provide N clocks.
 
> If that's the case, could you depict how the DT bindings should look like by
> example?

In clock providers, you just add #clock-cells. Then the consumer side 
defines 'clocks'. Which clock(s) comes from the dai is defined by the 
index in the 'clocks' property for that node.

Both ends can be providers, but who is active is determined by defining 
the actual connections with 'clocks'. Or perhaps you have both 
directions shown and there is some other means to select which one is 
active such as solving for who can provide the desired freq.

Hope that helps.

Rob
