From: mengdong.lin@intel.com
Subject: [PATCH v2 0/3] ASoC: topology: update kcontrol ops
	binding & support TLV bytes controls
Date: Tue, 18 Aug 2015 18:11:39 +0800
Message-ID: <cover.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 330B426051B
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 11:58:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, mengdong.lin@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

History:
v2:
  - let vendor specific kcontrol handlers override standard ones.
  - Merge handler binding for TLV bytes controls into
    soc_tplg_kcontrol_bind_io()

Mengdong Lin (3):
  ASoC: topology: Bind vendor specific kcontrol handlers before standard
    ones
  ASoC: topology: Reduce arguments of soc_tplg_kcontrol_bind_io()
  ASoC: topology: Add support for TLV bytes controls

 include/sound/soc-topology.h |  13 +++++-
 sound/soc/soc-topology.c     | 101 ++++++++++++++++++++++++++++---------------
 2 files changed, 79 insertions(+), 35 deletions(-)

-- 
1.9.1
