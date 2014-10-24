From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: intel: add support for future acpi
	platforms
Date: Fri, 24 Oct 2014 13:49:45 +0530
Message-ID: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A5CA2604A0
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 10:58:17 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We have some SoCs which are ACPI based. Current driver supports Merrifield
type PCI SoC. SO make some minor changes required for ACPI support in
subsequent series

Subhransu S. Prusty (3):
  ASoC: Intel: mrfld: Replace pci_id with unique device id
  ASoC: Intel: mrfld - Define ipc_info structure
  ASoC: Intel: mrfld: Define sst_res_info for acpi

 arch/x86/include/asm/platform_sst_audio.h |   28 ++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst.c                 |   10 +++++-----
 sound/soc/intel/sst/sst.h                 |    5 +++--
 sound/soc/intel/sst/sst_pvt.c             |    4 ++--
 4 files changed, 38 insertions(+), 9 deletions(-)
