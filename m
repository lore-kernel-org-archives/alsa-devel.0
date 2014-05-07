From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 07 May 2014 20:21:02 +0200
Message-ID: <536A798E.6010408@metafoo.de>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
 <20140507172113.GI22111@sirena.org.uk> <536A7161.7090100@metafoo.de>
 <20140507180705.GJ22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 174DC261AE7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 20:21:04 +0200 (CEST)
In-Reply-To: <20140507180705.GJ22111@sirena.org.uk>
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

On 05/07/2014 08:07 PM, Mark Brown wrote:
> On Wed, May 07, 2014 at 07:46:09PM +0200, Lars-Peter Clausen wrote:
>
>> I don't think virtual controls are the right approach here. Virtual controls
>> are for controls where the state is completely in software, but here the
>> state is still in hardware. It's just that there is no uniform hardware map.
>> But there is still some structure. So you'd have controls with custom put
>> and get handlers and for DAPM widgets use the event handler.
>
> What you just described is what I'd consider a virtual control - I don't
> consider the fact that the put callbacks end up writing to the hardware
> particularly substantial, as far as the framework is concerned some
> driver specific thing goes off and does something but it could be
> setting a variable just as well as writing to hardware.

Ok, but we have controls that have virtual in their name, so I think it 
should be made clear that you are not talking about those.

>
>> But I still think that the best and easiest solution is to have custom
>> regmap read/write function that do the translation of logical registers to
>> physical read/write operations.
>
> That's the first time this idea has been mentioned that I recall.  I
> have to say I'm really not keen on pushing non-physical registers
> through regmap, all the drivers that have done that previously have
> ended up causing problems though if the registers were *all* fake then
> there would be less issue (most of the issues have been due to having
> extra registers that don't really exist).  It does still feel like it's
> a layering problem though.

I think the drivers you are thinking of are those which had physical 
register which were backed by hardware and virtual register which were 
backed by software. For the later we introduced the virtual controls, so 
that such hacks are no longer necessary in driver. But in the case of the 
RT286 all the register all still backed by hardware except that the way they 
are accessed is not very uniform (different types of registers use a 
different message format, there is a asymmetry between reading and writing 
the same data). In a sense this is similar to devices which have registers 
with different sizes, we also support these with custom regmap callbacks.

- Lars
