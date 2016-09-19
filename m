From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Add support for included files
Date: Mon, 19 Sep 2016 13:34:44 +0800
Message-ID: <cover.1474262798.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EACAF26155E
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 07:28:21 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is no ABI change in this file, but only an enhancement for topology
user space library. It will let a text configuration file include other
files, so that some common cofigurations can be shared and we can reduce
the total sizes of files.

Mengdong Lin (1):
  topology: Add support for included files

 include/topology.h        |  37 +++++
 src/topology/parser.c     | 374 +++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/tplg_local.h |  17 +++
 3 files changed, 423 insertions(+), 5 deletions(-)

-- 
2.5.0
