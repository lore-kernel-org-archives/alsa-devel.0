From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Wed, 24 Aug 2011 06:53:33 +0200
Message-ID: <4E5483CD.6070808@canonical.com>
References: <4E53C32E.9020801@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 1FBB724506
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 06:53:33 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-08-23 17:51, Stephen Warren wrote:
> David Henningsson wrote at Tuesday, August 23, 2011 9:12 AM:
>> Since modern HDMI cards often have more than one output pin and thus
>> input device, we need to know which one has actually been plugged in.
>>
>> This patch adds a name hint that indicates which PCM device is connected
>> to which pin.
>>
>> To do that, the jack creation has been deferred to build_controls, i e,
>> after the PCM devices have been created.
>>
>> Would be great to have Stephen look through this patch quickly before
>> it's committed.

Thanks for the review!

> Structurally, I think this looks OK. The only question I have is the
> string format:
>
> "HDMI/DP (pcm %d)", pcmdev
>
> * Is there a 1:1 mapping between the internal pcmdev numbers and what
> alsa-lib presents to clients?

That's very much up to the configuration in alsa-lib, but I would say 
that alsa-lib in general does that, and especially for HDA.

> Thinking about ALSA device numbering, it's
> like "hw:1,3", so includes the card number too; should that be in the
> string?

The matchup against the card can be done both in sysfs, and using the 
card name, which is later prefixed to that string. The end result would 
be something like "HDA NVidia HDMI/DP (pcm 3)"

It's possible though, and somewhat simpler than matching against sysfs 
to add the card number as well.

> * Would it be better to make the string completely generic - i.e. not
> include "HDMI/DP", but rather something like "ALSA PCM %d", or even
> "ALSA PCM hw:%d,%d" so that the same format could be used for non-HDMI/
> DP PCMs in the future?

That would probably be bad, as there would be no way to distinguish 
between e g "Headphone" and "Headphone 2". This is a HDMI specific 
problem in general, as all analog outputs and inputs are at ,0 and SPDIF 
at ,1. (Although there might be exceptions, the "Independent HP" thing 
of the VIA drivers come to mind.)

Up to now, I believe the string in the name has been pretty arbitrarily. 
E g, I have "Headphone" on one machine and "HP Out" on another. Should 
we try to establish a format where various parameters can be added, it 
might be good to try something like ",name=value". Should we add card as 
well, the result would be e g: "HDA NVidia HDMI/DP,card=2,pcm=3"

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
