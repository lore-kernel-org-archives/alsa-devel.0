From: Liam Girdwood <lrg@ti.com>
Subject: Re: I2C controller vs. WM8903 suspend ordering
Date: Tue, 2 Aug 2011 22:22:12 +0100
Message-ID: <4E386A84.8010800@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049EEAB155@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CCA51038E1
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 23:22:20 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EEAB155@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 02/08/11 19:34, Stephen Warren wrote:
> Mark, Liam,
> 
> We're facing a suspend ordering issue on Tegra, when playing audio when
> suspend is initiated. Specifically, the I2C controller to which the WM8903
> codec is attached is suspended before snd_soc_suspend is executed. This
> then prevents any I2C register accesses during snd_soc_suspend, so various
> analog paths are left active within the WM8903 during suspend, and this
> causes a pop noise during resume.
> 
> (For reference, this is in the chromeos-2.6.38 kernel, with ASoC back-
> ported from a point prior to 2.6.39)
> 
> We've found that switching the Tegra I2C controller from struct
> platform_driver.{suspend,resume} to .{suspend,resume}_noirq solves this.
> However, this seems like it's more of an accident than registering an
> explicit dependency, especially since most I2C controllers just use
> suspend rather than suspend_noirq.
> 
> Is there a way to explicitly indicate that sound should be suspended before
> the I2C controller? I assume the issue is more that snd_soc_suspend shuts
> down various DAPM paths, which can't actually program the HW for this when
> this happens after I2C is shut down, rather than just the I2C controller
> being suspended before the WM8903 driver itself (which I assume doesn't
> happen, but didn't check).
> 
> Thanks for any pointers!
> 

IIRC, with stand alone I2C devices the child will suspend before it's parent I2C controller (due to registration order).

Now I think in this case we may not have such a direct relationship between the I2C controller and the soc audio device and thus we dont know how to order the suspend correctly.

Your fix just re-orders the calls wrt the I2C controller (PM has a call sequence described in it's kernel docs) so at least we have something that now "works" but is maybe not ideal. It maybe better if we change the soc PM DAPM shutdown to be called before PM suspend (e.g. move to PM prepare()) thus guaranteeing the I2C controller is alive when we do the DAPM calls. 

Could you take a look into this.

Thanks

Liam
