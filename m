From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 0/2] ALSA: fireworks/firewire-tascam:
	accessing to user space outside spinlock
Date: Wed, 31 Aug 2016 20:15:31 +0900
Message-ID: <1472642133-31576-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0485326661E
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 13:15:42 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous one:
[alsa-devel] [PATCH v2 0/2] ALSA: fireworks/firewire-tascam: accessing to user space outside spinlock
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/112236.html

In ALSA fireworks driver and firewire-tascam driver, current implementation
for hwdep interface have issues for page fault handling. For example,
when using single core processor, after executing lock_page() in page fault
handler and call task scheduler, then the context never regain CPU again,
because any interrupts are disabled by these drivers and the context can't
catch waiting event. This patchset fixes the issues.

The issues were reported by Vaishali Thakkar, with a help of coccinelle.
Thanks a lot for her care to these minor drivers.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111887.html

Changes in v3:
 * Add a workaround against a case that several tasks are going to read from
   one response buffer.

Changes in v2:
 * improve designated initialization for automatic variable of union type

Takashi Sakamoto (2):
  ALSA: firewire-tascam: accessing to user space outside spinlock
  ALSA: fireworks: accessing to user space outside spinlock

 sound/firewire/fireworks/fireworks_hwdep.c       | 52 ++++++++++++++++++------
 sound/firewire/fireworks/fireworks_transaction.c |  4 +-
 sound/firewire/tascam/tascam-hwdep.c             | 33 +++++----------
 3 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.7.4
