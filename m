From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Wed, 13 Nov 2013 14:39:15 +0530
Message-ID: <20131113090915.GT8834@intel.com>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
 <20131016181057.GX2443@sirena.org.uk> <525EDACE.4050006@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1051826084B
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 11:04:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <525EDACE.4050006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 16, 2013 at 08:28:30PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2013 08:10 PM, Mark Brown wrote:
> > On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
> >> Currently each platform making use the the generic dmaengine PCM driver still
> >> needs to provide a custom snd_pcm_hardware struct which specifies the
> >> capabilities of the DMA controller, e.g. the maximum period size that can be
> >> supported. This patch adds code which uses the newly introduced
> > 
> > There was some discussion on this but it didn't seem terribly
> > conclusive.  Are people happy with these?
> > 
> 
> Was about to ask the same. I'm still happy with it.
Me too, so
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
