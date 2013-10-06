From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Sun, 06 Oct 2013 19:10:59 +0300
Message-ID: <1381075859.3245.31.camel@laptop>
References: <20131003181754.GE27287@sirena.org.uk>
 <524F34FD.8090404@linux.intel.com>
Reply-To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 83475261A2B
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 18:11:03 +0200 (CEST)
In-Reply-To: <524F34FD.8090404@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@intel.com>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-10-04 at 16:37 -0500, Pierre-Louis Bossart wrote:
> >   - Effects offload to DSPs with dynamically instantiatable algorithms,
> >     and general dynamic DSP firmware handling.
> 
> I can try and prepare an overview about what we've started to look at 
> for effect offload. The one thing that's missing from the agenda is that 
> DSP offload and dynamic firmware handling do require control on audio 
> policy (high level arbitration between use cases), audio routing (some 
> paths may not be available at all times) and resource management 
> (memory/MCPS/etc). We not be able to solve this in a generic manner but 
> having hooks to detect/notify a DSP resource is or is not available 
> might be a good thing.

Perhaps I should present our (Murphy[1] team at Intel) plans for the
routing infrastructure and policy in PulseAudio? It might be relevant
for this, although effect offloading and firmware handling is not
something that we have thought about. Even without effect offloading and
firmware handling the routing system has to deal with use case
prioritizing and constraints regarding what audio paths are available
and what paths can be used simultaneously.

BTW, there will also be a Murphy meeting/BoF on Wednesday at 13:00 in
the Dunvegan room at the Sheraton hotel next to the conference center.
Anyone who's interested in Murphy is welcome to attend. I'd expect there
to be a general overview of Murphy from Janos, and I should present the
status and plans for the routing work in PulseAudio (perhaps in more
detail than in the audio miniconf). Other than that, there's not much
else planned, just general Q&A with the Murphy developers (Janos Kovacs
and Jaska Uimonen will be present - too bad they couldn't make it to the
audio miniconf).

[1] Murphy is the resource policy daemon in Tizen IVI,
https://01.org/murphy/

-- 
Tanu
