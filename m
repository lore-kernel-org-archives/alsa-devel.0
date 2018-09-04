From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Tue, 4 Sep 2018 11:02:14 -0500
Message-ID: <5e7fdb87-651d-6056-9323-7a29573b6300@ti.com>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
 <20180904145503.GD12993@sirena.org.uk>
 <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
 <20180904155655.GJ12993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B5652676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 18:02:16 +0200 (CEST)
In-Reply-To: <20180904155655.GJ12993@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 09/04/2018 10:56 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 10:10:24AM -0500, Andrew F. Davis wrote:
>> On 09/04/2018 09:55 AM, Mark Brown wrote:
> 
>>> you get to keep the pieces" territory.  If we really want to have a way
>>> of explicitly specifying that some widgets should never be turned on
>>> then it feels like rather than have something device and widget specific
>>> like this we should instead have a higher level way of doing that which
>>> can be applied to any widget, that is something that could be useful
>>> especially with things like speaker drivers where there's real potential
>>> for physical damage to the system.
> 
>> Not sure how that could even look, it would need to be in DT as only
>> that layer knows the connections, but then the it would also have to
>> have internal knowledge of the widgets used in the driver..
> 
> We already have a bunch of DT code that knows about and uses the
> external widgets the device has (which are I'd guess the only ones where
> this is an issue)?  I was thinking just have a property that lists the
> widgets that should never be turned on.
> 
>>> Like I said in my original reply I'm also worried that this will break
>>> existing boards by causing them to change to a voltage of 0 when they
>>> had managed to end up with the default of 2V which happened to work for
>>> them.
> 
>> Then only time this could happen is if they specified MICBIAS_OFF in DT
>> but got the default 2v instead. In which case, yes, the behavior would
>> change, but it would also be changing to the correct behavior. We can't
>> avoid fixing code on the off chance someone depended on the broken
>> behavior, no progress could ever be made.
> 
> I'm really having a lot of trouble seeing MICBIAS_OFF as a useful
> voltage to specify in DT in the first place.
> 

I don't see the usefulness in specifying any bias voltage in DT at all,
it is a configuration and can be made at runtime, it has no place in DT.
But it is already here, so lets allow all available voltages a board may
need and the CODEC can supply, even 0.
