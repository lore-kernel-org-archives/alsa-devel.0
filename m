From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 v4] ALSA: dice: improve card registration
	processing
Date: Sat, 26 Dec 2015 12:35:21 +0900
Message-ID: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5562614A4
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2015 04:35:36 +0100 (CET)
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

This patchset updates my previous one:

[alsa-devel] [PATCH 0/5 v3] ALSA: dice: improve card registration processing
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102501.html

The patch 02 included a bug of missing 'end' tag. This v4 patchset includes
fixes of the bug.

Additionally, this patchset adds to output information message when registration
work encounters any errors.

Furthermore, I use mod_delayed_work() to queue and postpone work for sound card
registration. I've reported system freeze in previous patchset, but I had a
mistake not to use any actual workqueus as a first argument of the function.

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
 sound/firewire/dice/dice.c             | 197 +++++++++++++++++----------------
 sound/firewire/dice/dice.h             |   5 +
 5 files changed, 189 insertions(+), 139 deletions(-)

-- 
2.5.0
