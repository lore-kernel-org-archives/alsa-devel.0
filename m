From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Fri, 12 Aug 2016 11:33:13 +0200
Message-ID: <c8b124b3-68fa-8dc3-37cb-451897822b66@metafoo.de>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
 <20160809112639.GJ10383@sirena.org.uk>
 <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
 <20160810111748.GI9347@sirena.org.uk>
 <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
 <5a3d865f-087f-eab2-82d8-0477c2ca1400@metafoo.de>
 <87wpjmrdgw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B630C2673E3
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 11:33:21 +0200 (CEST)
In-Reply-To: <87wpjmrdgw.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 08/12/2016 03:27 AM, Kuninori Morimoto wrote:
[...]
>>> According to your (and Lars ?) idea, if component includes all features,
>>> then, current "codec" will be "component", and "platform" will be "component" too (?).
>>> If so, I think necessary patch in final stage is like this ?
>>>
>>> 	- static struct snd_soc_codec_driver xxxx = {
>>> 	+ static struct snd_soc_component_driver xxxx = {
>>
>> In the long run probably yes, with the distinction of particular features
>> happening at a different level. E.g. like I pointed out in one of the
>> earlier e-mails, one such layer could be the domain and bridge layer were a
>> component is subdivided into domains and bridges.
> 
> If my understanding was correct,
> current CPU/Codec/Platform will merged and goes to your "component" position.
> current snd_soc_dai will be cleanuped and goes to your "bridge" position.
> Are these correct ?

The domain+bridge concept is currently just an idea, it still needs somebody
to implement it before it becomes reality.

> But I wonder current which portion is the "domain" position ?
> ("domain" + "bridge" = current snd_soc_dai ?)
> Or we don't have such position at this point ?

At the moment there is nothing that translates well to the domain+bridge
concept since we only have single domain, so all components and functional
blocks all run in the same domain and there are no bridges.

> 
> BTW, I would like to replace below as next challenge.
> These are easy, and necessary.
> 	snd_soc_write()		-> snd_soc_component_write()
> 	snd_soc_update_bits()	-> snd_soc_component_update_bits()
> 
> This is a little bit difficult, but I can do is step-by-step.
> 	snd_soc_read()		-> snd_soc_component_read()

How do you want to replace them?

snd_soc_read() is placed at the CODEC layer and snd_soc_component_read() is
placed at the component layer. As long as the driver is a CODEC driver
(using snd_soc_register_codec()) it is OK that it uses snd_soc_read() and
similar. Using snd_soc_component_read() on the other hand would introduce
some slight boilerplate code, since the driver now has to cast from
snd_soc_codec to snd_soc_component.

snd_soc_read() and similar are part of a clear hierarchy and are not part of
the current problem. Removing them is not a priority and changing them to
snd_soc_component_read() should only be done where it makes sense (driver is
a component driver and uses snd_soc_register_component()).

The problems are where we break the hierarchy, e.g. the codec point in
snd_soc_component. This is something we should try to work towards removing
and fixing if we can.

> 
> If above were OK, some codec driver can use component side .probe/.remove
> I think Lars's opinion is that this should be final stage,
> but I think we can do this as parallel, and I like step-by-step approach.
> Of course I can skip it if you have strong objection.

I think we should wait with this until a driver is a component driver (uses
snd_soc_register_component). E.g. have a look at this commit [1] for a good
example where it makes sense to do the conversion.

[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=04b5cbd80af899c6a4d51835b069b96ae8864e5a

> So please let me know.
> I will have summer vacation from tomorrow, so I can start it after that.

Enjoy your vacation.
