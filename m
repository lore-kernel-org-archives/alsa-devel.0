From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] tinycompress: fix spare warnings
Date: Mon, 18 Jan 2016 22:00:00 +0530
Message-ID: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AEB2264F2F
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:26:27 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse warns about few things in this project so fix them

Vinod Koul (3):
  tinycompress: cplay: make functions static
  tinycompress: crec: fix function declaration
  tinycompress: crec: make functions static

 include/tinycompress/tinymp3.h | 4 ++--
 src/utils/cplay.c              | 4 ++--
 src/utils/crec.c               | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.9.1
