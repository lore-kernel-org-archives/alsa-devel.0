From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH 0/7] ALSA: USB-audio: Support Zoom R16 playback
Date: Thu, 15 Oct 2015 12:57:30 +0200
Message-ID: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 183DD260462
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 12:57:40 +0200 (CEST)
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

The Zoom R16 has a nonstandard playback format where each isochronous
packet contains a length descriptor in the first four bytes. Curiously,
capture data does not contain this and requires no quirk.

The quirk involves adding the extra length descriptor whenever outgoing
isochronous packets are generated, both in pcm.c (outgoing audio) and
endpoint.c (silent data). The calculation for the max packet size in
endpoint.c is also affected.

This patch series refactors some code in pcm.c and endpoint.c before the
actual quirk implementation. A commit then cleans up the entry in the
quirks table.

Tested with a Zoom R16, both separately using arecord and aplay (8 channel
capture and 2 channel playback, respectively), as well as capture and
playback together together using the Ardour digitial audio workstation
application.  The R24 reportedly is compatible with the R16, but I don't
have access to one so I can't test it, and consequently the patch series
only mentions the R16.

Also tested using an Edirol UA-5 in both class compliant (16-bit) and
"advanced" (24 bit, forces the use of quirks) modes in order to do some
form of regression testing.

Ricard Wanderlof (7):
  Break out copying to urb from prepare_playback_urb()
  Also move out hwptr_done wrap from prepare_playback_urb()
  Break out creation of silent urbs from prepare_outbound_urb()
  Add offset parameter to copy_to_urb()
  Add quirk for Zoom R16 playback
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
