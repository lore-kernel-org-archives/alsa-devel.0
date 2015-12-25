From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 v3] ALSA: dice: improve card registration
	processing
Date: Fri, 25 Dec 2015 10:13:10 +0900
Message-ID: <1451005995-12098-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0944A2666DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2015 02:13:20 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous post.
[alsa-devel] [PATCH 0/4 v2] ALSA: dice: improve card registration processing
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102460.html

The previous patchset includes some bugs.
 * Mutex structure can be destroyed within critical section with it in
   releasing sound card.
 * Bus reset handler doesn't execute transaction re-initialization as long
   as sound card instance is not registered.
 * Work of sound card registration is not postpone even if bus reset occurs.
 * Devices in sound card are not released when sound card registration fails.

This version fixes these bugs, according to discussions between Takash Iwai and
Stefan Richter. Thanks for them.

Changes:
 * Use delayed workqueue API correctly.
 * Wait for registration work in .remove callback, instead of sound card
   free callback.
 * Obsolete mutex_lock()/mutex_unlock() for sound card registration purpose.
 * Keep devices of sound card and release them at registration failure.

In kerneldoc of 'mod_delayed_work', this function call has a side effect to
queueing the work. It seems that this function can be used instead of
schedule_delayed_work.
https://www.kernel.org/doc/htmldocs/device-drivers/API-mod-delayed-work.html

But as long as I tested, my Linux 4.2 system is freezed. I have no further
investigation. I use both of schedule_delayed_work() and mod_delayed_work() in
this patchset.

Takashi Sakamoto (5):
  ALSA: dice: split subaddress check from category check
  ALSA: dice: postpone card registration
  ALSA: dice: ensure to release sound devices after sound card
    registration fails
  ALSA: dice: purge transaction initialization at timeout of Dice
    notification
  ALSA: dice: expand timeout to wait for Dice notification

 sound/firewire/dice/dice-midi.c        |   2 +
 sound/firewire/dice/dice-pcm.c         |   2 +
 sound/firewire/dice/dice-transaction.c | 122 ++++++++++++--------
 sound/firewire/dice/dice.c             | 199 +++++++++++++++++----------------
 sound/firewire/dice/dice.h             |   5 +
 5 files changed, 191 insertions(+), 139 deletions(-)

-- 
2.5.0
