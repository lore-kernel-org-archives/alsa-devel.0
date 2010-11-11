From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2 0/3] ASoC: Introduce the new caching API
Date: Thu, 11 Nov 2010 10:04:56 +0000
Message-ID: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 833181038BD
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 11:05:06 +0100 (CET)
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

TODO:
 - Memory usage statistics, to make it easier to select the proper caching
 technique.
 - Support for bulk reads/writes.
 - Overridable caching behaviour from the machine driver.
 - Optimize certain CPU intensive paths.
 - Ensure proper locking in init()/exit()/sync().

Dimitris Papastamos (3):
  ASoC: soc-cache: Add support for flat register caching
  ASoC: soc-cache: Add support for LZO register caching
  ASoC: soc-cache: Add support for rbtree based register caching

 include/sound/soc.h   |   29 ++
 sound/soc/Kconfig     |    2 +
 sound/soc/soc-cache.c |  984 +++++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/soc-core.c  |   37 +--
 4 files changed, 998 insertions(+), 54 deletions(-)

-- 
1.7.3.2
