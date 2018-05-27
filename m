From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: dice: optimization for TC Electronic
	Studio Konnekt 48
Date: Sun, 27 May 2018 10:13:28 +0900
Message-ID: <20180527011330.9817-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f47.google.com (mail-pg0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B1622670BE
 for <alsa-devel@alsa-project.org>; Sun, 27 May 2018 03:14:01 +0200 (CEST)
Received: by mail-pg0-f47.google.com with SMTP id p9-v6so3805218pgc.9
 for <alsa-devel@alsa-project.org>; Sat, 26 May 2018 18:14:01 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds optimization to current ALSA dice driver for Studio
Konnekt 48 produced by TC Electronic 2007.

My recent work adds hard-coded stream format parameters for all of models
produced by TC Electronic with ASICs of Dice series:

 * Konnekt 24D
 * Konnect 8
 * Studio Konnekt 48
 * Konnekt Live
 * Desktop Konnekt 6 
 * Impact Twin
 * Digital Konnekt 32

(Series of PowerCore is not based on Dice.)

Except for Konnekt Live, I actually test with these models, and realized
that current ALSA dice driver brings several issues, mainly with noises
but with detection of packet discontinuities and jumbo payload for some
models and transmission frequencies. I guess they comes from timestamping
quirks which I reported:

[alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html

I have never found any good solution for this issue.

Takashi Sakamoto (2):
  ALSA: dice: fix stream format parameters for TC Electronic Studio
    Konnekt 48
  ALSA: dice: unuse second stream for MIDI conformant data channel for
    TC Electronic models

 sound/firewire/dice/dice-tcelectronic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.14.1
