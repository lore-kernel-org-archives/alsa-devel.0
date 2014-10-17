From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Add missing build dependencies
Date: Thu, 16 Oct 2014 18:22:00 -0700
Message-ID: <1413508922-27567-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A2826063A
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 03:24:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alsa-devel@alsa-project.org, "Glenn P. Williamson" <glenn.p.williamson@intel.com>
List-Id: alsa-devel@alsa-project.org

The Broadwell and Haswell machines utilize the RT286 and RT5640 codecs,
respectively. To communicate with the codecs, the machine utilizes the
Designware I2C platform adapter. Hence, such adapter should be present
in order to probe the codec drivers correctly. This short patch series
fixes the missing dependency.

Thanks and BR,
Ricardo

Ricardo Neri (2):
  ASoC: Intel: Add new dependency for Broadwell machine
  ASoC: Intel: Add new dependency for Haswell machine

 sound/soc/intel/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
