From: Stephen Warren <swarren@nvidia.com>
Subject: I2C controller vs. WM8903 suspend ordering
Date: Tue, 2 Aug 2011 11:34:18 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EEAB155@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A9B51038D5
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 20:34:32 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark, Liam,

We're facing a suspend ordering issue on Tegra, when playing audio when
suspend is initiated. Specifically, the I2C controller to which the WM8903
codec is attached is suspended before snd_soc_suspend is executed. This
then prevents any I2C register accesses during snd_soc_suspend, so various
analog paths are left active within the WM8903 during suspend, and this
causes a pop noise during resume.

(For reference, this is in the chromeos-2.6.38 kernel, with ASoC back-
ported from a point prior to 2.6.39)

We've found that switching the Tegra I2C controller from struct
platform_driver.{suspend,resume} to .{suspend,resume}_noirq solves this.
However, this seems like it's more of an accident than registering an
explicit dependency, especially since most I2C controllers just use
suspend rather than suspend_noirq.

Is there a way to explicitly indicate that sound should be suspended before
the I2C controller? I assume the issue is more that snd_soc_suspend shuts
down various DAPM paths, which can't actually program the HW for this when
this happens after I2C is shut down, rather than just the I2C controller
being suspended before the WM8903 driver itself (which I assume doesn't
happen, but didn't check).

Thanks for any pointers!

-- 
nvpublic
