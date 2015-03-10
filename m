From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2 v2] ALSA: core: optimizations for creating
	new controls
Date: Tue, 10 Mar 2015 22:13:29 +0900
Message-ID: <1425993211-2370-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A86B5261569
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:13:35 +0100 (CET)
In-Reply-To: <1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
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

This patchset is for reducing calculating time and stack usage at creating
new control instances, fixes nothing.

Differences from my previous patches:
 - Remove superfluous parentheses.

Takashi Sakamoto (2):
  ALSA: core: use precomputed table to check userspace control params
  ALSA: core: reduce stack usage related to snd_ctl_new()

 sound/core/control.c | 271 +++++++++++++++++++++++++++++----------------------
 1 file changed, 157 insertions(+), 114 deletions(-)

-- 
2.1.0
