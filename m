From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 09/30] ASoC: mfld_machine: Register jacks
 at the card level
Date: Wed, 4 Mar 2015 17:28:06 +0530
Message-ID: <20150304115806.GN2613@intel.com>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
 <1425461626-21103-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0B9265062
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 13:01:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1425461626-21103-10-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Yang A Fang <yang.a.fang@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2015 at 10:33:24AM +0100, Lars-Peter Clausen wrote:
> The jacks are card level elements so use snd_soc_card_jack_new() instead of
> snd_soc_jack_new() to register them.
> 
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
