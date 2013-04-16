From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 0/5] ALSA: snd-usb: add support for DSD
Date: Wed, 17 Apr 2013 00:01:35 +0800
Message-ID: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE642610A8
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

In contrast to the first two approaches, this one keeps the userspace
unaware of the actual transport on the bus.

More specifically, the DSD_U16_LE format may be implemented to actually
send DOP samples to the device, depending on the quirks entries.

Also, as there is quite some confusion in both data file formats as
well as hardware sample formats about whether to stuff the oldest bit
in the MSB or the LSB of a byte, ALSA defines that now to be in the
MSB, as far as the ALSA userspace layer is concerned. The driver
learned functions to re-encode the bytes according to what the hardware
supports.

I also wrote a very basic test tool which I published here:

  https://github.com/zonque/alsa-dsd-player


Thanks,
Daniel

Daniel Mack (5):
  ALSA: add DSD formats
  ALSA: snd-usb: use ep->stride from urb callbacks
  ALSA: snd-usb: add support for DSD DOP stream transport
  ALSA: snd-usb: add support for bit-reversed byte formats
  ALSA: snd-usb: add quirks handler for DSD streams

 include/sound/pcm.h         |    2 +
 include/uapi/sound/asound.h |    4 +-
 sound/core/pcm.c            |    2 +
 sound/core/pcm_misc.c       |    8 +++
 sound/usb/card.h            |    8 +++
 sound/usb/endpoint.c        |    9 ++++
 sound/usb/format.c          |    3 ++
 sound/usb/pcm.c             |  118 ++++++++++++++++++++++++++++++++++++-------
 sound/usb/quirks.c          |   28 ++++++++++
 sound/usb/quirks.h          |    4 ++
 10 files changed, 167 insertions(+), 19 deletions(-)

-- 
1.7.10.4
