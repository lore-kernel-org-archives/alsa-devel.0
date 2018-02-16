From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 0/1] Use of shared resource in designware
Date: Fri, 16 Feb 2018 13:13:28 +0530
Message-ID: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0062.outbound.protection.outlook.com [104.47.37.62])
 by alsa0.perex.cz (Postfix) with ESMTP id F361926778B
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:56:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

This patch will allow the driver to map same registers
to multiple instances of driver.

It is useful when playback and capture have same regsiters
and are required to be present on separate cpu dais.

This patch is dependant on "Add devm_ioremap_shared_resource()"
patch. https://patchwork.kernel.org/patch/10177127/

Akshu Agrawal (1):
  ASoC: dwc: Use devm_ioremap_shared_resource

 include/sound/designware_i2s.h |  1 +
 sound/soc/dwc/dwc-i2s.c        | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
1.9.1
