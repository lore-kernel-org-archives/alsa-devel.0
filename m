From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 07/10] ASoC: Intel: Skylake: Disable
 notifications at boot after DSP FW init
Date: Thu, 9 Mar 2017 11:47:45 +0530
Message-ID: <20170309061745.GR2843@localhost>
References: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
 <1488910446-26415-8-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 540F72671A3
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 07:16:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1488910446-26415-8-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 07, 2017 at 11:44:03PM +0530, jeeja.kp@intel.com wrote:
> From: G Kranthi <gudishax.kranthikumar@intel.com>
> 
> DSP firmware sends notification every 1m, which is disabled in runtime

I think you mean 1ms, right?

-- 
~Vinod
