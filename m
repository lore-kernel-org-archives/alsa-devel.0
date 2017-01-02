From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/9] ASoC: Intel: Skylake: Driver updates
Date: Mon, 2 Jan 2017 15:31:11 +0530
Message-ID: <20170102100111.GV3573@localhost>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 32667266AF5
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 11:01:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
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

On Mon, Jan 02, 2017 at 12:44:27PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> This patch series includes driver updates for the handling scenarios 
> during System S0/S3 transitions when audio stream is stopped during
> system.
> o move DMA configuration in DSP Gateway Module widget event handler to
> ensure DMA is configured after resume. 
> o Enable SSP MLCK using Supply widget. This will ensure the MCLK is
> enabled when the widget is power on.
> o Check DMA decouple register state before coupling/decoupling the DMA.
> o In case of HDMI pass-through pipe, reset only the FE Pipe when stream
> in in XRUN state.
> o Resume the stream from HW renderer position.
> o HDMI Codec pin and converter state need to be restored when stream
> is resumed.

Full series:

Acked-by:  Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
