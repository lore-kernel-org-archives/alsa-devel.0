From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: arizona: Use async writes
Date: Tue, 17 Dec 2013 11:26:52 +0000
Message-ID: <20131217112652.GA11138@opensource.wolfsonmicro.com>
References: <1386846461-32325-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52849260890
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 12:26:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1386846461-32325-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 12, 2013 at 11:07:38AM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Where possible write to the device asynchronously, allowing better
> performance when used with a bus like SPI which supports this by
> minimising the need to context switch back to the driver to get the
> next bit of data.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---

For patches 1 and 3:

Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>


And for all patches:

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>


Apologies for being a little slow getting onto this series was
having a long weekend :-)


Thanks,
Charles
