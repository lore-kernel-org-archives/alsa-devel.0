From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH v2 resend 0/3] ASoC: SOF: fix suspend ordering
	with runtime idle
Date: Tue,  2 Jul 2019 16:24:25 +0300
Message-ID: <20190702132428.13129-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9459EF800C5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 15:23:26 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,
this series addresses issues with ordering of HDA codec and controller
suspends in the runtime PM flows. The implemented logic for SOF is
similar to what has been used by the Intel AZX HDA driver.

To implement this, first a fix is needed to hdac_hdmic ASoC codec
driver. SOF framework also needs to be extended to allow SOF devices
to implement a runtime_idle callback. Third, concrete implementation
is in a separate patch for APL/CNL Intel hardware, for which strict
ordering of codec-controller power down sequence needs to be
maintained.

As this extends the SOF device interface, Pierre asked me to
send to the list for wider review. This series has been prereviewd
at SOF github as:
https://github.com/thesofproject/linux/pull/1003

v2 resend:
  - no changes since v2 -- resending as 2 weeks has passed and
    multiple reviewed-by acks already received
v2:
  - Rebased on broonie/for-next, there was a conflict with patch
    "ASoC: SOF: Intel: hda: release link DMA for paused streams during suspend"
  - Added Reviewed-by tags from v1 round

Kai Vehmanen (3):
  ASoC: hdac_hdmi: report codec link up/down status to bus
  ASoC: SOF: add runtime idle callback
  ASoC: SOF: Intel: implement runtime idle for CNL/APL

 sound/soc/codecs/hdac_hdmi.c  |  2 ++
 sound/soc/sof/intel/apl.c     |  1 +
 sound/soc/sof/intel/cnl.c     |  1 +
 sound/soc/sof/intel/hda-dsp.c | 13 +++++++++++++
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/ops.h           |  8 ++++++++
 sound/soc/sof/pm.c            |  8 ++++++++
 sound/soc/sof/sof-acpi-dev.c  |  2 +-
 sound/soc/sof/sof-pci-dev.c   |  2 +-
 sound/soc/sof/sof-priv.h      |  2 ++
 10 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.17.1
