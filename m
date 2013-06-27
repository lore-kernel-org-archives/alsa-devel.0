From: Clemens Ladisch <clemens@ladisch.de>
Subject: [git pull] [PATCH 0/7] add support for many Roland and
	Yamaha devices
Date: Thu, 27 Jun 2013 22:16:11 +0200
Message-ID: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 944AE26562D
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:15:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.alsa-project.org/alsa-kprivate.git full-roland-support

for you to fetch changes up to b7f33917bcd993ff81f3f80b9dc1890fb7410c6d:

  ALSA: usb-audio: add quirks for Roland QUAD/OCTO-CAPTURE (2013-06-27 21:59:50 +0200)

----------------------------------------------------------------
Clemens Ladisch (7):
      ALSA: usb-audio: store protocol version in struct audioformat
      ALSA: usb-audio: detect implicit feedback on Roland devices
      ALSA: usb-audio: add support for many Roland/Yamaha devices
      ALSA: usb-audio: add MIDI port names for some Roland devices
      ALSA: usb-audio: remove superfluous Roland quirks
      ALSA: usb-audio: claim autodetected PCM interfaces all at once
      ALSA: usb-audio: add quirks for Roland QUAD/OCTO-CAPTURE

 sound/usb/card.h         |   1 +
 sound/usb/clock.c        |   4 +-
 sound/usb/format.c       |  34 +---
 sound/usb/format.h       |   2 +-
 sound/usb/midi.c         |  74 +++++++
 sound/usb/pcm.c          |  45 ++++-
 sound/usb/quirks-table.h | 497 +++++++++--------------------------------------
 sound/usb/quirks.c       | 209 ++++++++++++++++++++
 sound/usb/stream.c       |  18 +-
 sound/usb/usbaudio.h     |   2 +
 10 files changed, 445 insertions(+), 441 deletions(-)
