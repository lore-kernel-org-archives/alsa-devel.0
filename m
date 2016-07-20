From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/3] Remove support for
	SNDRV_CTL_ELEM_ACCESS_USER & minor fix
Date: Wed, 20 Jul 2016 09:52:23 +0800
Message-ID: <cover.1468979281.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EAA82657B1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 03:47:19 +0200 (CEST)
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is no ABI change in this series.

Remove support for control flag SNDRV_CTL_ELEM_ACCESS_USER as Takashi
Sakamoto suggested. Also fix 2 compiler warnings and add check before
string cpy.

History:
v2: Revise commit messages.

Mengdong Lin (3):
  topology: Remove support for control flag SNDRV_CTL_ELEM_ACCESS_USER
  topology: Add ATTRIBUTE_UNUSED for unused parameters to fix compiler
    warning
  topology: Check address and length before string copy

 src/topology/ctl.c        | 1 -
 src/topology/pcm.c        | 8 ++++----
 src/topology/tplg_local.h | 3 +++
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.5.0
