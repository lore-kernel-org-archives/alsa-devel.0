From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC: Implement new caching API
Date: Fri, 22 Oct 2010 15:28:18 +0100
Message-ID: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B432103810
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:28:24 +0200 (CEST)
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

This patch series introduces the new caching API.  The idea behind this
caching interface is that we can provide different means of organizing
and accessing the register cache.  This is useful for large and sparse
register maps, where one can use some kind of compression algorithm to
reduce the memory footprint.  The caching API is designed in such way to
eliminate the need for modifying any existing drivers.

Dimitris Papastamos (4):
  ASoC: soc.h: Add new caching API prototypes and hooks
  ASoC: soc-cache: Add support for standard register caching
  ASoC: soc-core: Adapt soc-core to fit the new caching API
  ASoC: soc-cache: Add support for LZO based register caching

 include/sound/soc.h   |   27 ++
 sound/soc/soc-cache.c |  646 ++++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/soc-core.c  |   38 ++--
 3 files changed, 657 insertions(+), 54 deletions(-)

-- 
1.7.3.1
