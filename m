From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 0/3] ASoC topology
Date: Fri, 29 May 2015 19:05:42 +0100
Message-ID: <1432922742.2732.22.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 36DE52668C5
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 20:05:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

ASoC topology (formerly called dynamic firmware) allows audio DSP
topology to be defined as part of the firmware package and not hard
coded into the driver. This allows DSP vendors to ship multiple
different firmwares or firmwares with programmable topologies for
different devices (i.e. phones, tablets, TVs) using a single DSP driver.
The DSP topology can be contained as part of the firmware file or exist
as separate files. The topology core and file format is generic text and
not tied to any single vendor or device. 

The topology core consists of kernel and userspace components :-

Kernel. The kernel core reads in the topology data and builds the driver
capabilities and audio topology based on this data. This includes
building the DAPM graph, setting PCM and DAI capabilities, registering
kcontrols and registering DAPM widgets.

The userspace tool allows the creation of binary DSP FW topology files
based on a topology text files. The tool is temporarily available on
github and its intended to be merged into the alsa-utils package after a
clean up.

https://github.com/lgirdwood/topology.git


Changes since V2 :-

 o Moved TLV channel maps into TLV UAPI header.
 o Report error in logs when no handler exists for vendor data types.
 o Fix comments on kcontrol/widget ops to match core code.

Changes since RFC :-

 o Fixed patch series to survive bisection builds.
 o Removed widget ID enum from UAPI.
 o Added channel mappings to controls.
 o Added TLV macro patch to UAPI.
 o Fixed locking for runtime and init time topology loading.
 o Moved the UAPI group index field to the block header.

Changes since V1 (back in 2012) :-

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
