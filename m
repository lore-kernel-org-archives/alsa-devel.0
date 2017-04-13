From: fuweix.tang@intel.com
Subject: [PATCH 0/4] topology: Support using "index" to group
	objects when generating binary for kernel
Date: Thu, 13 Apr 2017 14:52:43 +0800
Message-ID: <cover.1492065639.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DC431266AD7
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:52:58 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

The index value of an topology object can be used to group objects for different
use cases. And so the audio kernel driver can ask topology core to load all
objects of the specified index value(use case). The function is already supported
in kernel.
So in the user space, for topology objects of the same type but with different
index values, they should be written into different blocks in the binary for
kernel. The index value is stored in the block header.

Fuwei Tang (4):
  topology: Insert new element based on its index value
  topology: Remove code parsing index value in paring each object
  topology: Look up references for an object based on its index
  topology: Group elements with the same index value into a block

 include/topology.h        | 10 +++--
 src/topology/builder.c    | 94 +++++++++++++++++++++++++----------------------
 src/topology/ctl.c        | 31 +---------------
 src/topology/dapm.c       | 27 +++++---------
 src/topology/data.c       | 15 ++------
 src/topology/elem.c       | 74 +++++++++++++++++++++++++++----------
 src/topology/pcm.c        | 58 ++++++-----------------------
 src/topology/tplg_local.h |  3 +-
 8 files changed, 141 insertions(+), 171 deletions(-)

-- 
2.7.4
