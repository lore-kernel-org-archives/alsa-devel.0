From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Wed, 16 Oct 2013 20:28:30 +0200
Message-ID: <525EDACE.4050006@metafoo.de>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
 <20131016181057.GX2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-206.synserver.de (smtp-out-206.synserver.de
 [212.40.185.206])
 by alsa0.perex.cz (Postfix) with ESMTP id DF5E32651FF
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:26:26 +0200 (CEST)
In-Reply-To: <20131016181057.GX2443@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 08:10 PM, Mark Brown wrote:
> On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
>> Currently each platform making use the the generic dmaengine PCM driver still
>> needs to provide a custom snd_pcm_hardware struct which specifies the
>> capabilities of the DMA controller, e.g. the maximum period size that can be
>> supported. This patch adds code which uses the newly introduced
> 
> There was some discussion on this but it didn't seem terribly
> conclusive.  Are people happy with these?
> 

Was about to ask the same. I'm still happy with it.

- Lars
