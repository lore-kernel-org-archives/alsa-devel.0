From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 19 Mar 2015 09:15:59 +0000
Message-ID: <1426756559.7258.22.camel@loki>
References: <5509D4D4.6030000@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EDB4D260417
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 10:16:26 +0100 (CET)
In-Reply-To: <5509D4D4.6030000@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-03-18 at 21:41 +0200, Tanu Kaskinen wrote:
> Hi Liam and alsa-devel,
> 

I've added a few others on the CC that would be interested.

> My understanding is that a UCM device can represent a thing that has 
> both input and output (I don't particularly like that, but it's too late 
> to complain). 

Yes, but it can also represent simplex devices too e.g.
"Headset-Speakers" and "Headset-Mic". There are not any hard rules here,
but most examples are using duplex devices as historically UCM came from
the phone ecosystem use cases.

> How likely do you think that there are or there will be 
> some drivers that expose separate input and output jack kcontrols for a 
> headset jack, to differentiate between headphones/headset/microphone? My 
> understanding is that jack kcontrols store only booleans, so there's no 
> way to distinguish between headphones and a headset with just one kcontrol.
> 

This sounds like we need to extend the jack kcontrol so that we can
differentiate between Headphones and Headset unless the kcontrol naming
was intended to differentiate and define the jack type ?

> The current UCM "spec" doesn't support specifying multiple kcontrols, 
> since there's only one "JackControl" value. (Perhaps the "JackDev" value 
> suffers from this problem too, but I don't know if jack input devices 
> already support reporting the state separately for input and output.)
> 

I think in this case we could define simplex UCM devices and attach a
JackControl value to each device.

Btw, I'm assuming it's better for pulseaudio to map the UCM devices as
simplex unidirectional devices ?

Liam
