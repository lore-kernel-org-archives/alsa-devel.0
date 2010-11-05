From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Fri, 05 Nov 2010 14:17:43 +0100
Message-ID: <4CD403F7.40004@ladisch.de>
References: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>	<4CCEE3FA.8040706@ladisch.de>
	<AANLkTinEWKjLX2eVABVVTXP=mZyb_hphh8N0OzoHETyD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1E8A6103959
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:15:56 +0100 (CET)
In-Reply-To: <AANLkTinEWKjLX2eVABVVTXP=mZyb_hphh8N0OzoHETyD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian Wisner-Carlson wrote:
>>> It allows for 4 balanced outputs, 8 unbalanced outputs, or any
>>> combination of balanced and unbalanced outputs. HOWEVER, it adds 4
>>> mixer controls and the code isn't very pretty.
>>
>> The controller can route any stereo pair to each DAC, so it would be a
>> good idea to have one global control that also affects this routing so
>> that, e.g., configuring the card for 4 outputs works correctly when
>> playing 4-channel data.
> 
> Currently, routing is set up by void oxygen_update_dac_routing(struct
> oxygen *chip) in oxygen_mixer.c.
> However,  it only allows for five different routing configurations,
> which it statically defines internally as int reg_values[5].
> Do you mind (ie, would you mind merging/using it) if I defined a new struct:
> struct oxygen_routing_table = {
> 	u8 channels;
> 	unsigned int dac0;
> 	unsigned int dac1;
> 	unsigned int dac2;
> 	unsigned int dac3;
> }
> that would be passed to oxygen_update_dac_routing() as a new field of
> struct oxygen? This would allow for
> arbitrary routing configurations for the dacs (needed to implement 4
> channel balanced output) and would
> not require many changes to the driver as a whole.

This would move the responsibility for the actual routing decisions from
this function into its callers.  However, both the stereo-upmixing and
the balanced-output controls affect the routing, so some code has to
handle the interdependencies.  At the moment, this function sets the
routing depending on the current channel count and the upmixing setting;
I think that the balanced-output setting is just a third such parameter.

Anyway, I'm just concerned about how the controls looks to the user, not
so much about its implementation, which can be changed later (if I
wanted to, and if I had the time).

I'd be happy to merge any code that handles four DACs.  Separate
controls for each DAC are OK too if, eventually, there are additional
controls for the routing, and if there is a userspace tool to manage
these settings together.

> Where should I define this struct? (ie, in what file?)

As an interface between the core driver and module-specific drivers,
oxygen.h.


Regards,
Clemens
