From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Revert "ASoC: wm0010: Add
	missing	IRQF_ONESHOT"
Date: Tue, 7 Jul 2015 10:58:45 +0100
Message-ID: <20150707095845.GH16517@opensource.wolfsonmicro.com>
References: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CEDA26163C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 11:58:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1435843604.17967.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 02, 2015 at 09:26:44PM +0800, Axel Lin wrote:
> This reverts 58d468328646 ("ASoC: wm0010: Add missing IRQF_ONESHOT").
> 
> The coccinelle warnings is false positive because the original code does
> set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

For the whole series:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
