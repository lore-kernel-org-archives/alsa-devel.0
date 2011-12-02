From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/6] ASoC: Use table based control init for
	WM8903
Date: Fri, 2 Dec 2011 12:32:30 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDB0621@HQMAIL01.nvidia.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5834C103827
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 21:33:23 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Friday, December 02, 2011 12:28 PM:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

The series,

Tested-by: Stephen Warren <swarren@nvidia.com>

On Tegra Harmony, booted with and without device tree. Tested playback
to speakers and headphone. Tested volume adjustment and mute for speakers
and headphone. Tested recording from mic. Couldn't test suspend/resume
since it isn't supported on Tegra in mainline. Also tested headphone
and mic detection interrupts.

-- 
nvpublic
