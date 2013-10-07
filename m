From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Mon, 07 Oct 2013 18:39:48 +0200
Message-ID: <5252E3D4.2020400@metafoo.de>
References: <20131003181754.GE27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-020.synserver.de (smtp-out-020.synserver.de
 [212.40.185.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C6CE265162
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 18:38:00 +0200 (CEST)
In-Reply-To: <20131003181754.GE27287@sirena.org.uk>
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
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/03/2013 08:17 PM, Mark Brown wrote:
> The audio mini-summit in Edinburgh is now less than a month away so it
> seems like a good time to start pulling together a schedule.  Looking at
> the topics people mentioned when filling out the registration form there
> were three major topics that people wanted to cover:
> 
>  - Compressed audio review: tinycompress, integration into userspace,
>    driver upstreaming.
> 
>  - UCM and other use case management status & review.
> 
>  - Effects offload to DSPs with dynamically instantiatable algorithms,
>    and general dynamic DSP firmware handling.
> 
> Plus a few things that only one or two people brought up:
> 
>  - Process stuff (the list, bug tracking and so on).
> 
>  - Some relatively specific hardware support topics:
>   - HDMI hotplug handling throughout the stack
>   - Mic status LED handling throughout the stack.
> 
>  - Code cleanups:
>   - Moving away from the custom ALSA device registration infrastructure.
>   - General code modernisation.
> 
>  - General routing control in userspace - UIs, automation.
> 
> The first question is if there is anything important that is missing
> from the above list - please speak up soon if there is!  It'd also be
> good to have volunteers to lead the discussions in each area.
> 

One thing I think that would be good to discuss, considering how often this
has come up over the last few months, is devicetree bindings for audio
devices. And what should and needs to be done on the framework side to
better support this.

- Lars
