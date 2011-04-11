From: Stephen Warren <swarren@nvidia.com>
Subject: ASoC mixer control names v.s. well-known "Master"
Date: Mon, 11 Apr 2011 12:34:23 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3C62@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id F3EF610384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:34:30 +0200 (CEST)
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
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

In ChromeOS, user-space attempts to manipulate controls with "well known
names" to control e.g. output volume. The names it uses are probably based
on Documentation/sound/alsa/ControlNames.txt, since the code was originally
written for x86 platforms that use those names.

Is that document relevant to ASoC, up-to-date, and binding on audio
drivers, or more of a de-facto FYI?

Those names don't exist for Tegra, or rather the WM8903, and I imagine for
any ASoC drivers. I had imagined this could be fixed by creating virtual
mixer controls in asound.conf that re-direct requests to that real control.
Is that how things typically work? Or, should the ASoC machine driver
create controls with those names?

Thanks.

-- 
nvpublic
