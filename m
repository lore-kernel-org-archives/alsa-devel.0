From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 0/7] USB Audio Device Class 3.0 BADD
	profiles support
Date: Fri,  4 May 2018 04:23:57 +0300
Message-ID: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E0E38266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 03:24:49 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id m18-v6so28661266lfb.0
 for <alsa-devel@alsa-project.org>; Thu, 03 May 2018 18:24:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, Andrew Chant <achant@google.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds BADD profiles support from the USB Audio
Device Class 3.0 spec [1].

BADD profile support is defined as mandatory feature of
UAC3-compliant device, it should be implemented as a separate
USB configuration.

Notable issue with BADD configuration is that it misses
class-specific descriptors (and it's mandatory as per spec),
so host should guess them from BADD profile number and
parameters of endpoints (type, number of endpoints and
max packet size)

This patchset adds support of all known/existing BADD profiles
from the UAC3 specification.

First 5 patches are refactoring and improvements, and last 2
patches actually implement UAC3 BADD profiles support.

It's an alternative implementation comparing to [2],
and doesn't build usb descriptors on the host but instead
initializes alsa-usb structures with known parameters,
so we don't need to keep whole class-specific descriptors
in the driver since we anyway need to have BADD-specific
logic.

I've picked one Jorge's UAC1 patch-improvement and
updated it to v4.17 wich contais recently introduced
header's sanity checks.

Remaining part is to add interrupt endpoint support
so we will be able to detect jack insertion in
the Headset Adapter profile.

This has been tested on ARM and x86-64 machines with
custom UAC3 gadget which I'll post later to linux-usb

Comments and testing are welcome.

v2:
  - split refactoring patch to more atomic and bisectable
    changes as suggested by Takashi
  - renamed "Side Tone"->"Sidetone" as suggested by Andrew
  - revorked main BADD patch to have table lookup for
    checking BADD channels validity and to reduce identation
    as suggested by Takashi
  - also removed code duplication in BADD patch by reusing
    common part of build_feature_ctl() func

v1: http://mailman.alsa-project.org/pipermail/alsa-devel/2018-April/134412.html


[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] https://www.spinics.net/lists/alsa-devel/msg71614.html

Jorge Sanjuan (1):
  ALSA: usb: Only get AudioControl header for UAC1 class.

Ruslan Bilovol (6):
  ALSA: usb: stream: move audioformat alloc/init into separate function
  ALSA: usb: stream: refactor uac1/2 audio interface parsing
  ALSA: usb: stream: refactor uac3 audio interface parsing
  ALSA: usb: mixer: make string parsing independent of mixer_build state
  include: usb: audio-v3: add BADD-specific values
  ALSA: usb: add UAC3 BADD profiles support

 include/linux/usb/audio-v3.h |  26 ++
 sound/usb/card.c             |  53 ++--
 sound/usb/clock.c            |   9 +-
 sound/usb/mixer.c            | 351 +++++++++++++++++++---
 sound/usb/mixer_maps.c       |  65 ++++
 sound/usb/stream.c           | 687 +++++++++++++++++++++++++------------------
 sound/usb/usbaudio.h         |   2 +
 7 files changed, 849 insertions(+), 344 deletions(-)

-- 
1.9.1
