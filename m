From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Thu, 11 Aug 2016 19:44:03 +0200
Message-ID: <5a3d865f-087f-eab2-82d8-0477c2ca1400@metafoo.de>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
 <20160809112639.GJ10383@sirena.org.uk>
 <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
 <20160810111748.GI9347@sirena.org.uk>
 <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E438266D33
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 19:44:12 +0200 (CEST)
In-Reply-To: <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/11/2016 03:03 AM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
>> If something is only using the component interfaces except for things
>> like probe and remove then converting them to component interfaces makes
>> sense.  If it's still using CODEC interfaces for some bits then it's
>> less clear that this is a good idea.
>>
>>> But it seems your opinion is like this ?
>>>  - ASoC will care only "component" (same as my opinion)
>>>  - This "component" includes all features
>>>    (= Codec feature, CPU feature, Platform feature, etc)
>>
>> I think so, yes.  To me the goal is to avoid too much rigid
>> categorization of components so that we can handle devices that have
>> combinations of these features effectively without having to worry about
>> exactly what terminology we use to describe them.
> 
> Hmm... If my understand was correct, my concern is this.
> If we merged all (CPU/Codec/Platform/etc...) features into component,
> it will be big size, and almost all feature are not needed for almost all devices.
> And in the future, we will have new type of device which we never know yet today.
> In such case, more new feature (it is unnecessary for existing devices) will be
> added to component. Then it will be bigger and bigger and bigger...

I don't quite share this concern and would even say the opposite is true.
When ASoC was introduced the (embedded audio) world was a lot simpler. There
was a clear distinction between what a CODEC, what a CPU side component and
what a platform is. Each of them had distinct roles which were reflected in
the code base.

Over time the hardware landscape changed and the distinction feature wise
did become smaller between the different types of components. The CPU side
components started to take care of tasks that were previously only found in
CODECS and wise versa.

This lead to a lot of code duplication in ASoC since the same functionality
was now implemented multiple times. Is this where the original
componentization effort started. The goal of this effort was to introduce
the snd_soc_component struct as a common base for all types of components in
ASoC. This allowed us to remove a lot of duplicated code and also reduce
struct sizes by implementing a more strict hierarchy.

If you look at snd_soc_codec and snd_soc_platform today you'll see that most
of the additional fields in there are for supporting legacy features. These
will not be moved over into snd_soc_component but will be phased out over
time once there are no users anymore. If you look at the componetization
patches you'll see that as part of that process already a lot of fields that
were originally in these structs have been removed reducing the overall
memory consumption of ASoC.

There is no intention to make snd_soc_component bloated. If a new kind of
component gets introduced which as very distinct features that are not found
in other kinds of components we can introduce a new sub-struct of
snd_soc_component to model that type. But the current hardware trends are
going in a different direction, as silicon gets cheaper, individual
components cover a wider feature set and which features are used in a
particular instance are application and hardware design dependent.

> 
> My opinion is that "component" which will be base of new ASoC should keep simple and small.
> New "component" has "each connection", and "callback" for each necessary point,
> and very basic feature only (like format, channel, etc)
> And each device struct which is based on component can have detail information if it wants.
> But here, ASoC cares component only. If framework need to do something for detail
> things, it should be done by callback.

I fully agree with this. snd_soc_component should provide the basic feature
set that is required by all components.

> 
> This doesn't mean "categorization". Of course current CPU/Codec/Platform looks
> like one of them, but I would like to say it will be "helper".
> Current "Codec" specific operation can go to "codec struct" specific callback,
> and ASoC framework doesn't care about it, it just call generic callback.
> This means soc-core will have "component" related operation only,
> and new soc-codec.c will have codec related operation as callback, for example.
> 

Agreed again. But the change you were making in this patch series was
affecting the CODEC layer, not the component layer. The CODEC layer is a
layer that is abstracted on top of the component layer, but in this series
you were removing part of that abstraction.

>>> Anyway, I don't want to create new issue on ASoC.
>>> It seems we (or only me ?) still don't have cristal clear big-picture (?)
>>> If so, my previous patch-set might make new style switching difficult.
>>> Mark, because of this reasons, is it possible to remove my previous
>>> patch-set (= topic/codec-component) from your repository ?
>>> Incomplete big-patch-set will cause new trouble.
>>> I want to cleanup ASoC, but I want to do it under cristal clear agreement.
>>
>> I think that's a reasonable thing to do in general, I don't see a
>> particular need to revert it.  Like Lars said I probably wouldn't have
>> done it right now but you've done the work so I don't see any need to
>> revert it.
> 
> According to your (and Lars ?) idea, if component includes all features,
> then, current "codec" will be "component", and "platform" will be "component" too (?).
> If so, I think necessary patch in final stage is like this ?
> 
> 	- static struct snd_soc_codec_driver xxxx = {
> 	+ static struct snd_soc_component_driver xxxx = {

In the long run probably yes, with the distinction of particular features
happening at a different level. E.g. like I pointed out in one of the
earlier e-mails, one such layer could be the domain and bridge layer were a
component is subdivided into domains and bridges.
