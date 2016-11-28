From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: atom: Make some messages to
	debug level
Date: Mon, 28 Nov 2016 21:23:32 +0530
Message-ID: <20161128155331.GH6408@localhost>
References: <20161128152640.29566-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 911D3266E65
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:43:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161128152640.29566-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 04:26:40PM +0100, Takashi Iwai wrote:
> Intel sst driver spews lots of kernel messages in INFO level;
> typically, it gives a kernel message at each time it allocates or
> frees a stream, or at each time when a stream is started or stopped.
> This will piles up quickly, and it's almost useless for normal users,
> so let's hide them to KERN_DEBUG level.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
