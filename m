From: han.lu@intel.com
Subject: [PATCH V4 0/4] Some fixes against previous comments
Date: Tue, 20 Oct 2015 16:45:44 +0800
Message-ID: <cover.1445330404.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2644026621A
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:48:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Some fixes and adjustments against previous comments of Takashi

Lu, Han (4):
  BAT: Remove redundant message strings
  BAT: Use colon instead of comma for separation
  BAT: Change comments and interface of usage()
  BAT: Use dynamic temp file

 bat/bat.c    | 106 +++++++++++++++++++++++++++++++----------------------------
 bat/common.h |   2 +-
 2 files changed, 57 insertions(+), 51 deletions(-)

-- 
1.9.1
