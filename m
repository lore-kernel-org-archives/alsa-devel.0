From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 alsa-lib] amixer fixes for enumerated
	elements
Date: Thu,  9 Apr 2015 01:30:53 +0900
Message-ID: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F116265469
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:31:11 +0200 (CEST)
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

The amixer still has issues according to sset operation to enumerated
items. The issues are:
 - Fail to handle omitted value of each channel.
 - The name of enumerated element is truncated.
 - Unclear separators for values of channels.

This patchset fixes these issues, including a small code
refactoring for better reading.

Takashi Sakamoto (5):
  amixer: gather local variables in the beginning of functions
  amixer: fix a bug to handle omitted value in parameter for enumerated
    element
  amixer: expand local storage for item name according to kernel code
  amixer: arrange validation logic
  amixer: use the same characters for separator.

 amixer/amixer.c | 60 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 18 deletions(-)

-- 
2.1.0
