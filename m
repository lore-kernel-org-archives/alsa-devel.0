From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 0/3] ucm: miscellaneous fixes
Date: Tue, 10 Feb 2015 22:42:31 +0200
Message-ID: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EF37B260547
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 21:42:39 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

While working on PulseAudio's UCM code, I noticed strange use of const
in snd_use_case_get(). The third patch fixes that.

While working on the third patch, I also noticed strange code in
execute_sequence(). The first patch fixes one obvious bug, but there
was another issue which I didn't know how to fix, so I just added a
FIXME comment instead (that's just as an RFC, I hope the discussion
will reveal what the proper fix should be).

Tanu Kaskinen (3):
  ucm: fix variable mixup
  ucm: add a FIXME comment
  ucm: fix inappropriate use of const

 include/use-case.h |  2 +-
 src/ucm/main.c     | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
1.9.3
