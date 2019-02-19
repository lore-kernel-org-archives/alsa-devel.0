From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH v2] ASoC: Intel: Boards: Add Maxim98373 support
Date: Tue, 19 Feb 2019 09:54:26 +0530
Message-ID: <1550550267-32630-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 62CDC265527
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 05:24:38 +0100 (CET)
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
Cc: N Harshapriya <harshapriya.n@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Chiang Mac <mac.chiang@intel.com>, Nujella Sathyanarayana <sathyanarayana.nujella@intel.com>, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, M Naveen <naveen.m@intel.com>, jenny.tc@intel.com
List-Id: alsa-devel@alsa-project.org

Reuse kbl_da7219_max98927 machine driver to support max98373

v1: First patchset
V2: Updated commit message and Acked-by

Jenny TC (1):
  ASoC: Intel: Boards: Add Maxim98373 support

 sound/soc/intel/boards/Kconfig                    |   1 +
 sound/soc/intel/boards/kbl_da7219_max98927.c      | 203 +++++++++++++++++++---
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c |  19 ++
 3 files changed, 200 insertions(+), 23 deletions(-)

-- 
1.9.1
