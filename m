From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] ASoC: Intel: Skylake: Driver
 updates on DSP firmware
Date: Tue, 21 Feb 2017 10:35:48 -0800
Message-ID: <20170221183547.GA7397@vkoul-mobl.gar.corp.intel.com>
References: <1487351937-20517-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 019BB266A65
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 19:36:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1487351937-20517-1-git-send-email-jeeja.kp@intel.com>
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

On Fri, Feb 17, 2017 at 10:48:55PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> This patch series provides update on DSP firmware download by optimizing
> o updating the dsp register poll method to use accurate timeout.
> o optimizing ROM init retries.
> o saving the firmware/library context at boot and use this ctx for
> downloading the firmware to DSP memory.
> o cleanup to store the library manifest data
> o release the firmware in cleanup routine.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
