From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/10] ASoC: Intel: Skylake: Fix to delete
 DSP pipe after stopping pipe
Date: Thu, 9 Mar 2017 11:47:04 +0530
Message-ID: <20170309061704.GQ2843@localhost>
References: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
 <1488910446-26415-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DB655267028
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 07:16:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1488910446-26415-2-git-send-email-jeeja.kp@intel.com>
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

On Tue, Mar 07, 2017 at 11:43:57PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> DSP pipe needs to stopped before deleting the pipe. Currently check is
 needs to be ...

> is for pipe state > STARTED, which is incorrect. So changed to include

double is, please fix. Otherwise looks good to me.

-- 
~Vinod
