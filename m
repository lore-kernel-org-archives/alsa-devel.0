From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2 0/7] ALSA: USB-audio: Support Zoom R16
	playback
Date: Mon, 19 Oct 2015 08:52:48 +0200
Message-ID: <1445237575-396-1-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 56C4526571D
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:53:05 +0200 (CEST)
In-Reply-To: <1444906657-16791-1-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Ricard Wanderlof <ricardw@axis.com>, Ricard Wanderlof <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org

V2: Change u32 to __le32 (kbuild test robot warning).
    Since Zoom R24 most likely behaves as R16 when used as an audio
    interface, refer to "R16/24" throughout in all comments (no code
    change).
    Tested both in Linux 3.16.7 (with appropriate backports) and 4.3.0 .
    Made changelogs more descriptive.

The Zoom R16 has a nonstandard playback format where each isochronous packet
contains a length descriptor in the first four bytes.

This patch series implements a quirk which involves adding the extra length
descriptor whenever outgoing isochronous packets are generated.

The first four patches refactor some code in pcm.c and endpoint.c before
the actual quirk implementation. A final commit cleans up the entry in
the quirks table.

Big thanks to Panu for testing this patch.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Tested-by: Panu Matilainen <pmatilai@laiskiainen.org>

Ricard Wanderlof (7):
  Break out copying to urb from prepare_playback_urb()
  Also move out hwptr_done wrap from prepare_playback_urb()
  Break out creation of silent urbs from prepare_outbound_urb()
  Add offset parameter to copy_to_urb()
  Add quirk for Zoom R16/24 playback
  Adjust max packet size calculation for tx_length_quirk
  Remove mixer entry from Zoom R16/24 quirk

 sound/usb/card.h         |  1 +
 sound/usb/endpoint.c     | 73 +++++++++++++++++++++++++++++++++--------------
 sound/usb/pcm.c          | 74 +++++++++++++++++++++++++++++++++++++-----------
 sound/usb/quirks-table.h | 14 +++------
 sound/usb/quirks.c       |  3 ++
 sound/usb/stream.c       |  1 +
 sound/usb/usbaudio.h     |  1 +
 7 files changed, 119 insertions(+), 48 deletions(-)

-- 
2.1.4
