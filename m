From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/5] topology: Upgrade ABI to match kernel v4.8
Date: Mon,  3 Oct 2016 23:02:46 +0800
Message-ID: <cover.1475505267.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AFA80266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:02:09 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Now the topology ABI version in kernel is 5, added types for BE
(Backend) DAIs and sig_bits in stream caps. But the ABI version
in alsa-lib is still 4, without above ABI update.

Since the kernel merge window is open and the remaining topology
ABI update (v3 kernel patch series) cannot be accepted atm. So we
use this series to fix the ABI mismatch between kernel v4.8 and
user space, by adding types for BE DAIs and sig_bits to stream
caps and pumping topolpgy ABI version to 5 as well.

This patch series also completes the support for BE DAIs.

Guneshwor Singh (3):
  topology: Parse BE DAIs in text conf file
  topology: Support configuring BE DAIs by C API
  topology: Export BE DAIs to the binary for kernel

Mengdong Lin (2):
  topology: ABI - Add the types for BE DAI
  topology: ABI - Add sig_bits to stream caps

 include/sound/asoc.h      |  35 ++++++-
 include/topology.h        |  45 +++++++++
 src/topology/builder.c    |  11 +++
 src/topology/data.c       |   4 +
 src/topology/elem.c       |   4 +
 src/topology/parser.c     |  16 ++++
 src/topology/pcm.c        | 238 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h |   7 ++
 8 files changed, 358 insertions(+), 2 deletions(-)

-- 
2.5.0
