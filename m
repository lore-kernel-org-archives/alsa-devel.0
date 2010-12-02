From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] ASoC: Override codec compress_type from
	the machine driver
Date: Thu,  2 Dec 2010 16:11:04 +0000
Message-ID: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F3D6244B9
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:11:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for overriding the compress_type of the codec driver
from the machine driver.  This patch depends on the previous series of patches
that I've submitted with Subject "ASoC: Laying the groundwork for
compress_type overriding".

Dimitris Papastamos (2):
  ASoC: soc-cache: Use reg_def_copy instead of reg_cache_default
  ASoC: soc-core: Allow machine drivers to override compress_type

 include/sound/soc.h   |    2 +
 sound/soc/soc-cache.c |   36 +++++++++++++-------
 sound/soc/soc-core.c  |   87 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 104 insertions(+), 21 deletions(-)

-- 
1.7.3.2
