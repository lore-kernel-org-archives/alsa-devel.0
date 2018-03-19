From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Program pin-port-mux
 during jack report event
Date: Mon, 19 Mar 2018 17:32:38 +0530
Message-ID: <20180319120238.GP15443@localhost>
References: <20180201030650.29580-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 62EBF26731A
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 12:58:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180201030650.29580-1-guneshwor.o.singh@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 01, 2018 at 08:36:50AM +0530, Guneshwor Singh wrote:
> From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> 
> During d3/d0 cycle, the connection selection index of all pins points
> to the default value. This needs to be restored to ensure audio is
> restored after d3/d0 cycle.
> 
> So store the connection selection index and program it during jack
> report event which gets invoked in cases like d3/d0 cycle, hot plug
> detection when multiple displays are connected.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
