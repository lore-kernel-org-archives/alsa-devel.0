From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8523: Set bclk ratio for master
	mode
Date: Fri, 12 Jun 2015 16:37:34 +0100
Message-ID: <20150612153734.GJ32730@opensource.wolfsonmicro.com>
References: <1434117452-25223-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D11526048C
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 17:37:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1434117452-25223-1-git-send-email-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 12, 2015 at 03:57:32PM +0200, Julian Scheel wrote:
> When running in master mode the bclk divider must be configured to generate a
> sane bitclock. Pick the smallest fs multiplicator, which can hold all
> transmitted bits.
> 
> Signed-off-by: Julian Scheel <julian@jusst.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
