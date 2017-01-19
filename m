From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Remove ignore_suspend
 for WoV streams
Date: Thu, 19 Jan 2017 21:44:09 +0530
Message-ID: <20170119161409.GL3573@localhost>
References: <1484198285-16805-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 37EB0266CC1
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 17:14:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1484198285-16805-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, chintan.m.patel@intel.com, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2017 at 09:18:05PM -0800, Yong Zhi wrote:
> When Ref capture is used during S0IX, only the DSP pipelines
> are needed, thus remove the ignore_suspend for WoV streams so
> that DMA can be suspended, but keep them for WoV endpoints.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
