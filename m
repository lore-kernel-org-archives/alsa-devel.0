From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: wm8962: Hold a runtime PM
	reference while	handling interrupts
Date: Fri, 31 Jan 2014 15:48:38 +0000
Message-ID: <20140131154838.GA12183@opensource.wolfsonmicro.com>
References: <1391182201-29439-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3DFA2625E6
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:48:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1391182201-29439-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 31, 2014 at 03:29:58PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> If the device is runtime suspended then we can't interact with it as it
> may have been powered off and the register map will be in cache only
> mode.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

All look fine to me.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
