From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/3] ASoC: Implement DAI links in a list & some
	code refactoring
Date: Mon, 23 Nov 2015 10:59:03 -0500
Message-ID: <cover.1448294077.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D13D626545D
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:43:11 +0100 (CET)
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

This is still a preparation for topology to create PCM at dynamically.

First two patches are code refactoring.

The 3rd patch implements the DAI links into a list, so that the number of
links can add/shrink by topology at runtime. 
The use scenario may be like this:
- When instantiating the soc card, probing a component with topology can
  bring new DAI links. The ASoC will probe the new links (in later patches).
- When unregistering the soc card, removing this component will also remove
  DAI  links created by it. 

For backward compatiblity, the machine driver can still define a static link
array. And the ASoC core will add these links into the list when instantiating
the soc card.

Mengdong Lin (3):
  ASoC: Define soc_init_dai_link() to wrap link intialization.
  ASoC: Change 2nd argument of soc_bind_dai_link() to DAI link pointer
  ASoC: Implement DAI links in a list & define API to add/remove a link

 include/sound/soc.h  |  15 ++-
 sound/soc/soc-core.c | 251 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 177 insertions(+), 89 deletions(-)

-- 
2.5.0
