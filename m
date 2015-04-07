From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 0/3] ASoC: Intel: IPC/mailbox code refactoring
Date: Tue,  7 Apr 2015 09:33:29 +0800
Message-ID: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B97F260513
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 03:26:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Currently in Intel SST driver, some very similar or duplicated IPC/mailbox
processing code are used in different platforms.

This is a patch series which refactors the common IPC/mailbox code into
generic APIs and use the new APIs in Baytrail and Broadwell platforms.

This patch series depends on Jie Yang's following patches for build:
ASoC: Intel: create atom folder and move atom platform files in
ASoC: Intel: create baytrail folder and move baytrail platform files in
ASoC: Intel: create boards folder and move sst boards files in
ASoC: Intel: create haswell folder and move haswell platform files in
ASoC: Intel: create common folder and move common files in

Since now Jie Yang's patch series has been applied in intel branch so this
patch series will be no build issue.

Thanks
Jin Yao

Jin Yao (3):
  ASoC: Intel: Refactor common IPC/mailbox code into generic APIs
  ASoC: Intel: Use the generic IPC/mailbox APIs in Baytrail
  ASoC: Intel: Use the generic IPC/mailbox APIs in Broadwell

 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 360 ++++++--------------------
 sound/soc/intel/common/Makefile             |   3 +-
 sound/soc/intel/common/sst-ipc.c            | 294 +++++++++++++++++++++
 sound/soc/intel/common/sst-ipc.h            |  91 +++++++
 sound/soc/intel/haswell/sst-haswell-ipc.c   | 382 +++++++---------------------
 5 files changed, 551 insertions(+), 579 deletions(-)
 create mode 100644 sound/soc/intel/common/sst-ipc.c
 create mode 100644 sound/soc/intel/common/sst-ipc.h

-- 
1.9.1
