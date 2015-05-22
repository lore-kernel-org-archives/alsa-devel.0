From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-lib: code cleanup
Date: Fri, 22 May 2015 23:21:10 +0900
Message-ID: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id CE471265D8A
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 16:21:18 +0200 (CEST)
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

Current implementation includes several macros and functions with improper
name, hard-coded numerical value and so on.

This patchset is for code cleanup.

Takashi Sakamoto (4):
  ALSA: firewire-lib: rename local functions for code cleanup
  ALSA: firewire-lib: macro arrangement for code cleanup
  ALSA: firewire-lib: use dev_err() when detecting incoming streaming
    error
  ALSA: firewire-lib: use protocol error when detecting wrong value in
    CIP header

 sound/firewire/amdtp.c | 104 ++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 49 deletions(-)

-- 
2.1.4
