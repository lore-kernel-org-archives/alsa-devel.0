From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/6] ASoC: Intel: Skylake: Driver updates
	on DSP firmware
Date: Mon, 2 Jan 2017 14:38:16 +0530
Message-ID: <20170102090816.GU3573@localhost>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BCDE2666AD
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 10:08:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 02, 2017 at 09:50:01AM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> This patch series provides update on DSP firmware download by optimizing
> o updating the dsp register poll method to use accurate timeout.
> o optimizing ROM init retries.
> o saving the firmware/library context at boot and use this ctx for
> downloading the firmware to DSP memory.
> o cleanup to store the library manifest data
> o release the firmware in cleanup routine.


>  8 files changed, 137 insertions(+), 135 deletions(-)

Thanks for the nice cleanup and fixes. As evident from diffstat, only two
lines added.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
