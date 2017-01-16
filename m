From: mengdong.lin@linux.intel.com
Subject: [PATCH v5 0/3] ucm: Automatically load the best config
	file based on the card long name
Date: Mon, 16 Jan 2017 18:42:19 +0800
Message-ID: <cover.1484562657.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C45FF266539
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 11:39:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Intel DSP platform drivers are used by many different devices. For user
space to differentiate them, now ASoC provide API for machine drivers to
include the DMI info (vendor, product and board) in card long name. This
series will add UCM support for loading best device-specific configuration
based on the card long name.

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


v4: No code change. Just update on comments because the kernel v4 patches
    add DMI product version to the card long name, and use "-" as
    the separator between DMI fields.

v5: Revise the comments. Add patch to assure the input card name not to
    exceed the maximum card long name supported by kernel to avoid use
    strncpy and strncmp later. 

Mengdong Lin (3):
  ucm: Assure the user input card name not to exceed max size of card
    long name
  ucm: Load device-specific configuration file based on the card long
    name
  ucm: Add command 'get _file' to get the config file name of the opened
    card

 include/use-case.h  |   1 +
 src/ucm/main.c      |  14 +++++++
 src/ucm/parser.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/ucm/ucm_local.h |   3 ++
 4 files changed, 119 insertions(+), 4 deletions(-)

-- 
2.7.4
