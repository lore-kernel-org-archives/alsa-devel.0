From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Tue, 29 May 2018 22:23:48 +0200
Message-ID: <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <20180529112447.GC23509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 34398267750
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 22:23:49 +0200 (CEST)
In-Reply-To: <20180529112447.GC23509@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 29, 2018 01:24 PM, Mark Brown wrote:
> On Mon, May 28, 2018 at 09:35:02PM +0200, Daniel Mack wrote:
>> The simple-card driver currently hard-codes the clk_id parameter in
>> snd_soc_dai_set_sysclk() to 0. Make this configrable for both CPU and
>> codec dai sub-nodes.
> 
>> This still has the limitation that only one clk_id can be configured, but it
>> should help some more platforms to use simple-card in favor to a more
>> specific machine driver.
> 
> If we want to get more complex usage of clocks in the DT we should be
> moving the CODECs over to using the standard clock bindings for this
> stuff rather than inventing custom ASoC clock bindings for it.  That way
> we don't have to deal with the pain of trying to join things up in the
> future.

This will get rather complex too though, because most codec and cpu dais 
can act as clock source xor clock consumer, depending on how the 
hardware is built. Would you want to represent everything, bit clocks, 
frame clocks, master clocks etc as clock nodes?

If that's the case, could you depict how the DT bindings should look 
like by example?


Thanks,
Daniel
