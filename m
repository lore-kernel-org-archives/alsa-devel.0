From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: fireworks/firewire-tascam: accessing
	to user space outside spinlock
Date: Sat, 27 Aug 2016 05:50:07 +0900
Message-ID: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E685A266642
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 22:50:14 +0200 (CEST)
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
Cc: vaishali.thakkar@oracle.com, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

In ALSA fireworks driver and firewire-tascam driver, current implementation
for hwdep interface have issues for page fault handling. For example,
when using single core processor, after executing lock_page() in page fault
handler and call task scheduler, then the context never run again, because
any interrupts are disabled by these drivers and the context can't catch
waiting event. This patchset fixes the issues.

The issues were reported by Vaishali Thakkar, with a help of coccinelle.
Thanks a lot for his care to these minor drivers.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111887.html

Takashi Sakamoto (2):
  ALSA: fireworks: accessing to user space outside spinlock
  ALSA: firewire-tascam: accessing to user space outside spinlock

 sound/firewire/fireworks/fireworks_hwdep.c | 20 ++++++++++++++-----
 sound/firewire/tascam/tascam-hwdep.c       | 32 ++++++++++--------------------
 2 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.7.4
