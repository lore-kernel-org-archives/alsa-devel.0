From: fuweix.tang@intel.com
Subject: [PATCH 0/2] conf/ucm: Remove intel UCM conf files from
	alsa-lib repo
Date: Wed, 15 Mar 2017 14:45:38 +0800
Message-ID: <cover.1487576432.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 137EB266EF1
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:45:34 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

Remove the intel UCM configs from alsa-lib repo.

Another series will add them to a dedicated UCM conf repo.License can be changed to
BSD for intel files,and left as "unknown" for other conf files when they are moved from 
alsa-lib to the new repo.The alsa-lib LGPL license does not cover runtime configuration files.

Fuwei Tang (2):
  conf/ucm: Remove conf files of broxton-rt298 platform
  conf/ucm: Remove conf files of skylake-rt286 platfrom

 configure.ac                                  |   2 -
 src/conf/ucm/Makefile.am                      |   2 +-
 src/conf/ucm/broxton-rt298/Hdmi1              |  22 -----
 src/conf/ucm/broxton-rt298/Hdmi2              |  14 ---
 src/conf/ucm/broxton-rt298/HiFi               | 129 --------------------------
 src/conf/ucm/broxton-rt298/Makefile.am        |   4 -
 src/conf/ucm/broxton-rt298/broxton-rt298.conf |  58 ------------
 src/conf/ucm/skylake-rt286/Hdmi1              |  20 ----
 src/conf/ucm/skylake-rt286/Hdmi2              |  20 ----
 src/conf/ucm/skylake-rt286/HiFi               | 129 --------------------------
 src/conf/ucm/skylake-rt286/Makefile.am        |   4 -
 src/conf/ucm/skylake-rt286/skylake-rt286.conf |  60 ------------
 12 files changed, 1 insertion(+), 463 deletions(-)
 delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi1
 delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi2
 delete mode 100644 src/conf/ucm/broxton-rt298/HiFi
 delete mode 100644 src/conf/ucm/broxton-rt298/Makefile.am
 delete mode 100644 src/conf/ucm/broxton-rt298/broxton-rt298.conf
 delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi1
 delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi2
 delete mode 100644 src/conf/ucm/skylake-rt286/HiFi
 delete mode 100644 src/conf/ucm/skylake-rt286/Makefile.am
 delete mode 100644 src/conf/ucm/skylake-rt286/skylake-rt286.conf

-- 
2.7.4
