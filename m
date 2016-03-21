From: han.lu@intel.com
Subject: [PATCH 0/3] *** Some trival fixes on alsabat ***
Date: Mon, 21 Mar 2016 19:05:46 +0800
Message-ID: <cover.1458558001.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B0F37265054
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 12:04:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Fix misusing of errno, fopen, prints and return value

Lu, Han (3):
  alsabat: fix misusing of errno
  alsabat: fix fopen and messages
  alsabat: use variable for thread return value

 bat/alsa.c    | 50 ++++++++++++++++++++++++++------------------------
 bat/analyze.c |  6 +++---
 bat/bat.c     | 39 ++++++++++++++++++++++-----------------
 bat/common.c  |  1 -
 4 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.5.0
