From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/5] ASoC: Allow topology to create DAI links
Date: Wed,  2 Dec 2015 14:08:39 +0800
Message-ID: <cover.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E4E72264F03
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:52:33 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series allows DAI links to be created from topology info.

The components with topology info can come in two ways:
- As a component for cpu dai or codec dai of a DAI link predefined
  by machine driver.
- As a auxiliary components defined by the machine driver for a soc
  card. For this case, the machine driver even need not define any
  DAI links.

The ASoC core will find and probe these components when instantiating
the soc card. When probing the components, topology info will be loaded
and DAI links can be created by the topology core. And then ASoC core
will find and bind new DAI links after probing the components.

We implement a DAI link list and define API for adding/removing DAI links
from topology.

Mengdong Lin (5):
  ASoC: Implement DAI links in a list & define API to add/remove a link
  ASoC: Define add/remove_dai_link ops for a soc card
  ASoC: soc_bind_dai_link() directly returns success for a bound DAI
    link
  ASoC: Bind new DAI links after probing components
  ASoC: The soc card can have auxiliary components

 include/sound/soc.h  |  29 +++++++++-
 sound/soc/soc-core.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.5.0
