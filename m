From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/2] ucm: Automatically load the best config
	file based on the card long name
Date: Tue,  3 Jan 2017 13:41:15 +0800
Message-ID: <cover.1483421175.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E80A8266C94
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 06:38:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Intel DSP platform drivers are used by many different devices. For user
space to differentiate them, now ASoC provide API for machine drivers to
include the DMI info (vendor, product and board) in card long name. This
series will add UCM support for loading best device-specific configuration
based on the card long name.

For the ASoC kernel patch, please see
ASoC: core: Add API to use DMI name in sound card long name (v2)

Mengdong Lin (2):
  ucm: Load device-specific configuration file based on the card long
    name
  ucm: Add command 'get _file' to get the config file name of the opened
    card

History:
v2: Request the device-specific file name to match the card long name,
    no long use automatic key word matching and scoring to avoid error
    and uncertainty. And add command to check the name of actually loaded
    configuration file.

v3: Fix num in strncpy of the long name, which should be
    MAX_CARD_LONG_NAME - 1, not MAX_CARD_LONG_NAME (80).

Mengdong Lin (2):
  ucm: Load device-specific configuration file based on the card long
    name
  ucm: Add command 'get _file' to get the config file name of the opened
    card

 include/use-case.h  |   1 +
 src/ucm/main.c      |  14 ++++++++
 src/ucm/parser.c    | 101 +++++++++++++++++++++++++++++++++++++++++++++++++---
 src/ucm/ucm_local.h |   3 ++
 4 files changed, 115 insertions(+), 4 deletions(-)

-- 
2.7.4
