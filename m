From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: rt5677: Move platform code to
	where it belongs
Date: Thu, 15 Jun 2017 15:46:35 +0300
Message-ID: <20170615124638.65971-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 672DB266819
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 14:46:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There are few issues with current approach:
- ACPI enumeration should be done by IDs, and not by instances
- Platform code with board related stuff should reside in corresponding module

Fix those issues here.

Andy Shevchenko (3):
  ASoC: rt5677: Introduce proper table for ACPI enumeration
  ASoC: rt5677: Move platform code to board file
  ASoC: Intel: bdw-rt5677: Switch to devm_acpi_dev_add_driver_gpios()

 sound/soc/codecs/rt5677.c           | 32 +++++++-------------------------
 sound/soc/intel/boards/bdw-rt5677.c | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.11.0
