From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3]: tinycompress: header and rate fixes
Date: Mon, 16 Dec 2013 20:44:57 +0530
Message-ID: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F3A261670
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 17:14:18 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch series update the header file to verion 0.1.2. This brings the 64bit
ABI compatiblity issue fix.

Users have complianed about use of SNDRV_RATE_xxx for passing the sample rates
as it doesnt scale to what decoder user. So time to junk this and use raw rates
as is.


Vinod Koul (3):
  tinycompress: update the header to kernel API v0.1.2
  tinycompress: cplay: use the numeric sample rate
  tinycompress: remove usage of SNDRV_RATE_xxx

 cplay.c                             |    2 +-
 include/sound/compress_offload.h    |   23 ++++++++++++++---------
 include/sound/compress_params.h     |    9 +++++++++
 include/tinycompress/tinycompress.h |   20 --------------------
 utils.c                             |   34 ----------------------------------
 5 files changed, 24 insertions(+), 64 deletions(-)

--
~Vinod
