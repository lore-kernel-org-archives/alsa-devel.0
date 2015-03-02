From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/3] ASoC: da732x: Fix control-less DAPM
	routes
Date: Mon, 2 Mar 2015 10:36:40 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB53E946@SW-EX-MBX01.diasemi.com>
References: <1425042784-727-1-git-send-email-lars@metafoo.de>
 <1425042784-727-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 91747260599
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 11:36:42 +0100 (CET)
In-Reply-To: <1425042784-727-2-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On January 21, 2015 13:13, Lars-Peter Clausen wrote:

> Routes without a control must use NULL for the control name. The da732x
> driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
> ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
> the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
> routes. But starting with that commit it will complain and not add the
> route breaking the da732x driver in the process.
> 
> This patch replaces the incorrect "NULL" control name with NULL to fix the
> issue.
> 
> Fixes: 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non
> mixer/mux widgets")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
