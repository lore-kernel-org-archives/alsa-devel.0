From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] ASoC: SOF: i.MX8 SAI and Intel
	ALH/SoundWire DAI support
Date: Thu, 15 Aug 2019 14:20:14 -0500
Message-ID: <20190815192018.30570-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC325F80274
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 21:22:49 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds the basic functionality to extract DAI information
from the topology and send the information to firmware.

The i.MX8 SAI/ESAI definitions are minimal placeholders for now, they
are included to keep the alignment with the firmware/topology.

For the Intel ALH, there is no specific configuration in topology
file, all the programming takes place based on the dai index and the
related ALH stream ID. The renaming from SoundWire to ALH (Audio Link
Hub) is a better representation of the hardware, the ALH acts as a
proxy between the DMA transfers and the Cadence IP.

Bard liao (1):
  ASoC: SOF: rename SOUNDWIRE to ALH

Daniel Baluta (1):
  ASoC: SOF: topology: Add dummy support for i.MX8 DAIs

Pierre-Louis Bossart (2):
  ASoC: SOF: topology: initial support for Intel ALH DAI type
  ASoC: SOF: pcm: add ALH support

 include/sound/sof/dai.h         |  4 +-
 include/uapi/sound/sof/tokens.h |  8 ++++
 sound/soc/sof/pcm.c             |  3 ++
 sound/soc/sof/topology.c        | 72 ++++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 2 deletions(-)

-- 
2.20.1
