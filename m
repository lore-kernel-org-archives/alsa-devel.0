From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/5] ASoC: sn95031: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 20:44:45 +0530
Message-ID: <20150113151445.GF3085@intel.com>
References: <1420901048-5756-1-git-send-email-lars@metafoo.de>
 <1420901048-5756-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C1848260434
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 16:17:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1420901048-5756-5-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 10, 2015 at 03:44:08PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.
> 
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
