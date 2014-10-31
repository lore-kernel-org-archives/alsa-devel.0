From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/14] ASoC: AC'97 driver cleanups
Date: Fri, 31 Oct 2014 10:35:01 +0000
Message-ID: <20141031103501.GL23178@opensource.wolfsonmicro.com>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09F30260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 11:35:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
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

On Thu, Oct 30, 2014 at 09:00:57PM +0100, Lars-Peter Clausen wrote:
> Hi,
> 
> This series does a few AC'97 driver cleanups in preparation of the
> conversion of the drivers to regmap. Most of the patches are quite trivial.
> 
> The last two patches remove the virtual registers from the wm9712 and wm9713
> drivers, which is a requirement for regmap conversion.
> 
> The last patch is the only one in this series that is a bit more complex.
> Currently the drivers have a open-coded implementation of shared controls
> which is replaced by the patch with the generic one from the ASoC core.
> Unfortunately this changes the controls that are exposed by the driver,
> instead of having a "Left HP Mixer ..." and a "Right HP Mixer ..." control
> for each mixer input there will only be a single "HP Mixer" control. This
> may or may not be considered breaking the userspace interface. If it is we
> need to take a different approach at removing the virtual register form the
> driver.
> 
> - Lars
> 
> Lars-Peter Clausen (14):
>   ASoC: ad1980: Remove unused header
>   ASoC: ad1980: Cleanup printk usage
>   ASoC: ad1980: Use table based control setup
>   ASoC: stac9766: Cleanup printk usage
>   ASoC: stac9766: Use table based control setup
>   ASoC: wm9705: Cleanup printk usage
>   ASoC: wm9705: Use table based control setup
>   ASoC: wm9712: Cleanup printk usage
>   ASoC: wm9712: Use table based control setup
>   ASoC: wm9713: Cleanup printk usage
>   ASoC: wm9713: Use table based control setup
>   ASoC: wm9713: Move driver state struct allocation to driver probe
>   ASoC: wm9713: Use virtual control instead of virtual register
>   ASoC: wm9712/wm9713: Use shared controls

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

For the Wolfson parts.

Thanks,
Charles
