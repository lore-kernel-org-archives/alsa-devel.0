From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: [PATCH v3 0/3] ASoC: intel: atom: Add FW version
	information
Date: Wed, 23 Nov 2016 08:45:10 +0100
Message-ID: <20161123074513.28661-1-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DB45A266731
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 08:49:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com
Cc: Sebastien Guiriec <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch series is adding FW version information of SST. Version is both
log as dev_info and sysfs entry.

Update since V1:
- sysfs entry is set to "FW not yet loaded" in case we do not have
loaded the FW once

Update since V2:
- Add Vinod ack.
   https://www.spinics.net/lists/alsa-devel/msg56521.html


Sebastien Guiriec (3):
  ASoC: intel: atom: Add debug information related to FW version
  ASoC: Intel: atom: save FW version
  ASoC: Intel: atom: Add sysfs entry in order to store FW version

 sound/soc/intel/atom/sst/sst.c     | 39 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/atom/sst/sst.h     |  1 +
 sound/soc/intel/atom/sst/sst_ipc.c | 10 +++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.9.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
