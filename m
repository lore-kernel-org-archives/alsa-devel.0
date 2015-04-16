From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [RFC 0/4] ASoC DSP topology
Date: Thu, 16 Apr 2015 21:48:05 +0100
Message-ID: <1429217285.7100.18.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DC6F7260447
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 22:48:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It's been about 2 years since posting V1 of the ASoC dynamic firmware patches
and a lot has changed since then ...

This RFC series is being posted instead of a V2 patch series atm since we are
still completing some testing on the codebase and developing a new userspace
tool. Expect V2 once more testing is completed shortly.

ASoC topology (formerly called dynamic firmware) allows audio DSP topology to
be defined as part of the firmware package and not hard coded into the driver.
This allows DSP vendors to ship multiple different firmwares or firmwares with
programmable topologies for different devices (i.e. phones, tablets, TVs) using
a single DSP driver. The DSP topology can be contained as part of the firmware
file or exist as separate files. The topology core and file format is generic
and not tied to any single vendor or device. 

The topology core consists of kernel and userspace components :-

Kernel. The kernel core reads in the topology data and builds the driver
capabilities and audio topology based on this data. This includes building
the DAPM graph, setting PCM and DAI capabilities, registering kcontrols and
registering DAPM widgets.

The userspace tool allows the creation of binary DSP FW topology files based on
a topology text files.

Changes since V1:-

 o Name changed to ASoC Topology
 o Structures from soc.h and soc-dapm.h no longer exposed as UAPIs
 o Moved to component model from codec/platform model.
 o Added reserved fields in each UAPI structure.
 o UAPI structures packed and endianess defined for each structure.
 o Added support for PCM, DAI and codec <-> codec link capabilities.
 o Added support for client drivers manifests.
 o Added support for private data for each dynamic object type.
 o Single list of dynamic objects rather than list of each object type.

Liam
