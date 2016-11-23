From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: cht_bsw_rt5645: Fix leftover kmalloc
Date: Wed, 23 Nov 2016 09:14:28 +0530
Message-ID: <20161123034428.GC2698@localhost>
References: <20161122171108.27238-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E1D26695B
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 04:34:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161122171108.27238-1-tiwai@suse.de>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2016 at 06:11:08PM +0100, Takashi Iwai wrote:
> cht_bsw_rt5645 driver allocates the own codec_id string but doesn't
> release it.  For simplicity, put the string in cht_mc_private; then
> the string is allocated in a shot and released altogether.
> 

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
