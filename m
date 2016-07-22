From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/3] ASoC: topology: Add support for BE DAIs
Date: Fri, 22 Jul 2016 13:58:03 +0800
Message-ID: <cover.1469165422.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 90BED265713
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 07:52:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is topology ABI udpate in this series. Topology core can check size
of each ABI objects to detect version mismatch between user space and
kernel.

This series adds support for BE (Back End) DAIs:
- Define the type and ABI struct for Backend DAIs.
- The topology core can configure an existing BE DAI or create new BE
  DAIs.


The user space series "topology: Add support for BE DAIs" is also
submitted.

Is it possible to meet the timeline of v4.8?
There will be 2 pairs of kernel & user space series for PCM & BE links
later.

Mengdong Lin (3):
  ASoC: topology: ABI - Add the types for BE DAI
  ASoC: topology: Add support for configuring existing BE DAIs
  ASoC: topology: Able to create BE DAIs

 include/sound/soc-topology.h |   1 +
 include/uapi/sound/asoc.h    |  34 +++++++++-
 sound/soc/soc-core.c         |   3 +-
 sound/soc/soc-topology.c     | 156 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 189 insertions(+), 5 deletions(-)

-- 
2.5.0
