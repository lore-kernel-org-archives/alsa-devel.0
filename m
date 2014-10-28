From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: Intel: Update HSW/BDW SST driver to
 new FW architecture
Date: Tue, 28 Oct 2014 17:37:11 +0000
Message-ID: <1414517831.11730.35.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4FB265D3D
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 18:37:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The following patch series updates the current upstream driver to use
the new more feature rich ADSP FW architecture. The new FW arch allows
for multiple instantiation of objects in dynamic memory locations.

In summary :-

 o Modules can be created multiple times.
 o Modules persistent data can be allocated in any free blocks
 o Global scratch data can be allocated into any free blocks.
 o DMA can be used to load the module data.

The driver now has to track and manage the new multiple module resource
allocations and pass this data to FW on stream initialisations.

Changes since V1 :-

 o Rebased on top of Vinods latest changes to remove a merge conflict.
 o Added mutex unlock in block error path.

The series is sent as 7 patches for ease of review but should be applied
as a single patch to preserve git bisect build.

The following changes since commit 9a80e8f597f3bde0e1d4a4abb021d475520005a5:

  ASoC: Intel: mrfld: Define sst_res_info for acpi (2014-10-27 18:02:38 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc.git intel/new-fw-arch

for you to fetch changes up to 86ce414b582c79fa2e5a5f19e046eaee5bfa84e1:

  ASoC: Intel: Update HSW/BDW SST driver to new FW architecture (2014-10-28 17:05:46 +0000)

----------------------------------------------------------------
Liam Girdwood (1):
      ASoC: Intel: Update HSW/BDW SST driver to new FW architecture

 sound/soc/intel/sst-baytrail-dsp.c |  24 +-
 sound/soc/intel/sst-dsp-priv.h     | 133 ++++++---
 sound/soc/intel/sst-dsp.c          |   8 +
 sound/soc/intel/sst-dsp.h          |   7 +
 sound/soc/intel/sst-firmware.c     | 929 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 sound/soc/intel/sst-haswell-dsp.c  |  59 ++--
 sound/soc/intel/sst-haswell-ipc.c  | 112 ++++----
 sound/soc/intel/sst-haswell-ipc.h  |  11 +-
 sound/soc/intel/sst-haswell-pcm.c  |  83 ++++--
 9 files changed, 1025 insertions(+), 341 deletions(-)
