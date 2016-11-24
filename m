From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Skylake: Don't use dma
 I2S config structure in kernel
Date: Thu, 24 Nov 2016 13:52:58 +0530
Message-ID: <20161124082258.GY2698@localhost>
References: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D8816266731
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 09:13:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2016 at 10:46:26PM +0530, jeeja.kp@intel.com wrote:
> From: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
> 
> I2S blob config structure can change between DSP copier module versions.
> We are not modifying these structures anyway and NHLT blobs specify them
> properly, so use the blob directly to send the dma_control ipc instead
> of using the predefined I2S blob config structure.

Both:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
