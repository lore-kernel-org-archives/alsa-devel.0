From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device
	Tree support
Date: Mon, 04 Feb 2013 15:23:49 -0700
Message-ID: <511034F5.3070809@wwwdotorg.org>
References: <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <20130131013500.GA4759@opensource.wolfsonmicro.com>
 <510AA551.30400@wwwdotorg.org>
 <20130131171158.GA15376@opensource.wolfsonmicro.com>
 <510AA720.9000904@wwwdotorg.org>
 <20130131172150.GC15376@opensource.wolfsonmicro.com>
 <87fw1g7q8g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id CFC4826508F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 23:23:52 +0100 (CET)
In-Reply-To: <87fw1g7q8g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/31/2013 06:54 PM, Kuninori Morimoto wrote:
> 
> Hi Mark, Stephen
> 
>>>> There's more attributes that we might want to configure on the
>>>> devices than just the actual DAI link.  Clocks for example.
>>
>>> Sure, but this binding is *simple*-audio, right. If the intent is to
>>> create some more general/all-encompassing binding structure, I'd want
>>> to think about it and review it in a different way.
>>
>> Right, but things like the clocks are basic enough.
> 
> I agree that "simple"-audio has "simple" settings.
> 
> But, there is a board which gets some data delay via external factor.
> Then, it needs special inversion, especially bit clock.
> Without this settings, that board can't get correct data.
> This is maybe special case, so,
> I need cpu/codec special settings as "option".

It seems extremely odd to me that the data delay would just happen to
end up meaning that inverting the clock works out to magically make
everything work.

Still, if there really is a use-case for this in otherwise simple audio
systems, then I guess specifying all the DAI properties in sub-nodes is
indeed to simplest/most-flexible way to go.
