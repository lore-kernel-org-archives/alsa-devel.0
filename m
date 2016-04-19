From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 4/4] ASoC: compress: Pass error out of
 soc_compr_pointer
Date: Tue, 19 Apr 2016 11:56:42 +0530
Message-ID: <20160419062642.GJ2274@localhost>
References: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1460457129-23281-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 39BFA265DB9
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 08:22:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460457129-23281-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On Tue, Apr 12, 2016 at 11:32:09AM +0100, Charles Keepax wrote:
> Both soc_compr_pointer and the platform driver pointer callback return
> ints but current soc_compr_pointer always returns 0. Update this so we
> return the actual value from the platform driver callback. This doesn't
> fix any issues simply makes the code more consistent.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
