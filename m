From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 3/4] ASoC: wm_adsp: Use new
 snd_compr_stop_error to signal stream failure
Date: Wed, 20 Apr 2016 18:39:38 +0530
Message-ID: <20160420130938.GZ2274@localhost>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461156003-24422-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id F102F266591
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 15:05:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1461156003-24422-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2016 at 01:40:02PM +0100, Charles Keepax wrote:
> If we encounter a fatal error on the compressed stream call the new
> snd_compr_stop_error to shutdown the stream and allow the core to
> inform user-space that the stream is no longer valid.

Reviewed-by: Vinod Koul <vinod.koul@intel.com>


-- 
~Vinod
