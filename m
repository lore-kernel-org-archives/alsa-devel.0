From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 0/2] Fixes for SOF module unload/reload
Date: Tue, 25 Jun 2019 23:29:33 -0700
Message-ID: <20190626062935.5549-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A64DF806F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 08:29:38 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

A recent commit "ALSA: hdac: fix memory release for SST and SOF drivers"
removed the kfree call for the hdac device in
snd_hdac_ext_bus_device_exit(). This requires that the SOF driver
also make the hdac_device and hdac_hda_priv device-managed so
that they can be freed when the SOF module in unloaded. The first
patch takes care of this change.

Additionally, because of the above change, the hda_codec is
device-managed and freeing it in snd_hda_codec_dev_release() leads
to kernel panic with module unload/reload stress tests. The second
patch includes the change to avoid freeing hda_codec for ASoC driver.

More details for the module unload/reload test failures can be found
here: https://github.com/thesofproject/linux/issues/966

Ranjani Sridharan (2):
  ASoC: SOF: Intel: hda: Make hdac_device device-managed
  ASoC: hda: don't free hda_codec for HDA_DEV_ASOC type

 sound/pci/hda/hda_codec.c       | 8 +++++++-
 sound/soc/sof/intel/hda-codec.c | 6 ++----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1
