From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Avoid recalculating the bitmask for
 SOC_ENUM controls
Date: Tue, 18 Sep 2012 22:51:14 -0400
Message-ID: <20120919025112.GJ8832@opensource.wolfsonmicro.com>
References: <1347623847-25287-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 215B426514A
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:51:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347623847-25287-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 01:57:27PM +0200, Lars-Peter Clausen wrote:
> For ENUM controls the bitmask is calculated based on the number of items.
> Currently this is done each time the control is accessed. And while the
> performance impact of this should be negligible we can easily do better. The
> roundup_pow_of_two macro performs the same calculation which is currently done
> manually, but it is also possible to use this macro with compile time constants
> and so it can be used to initialize static data. So we can use it to initialize
> the mask field of a ENUM control during its declaration.

Applied, thanks.
