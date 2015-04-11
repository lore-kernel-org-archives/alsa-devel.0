From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4 v2] fix userspace control element operations
Date: Sat, 11 Apr 2015 17:41:01 +0900
Message-ID: <1428741665-22262-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A3843260621
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 10:41:12 +0200 (CEST)
In-Reply-To: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
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

This patchset is revised version of my previous one.

[alsa-devel] [PATCH 0/4] ALSA: ctl: fix userspace control element operations
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090206.html

Changes:
 - Use helper functions to processing identical information
 - Revise a comment about the number of added element in returned value
 - Remove elements at add operation when EFAULT occurs

Takashi Sakamoto (4):
  ctl: confirm to return all identical information in 'activate' event
  ctl: fix a bug to return no identical information in info operation
    for userspace controls
  ctl: fill identical information to return value when adding userspace
    elements
  ctl: fix to handle several elements added by one operation for
    userspace element

 sound/core/control.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

-- 
2.1.0
