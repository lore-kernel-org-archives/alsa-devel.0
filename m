From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/4] topology: Add support for BE DAIs
Date: Fri, 22 Jul 2016 14:09:24 +0800
Message-ID: <cover.1469165324.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BB34C260442
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 08:04:16 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series is to work with the kernel series 
'ASoC: topology: Add support for BE DAIs'

This series adds support for BE (Back End) DAIs in user space:
- Define the type and ABI struct for Backend DAIs in UAPI header file.
- User can define BE DAIs either by the text conf file or by C API.

There is topology ABI udpate in this series. Topology core can check size
of each ABI objects to detect version mismatch between user space and
kernel.

There will be 2 pairs of kernel & user space series for PCM & BE links
later.

Guneshwor Singh (3):
  topology: Parse BE DAIs in text conf file
  topology: Support adding BE DAIs by C API
  topology: Export BE DAIs to the binary for kernel

Mengdong Lin (1):
  topology: ABI - Add the types for BE DAI

 include/sound/asoc.h      |  34 ++++++-
 include/topology.h        |  44 +++++++++
 src/topology/builder.c    |  11 +++
 src/topology/data.c       |   4 +
 src/topology/elem.c       |   4 +
 src/topology/parser.c     |  16 ++++
 src/topology/pcm.c        | 237 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h |   7 ++
 8 files changed, 355 insertions(+), 2 deletions(-)

-- 
2.5.0
