From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3 v5] ASoC: simple-card: add Device Tree
	support
Date: Wed, 13 Feb 2013 16:36:13 -0700
Message-ID: <511C236D.6060300@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87a9rjrrwt.wl%kuninori.morimoto.gx@renesas.com>
 <87zjzhymbs.wl%kuninori.morimoto.gx@renesas.com>
 <51196541.8010207@wwwdotorg.org>
 <874nhhf22h.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AD87D26163E
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 00:36:16 +0100 (CET)
In-Reply-To: <874nhhf22h.wl%kuninori.morimoto.gx@renesas.com>
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

On 02/12/2013 06:13 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
>>> +- simple-audio,[prefix],bitclock-inversion	: if CPU/CODEC needs clock inversion
>>> +- simple-audio,[prefix],frame-inversion		: if CPU/CODEC needs frame inversion
>>> +- simple-audio,[prefix],system-clock-frequency	: system clock rate for each CPU/CODEC
>>
>> I know Mark had a preference to store DAI-specific data in sub-nodes
>> rather than using this "[prefix]" thing... If that doesn't end up
>> happening though, rather than "[prefix],", I think it'd be more typical
>> to use "[prefix]-" since I've never seen a DT property name with two
>> ","; "-" is typically used as the word separator in DT property names.
> 
> Hmm...
> If I can use sub-node, I can use below style for getting dai name ?
> I guess it is easy/simple, but, what do you think about this ?
> 
> sound {
> 	ak4642-hifi {

If you want the "simple-audio" binding and driver to be completely
generic, you had better name this node something generic like "codec".

> 		simple-audio,codec;

Then, you wouldn't need that property to identify what type of child
node this is.

> 		simple-audio,dev = <&ak4642>;

Make that value <&ak4642 0> in order to select which AK4642 port you
want to connect.

> 		...
> 	}
> 	fsia-dai {

Name this node something generic like "CPU".

> 		simple-audio,cpu;
> 		simple-audio,dev = <&sh_fsi2>;
> 		...
> 	}
> }
