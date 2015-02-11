From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: control: refactoring core codes
Date: Wed, 11 Feb 2015 19:37:24 +0900
Message-ID: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8A42605A9
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset is for refactoring core control codes. This is also a
preparation for my further work for ALSA control functionality.

Takashi Sakamoto (8):
  ALSA: control: change type from long due to the definition of sizeof
    operator
  ALSA: control: obsolete switch statement with const value table
  ALSA: control: gathering evaluations to access
  ALSA: control: add a comment about locking values after creating
  ALSA: control: rename loop index to i
  ALSA: control: fix over 80 characters lines
  ALSA: control: rename to appropriate macro name
  ALSA: control: arrange snd_ctl_new() as a local function

 sound/core/control.c | 223 ++++++++++++++++++++++++++-------------------------
 1 file changed, 113 insertions(+), 110 deletions(-)

-- 
2.1.0
