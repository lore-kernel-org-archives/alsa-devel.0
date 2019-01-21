From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Add support for
	kbl_da7219_max9837 machine driver
Date: Tue, 22 Jan 2019 00:13:08 +0530
Message-ID: <1548096190-24584-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A211E2667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 19:43:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, yang.jie@linux.intel.com
Cc: harshapriya.n@intel.com, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

ASoC: Intel: Add support for kbl_da7219_max9837 machine driver

Jenny TC (2):
  ASoC: Intel: Boards: Add KBL Dialog Maxim98373 I2S machine driver
  ASoC: Intel: Common: Enable kbl_da7219_max98373 ACPI match

 sound/soc/intel/boards/Kconfig                    |   14 +
 sound/soc/intel/boards/Makefile                   |    2 +
 sound/soc/intel/boards/kbl_da7219_max98373.c      | 1031 +++++++++++++++++++++
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c |   13 +
 4 files changed, 1060 insertions(+)
 create mode 100644 sound/soc/intel/boards/kbl_da7219_max98373.c

-- 
1.9.1
