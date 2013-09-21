From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: bells: Specify REFCLK for FLLs
Date: Sat, 21 Sep 2013 21:08:36 +0100
Message-ID: <20130921200836.GI3635@opensource.wolfsonmicro.com>
References: <1379758218-28580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130921132833.GU21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 098C7264F22
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2013 22:08:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130921132833.GU21013@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Ah... yeah sorry forgot that, have always had a crystal in my
board. Best just ignore this patch I guess we will just have to
not set a good example.

Thanks,
Charles

On Sat, Sep 21, 2013 at 02:28:33PM +0100, Mark Brown wrote:
> On Sat, Sep 21, 2013 at 11:10:18AM +0100, Charles Keepax wrote:
> > Wolfson recommends using a higher frequency REFCLK for best performance
> > rather than the default 32kHz reference clock source. We should set a
> > good example and do so.
> 
> The trick here is of course that MCLK1 is not guaranteed to be
> physically present on the board and there are a range of possible
> frequencies it could be set to...  I'm not sure I actually have any
> crystals.
