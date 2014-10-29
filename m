From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH v3 0/4] Scarlett mixer interface inclusion
Date: Wed, 29 Oct 2014 15:55:59 -0500
Message-ID: <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
References: <s5h1tq0egzi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B68C526057C
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:56:08 +0100 (CET)
In-Reply-To: <s5h1tq0egzi.wl-tiwai@suse.de>
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
Cc: tiwai@suse.de, th55@gmx.de, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This is v3 of the patchset to merge what Tobias Hoffman and Robin Gareus have
done to enable the Focusrite Scarlett mixers for use with ALSA.

I have split the commits into hopefully a logical series. First the original
quirk is reverted for one model of a Scarlett device. Next an additional
structure is added to be able to more easily reuse usb_mixer_elem_info.
After this mixer functions that were useful to this code were made public.
Finally the last patch adds the necessary functions to make this mixer work.

I have only tested this on my own device which is a Focusrite Scarlett 18i8, 
any additional testing would be appreciated.

Chris J Arges (4):
  Revert "ALSA: usb-audio: Add quirk for Focusrite Scarlett
  ALSA: usb-audio: Add usb_mixer_elem_enum_info
  ALSA: usb-audio: make set_*_mix_values functions public
  ALSA: usb-audio: Scarlett mixer interface for 6i6, 18i6, 18i8 and
    18i20

 sound/usb/Makefile         |    1 +
 sound/usb/mixer.c          |   34 +-
 sound/usb/mixer.h          |   15 +
 sound/usb/mixer_quirks.c   |   18 +-
 sound/usb/mixer_scarlett.c | 1110 ++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_scarlett.h |    6 +
 sound/usb/quirks-table.h   |   51 --
 7 files changed, 1159 insertions(+), 76 deletions(-)
 create mode 100644 sound/usb/mixer_scarlett.c
 create mode 100644 sound/usb/mixer_scarlett.h

-- 
2.1.0
