From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] ASoC: topology: fix endianness issues
Date: Thu,  4 Apr 2019 14:13:56 -0500
Message-ID: <20190404191358.4235-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72E2AF8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 21:14:10 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse reports dozens of issues with the topology code due to
endianness. Fix as needed.  There are still a handful of issues that I
could not figure out (see below), but at least now the logs become
usable.

The only remaining problematic files are the SST loader and Skylake
topology handling, which are likely to remain as is without any
updates.


sound/soc/soc-ops.c:657:33: warning: invalid assignment: &=
sound/soc/soc-ops.c:657:33:    left side has type unsigned short
sound/soc/soc-ops.c:657:33:    right side has type restricted __be16
sound/soc/soc-ops.c:661:33: warning: invalid assignment: &=
sound/soc/soc-ops.c:661:33:    left side has type unsigned int
sound/soc/soc-ops.c:661:33:    right side has type restricted __be32
sound/soc/soc-topology.c:616:70: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:618:70: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:633:60: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:635:60: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:637:61: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:650:60: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:652:60: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:654:61: warning: restricted __le32 degrades to integer
sound/soc/soc-topology.c:2507:16: warning: restricted __le32 degrades to integer

Pierre-Louis Bossart (2):
  ASoC: topology: fix endianness issues
  ASoC: topology: fix big-endian check

 sound/soc/soc-topology.c | 295 +++++++++++++++++++++++----------------
 1 file changed, 173 insertions(+), 122 deletions(-)

-- 
2.17.1
