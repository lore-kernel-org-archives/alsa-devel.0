From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt298: disable IRQ when jack is NULL
Date: Mon, 28 Nov 2016 21:25:47 +0530
Message-ID: <20161128155547.GJ6408@localhost>
References: <1480310646-16354-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B5B266E65
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:46:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1480310646-16354-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 01:24:06PM +0800, Bard Liao wrote:
> Disable IRQ when jack is NULL in rt298_mic_detect. So machine driver
> can use it in suspend/resume.

Reviewed-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
