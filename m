From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: wm8971: Use
	system_power_efficient_wq	instead of custom workqueue
Date: Wed, 1 Apr 2015 12:52:21 +0100
Message-ID: <20150401115221.GB5442@opensource.wolfsonmicro.com>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DC7626518B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:52:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 30, 2015 at 09:04:45PM +0200, Lars-Peter Clausen wrote:
> The delayed work used by the wm8971 driver to manage the caps charging
> doesn't have any special requirements that would justify using a custom
> workqueue, just use the generic system_power_efficient_wq instead.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Whole series looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
