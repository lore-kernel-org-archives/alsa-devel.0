From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/3] ALSA: snd-usb: Some small fixes to make
	Playback Design products work
Date: Sun, 17 Mar 2013 20:07:23 +0800
Message-ID: <1363522047-7515-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 43137265172
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 13:07:41 +0100 (CET)
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

Thanks to Andreas, I got my hands on a Playback Design MPD-3 and hacked
up some small hanges necessary to make it fully work with snd-usb.

The device reports 0x80000000 in the bmFormats field of two of three of
its alternate settings, which wrongly made the driver believe it's a
usual PCM endpoint (actually due to a fix-up fallback). However, bit 31
of this mask in fact denotes 'raw data'.

The effect of this issue is that in addition to the first altsetting with
a bit depth of 24, the driver exposed 8-bit and 16-bit native audio
formats on the raw data endpoints, which do not work as expected.

Also, those devices need a 50ms delay after switching the USB interface.


Thanks,
Daniel


Daniel Mack (3):
  ALSA: snd-usb: handle the bmFormats field as unsigned int
  ALSA: snd-usb: handle raw data format of UAC2 devices
  ALSA: snd-usb: add delay quirk for "Playback Design" products

 include/linux/usb/audio-v2.h |    2 ++
 sound/usb/format.c           |   20 ++++++++++++--------
 sound/usb/format.h           |    2 +-
 sound/usb/pcm.c              |    7 +++++++
 sound/usb/stream.c           |    2 +-
 5 files changed, 23 insertions(+), 10 deletions(-)

-- 
1.7.10.4
