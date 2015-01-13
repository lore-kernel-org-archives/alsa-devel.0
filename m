From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 3/5] ASoC: da732x: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 15:39:02 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB527A03@SW-EX-MBX01.diasemi.com>
References: <1420901048-5756-1-git-send-email-lars@metafoo.de>
 <1420901048-5756-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 36B1F260448
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 16:39:04 +0100 (CET)
In-Reply-To: <1420901048-5756-3-git-send-email-lars@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On January 10, 2015 14:44, Lars-Peter Clausen wrote:

> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
