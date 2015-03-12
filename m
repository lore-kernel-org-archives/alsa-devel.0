From: han.lu@intel.com
Subject: [PATCH v3 0/3] add sound effect module waves
Date: Thu, 12 Mar 2015 13:52:59 +0800
Message-ID: <1426139582-7245-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DA6FA26055F
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 06:53:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Merged 5 patches(0004 to 0008) of last revision into 3 new patches

Lu, Han (3):
  ASoC: Intel: add kcontrol to enable/disable sound effect module waves
  ASoC: Intel: add function to set parameter to sound effect module
    waves
  ASoC: Intel: add kcontrol to set parameter to sound effect module
    waves

 sound/soc/intel/sst-haswell-ipc.c | 142 ++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-haswell-ipc.h |  35 ++++++++++
 sound/soc/intel/sst-haswell-pcm.c | 118 +++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)

-- 
1.9.1
