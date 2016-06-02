From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt298: remove idle_bias_off = true
Date: Thu, 2 Jun 2016 12:34:19 +0530
Message-ID: <20160602070419.GL16910@localhost>
References: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ECD7265747
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 08:57:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Patches Audio <patches.audio@intel.com>, lgirdwood@gmail.com, ramesh.babu@intel.com, broonie@kernel.org, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 02, 2016 at 02:51:52PM +0800, Bard Liao wrote:
> From: bardliao <bardliao@realtek.com>
> 
> Codec will not go into suspend if there is any widget forced on with
> idle_bias_off true. We want codec go into suspend when the system is
> suspend. Also, we don't do anything in bias level OFF case. So it is
> actually no different in bias level STANDBY or OFF case.

Tested-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Reveiwed-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
