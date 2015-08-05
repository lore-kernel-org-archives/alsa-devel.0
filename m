From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/2] topology: UAPI updates for TLV and ops.
Date: Wed,  5 Aug 2015 14:41:49 +0100
Message-ID: <1438782111-20025-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0799D265E62
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 15:42:10 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series updates the topology UAPI to allow easier addition of new TLV
object types and generic operations for alsa-lib.

Mengdong Lin (2):
  topology: update ABI to improve support for different TLV object
    types.
  topology: Add ops support to byte control objects.

 include/sound/asoc.h | 28 +++++++++++++++++++---------
 src/topology/ctl.c   | 20 ++++++++------------
 2 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.1.4
