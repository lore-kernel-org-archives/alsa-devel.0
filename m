From: Andrew Chant <achant@google.com>
Subject: [PATCH v3 0/2] UAC2 jack detection and clock validity
Date: Fri, 23 Mar 2018 19:25:22 -0700
Message-ID: <20180324022524.227748-1-achant@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A930266B67
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 03:25:52 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id u5so5422694pfh.6
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 19:25:52 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Andrew Chant <achant@google.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

These patches implement UAC2 jack detection.

This allows USB-to-3.5mm adapters and similar USB devices
to report jack state via alsa control, using the reporting
provided by the UAC2 connector control.

The second patch updates the clock validity control so
it doesn't show up in mixer UIs.

I declined to mark the controls as VOLATILE since clients
should always be notified of changes, since UAC devices
are expected to generate interrupt messages when a control
value changes.

v3 changes:
 - move channel count correction to first patch.
 - fix incorrect comment formatting and spacing.

v2 changes:
 - use SNDRV_CTL_ELEM_IFACE_CARD instead of _MIXER
 - correct channel count to 1, cmask to 0.
 - add validity patch.

Andrew Chant (2):
  ALSA: usb-audio: UAC2 jack detection
  ALSA: usb-audio: update clock valid control

 sound/usb/mixer.c | 117 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 8 deletions(-)

-- 
2.17.0.rc0.231.g781580f067-goog
