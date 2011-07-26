From: Stephen Warren <swarren@nvidia.com>
Subject: Rename Tegra support to Tegra20?
Date: Tue, 26 Jul 2011 15:38:25 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF989@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 71FFE1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 00:40:32 +0200 (CEST)
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

The existing ASoC Tegra support is specifically for Tegra20. It turns out
that Tegra30 has pretty different hardware and requires different drivers.
A couple questions:

* The new drivers I've written use "tegra30" in Kconfig variable names,
filenames, symbol names, etc. Do you think it's a good idea to rename the
existing Tegra20 driver to basically s/tegra/tegra20/ everywhere so
everything is versioned, or do you think that's just unnecessary churn?
(My motivation is kinda like the device tree compatible properties always
being versioned)

* I assume there's little point my posting Tegra30 ASoC drivers for
inclusion in mainline, since there's no Tegra30 CPU support at all there
yet?

Thanks.

-- 
nvpublic
