From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/7] ASoC: wm9713: Remove unused DAI ID
	defines
Date: Mon, 17 Oct 2016 11:49:56 +0100
Message-ID: <20161017104956.GD3207@localhost.localdomain>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
 <1476552777-1849-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 213E9266A34
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 12:49:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1476552777-1849-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 15, 2016 at 07:32:53PM +0200, Lars-Peter Clausen wrote:
> The DAI ID defines are back from the time when DAIs were referenced by a
> numerical ID. These days a string is used for matching instead and the
> defines are unused. The last user of these defines was removed in commit
> f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
> remove the defines as well.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
