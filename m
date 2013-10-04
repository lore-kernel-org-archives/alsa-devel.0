From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Fri, 04 Oct 2013 16:37:01 -0500
Message-ID: <524F34FD.8090404@linux.intel.com>
References: <20131003181754.GE27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9703B261640
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 23:37:12 +0200 (CEST)
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


>   - Effects offload to DSPs with dynamically instantiatable algorithms,
>     and general dynamic DSP firmware handling.

I can try and prepare an overview about what we've started to look at 
for effect offload. The one thing that's missing from the agenda is that 
DSP offload and dynamic firmware handling do require control on audio 
policy (high level arbitration between use cases), audio routing (some 
paths may not be available at all times) and resource management 
(memory/MCPS/etc). We not be able to solve this in a generic manner but 
having hooks to detect/notify a DSP resource is or is not available 
might be a good thing.
-Pierre
