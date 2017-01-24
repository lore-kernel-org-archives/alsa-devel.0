From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/7] ALSA: Fine-tuning for several function implementations
Date: Tue, 24 Jan 2017 11:19:23 +0100
Message-ID: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jan 2017 11:02:34 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  seq: Delete unnecessary checks in snd_seq_ioctl_query_subs()
  seq: Delete unnecessary checks in snd_seq_ioctl_get_subscription()
  seq: Delete unnecessary checks in snd_seq_ioctl_unsubscribe_port()
  seq: Delete unnecessary checks in snd_seq_ioctl_subscribe_port()
  seq: Adjust 16 function calls together with a variable assignment
  dmasound_core: Move two assignments for the variable "ret" in state_open()
  dmasound_core: Adjust six function calls together with a variable assignment

 sound/core/seq/seq_clientmgr.c     | 163 ++++++++++++++++++++-----------------
 sound/oss/dmasound/dmasound_core.c |  33 +++++---
 2 files changed, 109 insertions(+), 87 deletions(-)

-- 
2.11.0

