From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: I2C controller vs. WM8903 suspend ordering
Date: Wed, 3 Aug 2011 08:46:23 +0900
Message-ID: <20110802234622.GA30717@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049EEAB155@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 224CD1038A6
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 08:52:12 +0200 (CEST)
Content-Disposition: inline
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2011 at 11:34:18AM -0700, Stephen Warren wrote:

> We've found that switching the Tegra I2C controller from struct
> platform_driver.{suspend,resume} to .{suspend,resume}_noirq solves this.
> However, this seems like it's more of an accident than registering an
> explicit dependency, especially since most I2C controllers just use
> suspend rather than suspend_noirq.

This is about as good as it gets, actually - I2C controllers should
generally suspend very late and resume early as they're needed for core
system components like the RTC and PMIC.

> Is there a way to explicitly indicate that sound should be suspended before
> the I2C controller? I assume the issue is more that snd_soc_suspend shuts

No, this is a general limitation in the Linux PM model.  Everything goes
by the order that devices got registered in.  There's nothing doing at
the minute without core work other than bodges like _noirq.
