From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Skylake: Request IRQ late
 only after all context are initialized
Date: Wed, 20 Dec 2017 10:58:11 +0530
Message-ID: <20171220052810.GB18649@localhost>
References: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 701C8266C0C
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 06:24:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, GuruprasadX <guruprasadx.pawse@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 18, 2017 at 10:46:49AM +0530, Guneshwor Singh wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> 
> Sometimes during boot, panic is observed at sst_dsp_shim_read_unlocked().
> This happens when interrupt occurs before the context is initialized. So
> move the irq initialization only after the context is initialized
> completely.

Both:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
