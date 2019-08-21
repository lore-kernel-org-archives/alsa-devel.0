From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/5] ASoC: SOF: Intel: SoundWire initial integration
Date: Wed, 21 Aug 2019 15:17:15 -0500
Message-ID: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This RFC is the companion of the other RFC 'soundwire: intel: simplify
DAI/PDI handling​'. Our purpose at this point is to gather feedback on
the interfaces between the Intel SOF parts and the SoundWire code.

The suggested solution is a simple init/release inserted at
probe/remove and resume/suspend, as well as two callbacks for the SOF
driver to generate IPC configurations with the firmware. That level of
separation completely hides the details of the SoundWire DAIs and will
allow for 'transparent' multi-cpu DAI support, which will be handled
in the machine driver and the soundwire DAIs.

This solution was tested on IceLake and CometLake, and captures the
feedback from SOF contributors on an initial integration that was
deemed too complicated (and rightly so).

Pierre-Louis Bossart (5):
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
  ASoC: SOF: Intel: hda: add SoundWire IP support
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: add support for SoundWire suspend/resume

 include/sound/sof/dai-intel.h |  18 ++--
 sound/soc/sof/intel/hda-dsp.c |  11 +++
 sound/soc/sof/intel/hda.c     | 157 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h     |  11 +++
 4 files changed, 188 insertions(+), 9 deletions(-)


base-commit: 3b3aaa017e8072b1bfddda92be296b3463d870be
-- 
2.20.1
