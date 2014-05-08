From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Thu, 08 May 2014 09:05:01 +0200
Message-ID: <536B2C9D.9040807@metafoo.de>
References: <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
 <20140507172113.GI22111@sirena.org.uk> <536A7161.7090100@metafoo.de>
 <20140507180705.GJ22111@sirena.org.uk> <536A798E.6010408@metafoo.de>
 <20140507194947.GL22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 862AE2654AE
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 09:05:05 +0200 (CEST)
In-Reply-To: <20140507194947.GL22111@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/07/2014 09:49 PM, Mark Brown wrote:
> On Wed, May 07, 2014 at 08:21:02PM +0200, Lars-Peter Clausen wrote:
>> On 05/07/2014 08:07 PM, Mark Brown wrote:
>
>>> What you just described is what I'd consider a virtual control - I don't
>>> consider the fact that the put callbacks end up writing to the hardware
>>> particularly substantial, as far as the framework is concerned some
>>> driver specific thing goes off and does something but it could be
>>> setting a variable just as well as writing to hardware.
>
>> Ok, but we have controls that have virtual in their name, so I think it
>> should be made clear that you are not talking about those.
>
> My first thought would be to extend those so we have callbacks when
> required, to be honest I'd forgotten they weren't there already.

But that's just the normal ..._EXT() controls with custom put/get handlers.

Having virtual controls with custom put/get handlers makes no sense, since 
the virtual controls already have put/get function in which virtual-ness of 
the control is implemented.

>
>> I think the drivers you are thinking of are those which had physical
>> register which were backed by hardware and virtual register which were
>> backed by software. For the later we introduced the virtual controls, so
>> that such hacks are no longer necessary in driver. But in the case of the
>> RT286 all the register all still backed by hardware except that the way they
>> are accessed is not very uniform (different types of registers use a
>> different message format, there is a asymmetry between reading and writing
>
> Right, to me that's not actually a register map at all since it's
> missing so many of the assumptions that back up register maps.
>

Well there is a register map, there is just no linear address space. It's 
more hierarchical, but you can still map that hierarchical addressing scheme 
to a linear one. I think what best describes HDA is object oriented RPC. You 
have your objects, called nodes, each node has a unique identifier, called 
the node ID (NID). Then you have functions, called verbs, each verb has a 
specific ID. A node can support a certain set of verbs. And each verb has a 
verb specific payload, which is the functions signature. Most of the verbs 
are some kind of read/write register functions.

E.g. you have the set amplifier gain verb, whose payload looks like:

bool output, bool input, bool left, bool right, int index, bool mute, int gain

output, input, left, right, index select for which amplifier to set the 
parameters and mute and gain are the parameters that should be set.

So the address of the register in which the amplifier gain is stored is the 
NID + It's a amplifier you want to access + whether it's a input or output 
amplifier + whether it's left or right amplifier + amplifier index. You can 
map that onto a linear address space and in the regmap read/write callback 
do the mapping to the appropriate verb payload layout.

>> the same data). In a sense this is similar to devices which have registers
>> with different sizes, we also support these with custom regmap callbacks.
>
> But those are only breaking that one assumption so they fit into the
> idea of a register map much more readily - it's really only the physical
> I/O code that actually notices anything, all the cache and other
> operations can carry on uninterrupted.
>

This is one of the reasons why I suggest using regmap. You probably still 
want caching, you probably still be able to sync the register cache, etc. If 
you don't use regmap you'd have to implement this on your own.
