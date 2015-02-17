From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 0/3] Fixing snd_use_case_get() bugs
Date: Tue, 17 Feb 2015 21:15:20 +0200
Message-ID: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DD3E3261703
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 20:16:03 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Tanu Kaskinen (3):
  ucm: fix incorrect error code sign
  ucm: fix the logic of choosing the default cdev
  ucm: fix some variable constness issues

 include/use-case.h |  5 +++--
 src/ucm/main.c     | 51 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 21 deletions(-)

-- 
1.9.3
