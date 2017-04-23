From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Workarounds for HD-audio dual codecs
Date: Sun, 23 Apr 2017 21:00:21 +0200
Message-ID: <20170423190025.28911-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A8F06266ABC
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 21:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9B91BAAB9
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 19:00:32 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

recently the hardware vendors tend to put multiple codecs for the
onboard audio, and it causes a problem with the current HD-audio
auto-parser, as it supposes only a single codec.  With the multiple
codecs, some existing features are hard to implement, such as the
vmaster or the stream switching because basically the multiple codecs
mean to deal with multiple individual streams.

In this patchset, some workarounds are implemented to make the
multiple codecs more or less working.  In this mode, the single master
control or auto-mute/mic switching are disabled, and multiple PCM
streams are created depending on the I/O.  These differences have to
be handled via UCM, and for providing the unique setup, the card
longname is overridden in the quirk.


Takashi

===

Takashi Iwai (4):
  ALSA: hda - A new flag to enforce prefix to each pin
  ALSA: hda - Allow to enable/disable vmaster build explicitly
  ALSA: hda - Support Gigabyte Gaming board with dual Realtek codecs
  ALSA: hda - Use a helper function for renaming kctl names

 Documentation/sound/hd-audio/notes.rst |  2 +
 sound/pci/hda/hda_auto_parser.c        |  1 +
 sound/pci/hda/hda_codec.h              |  1 +
 sound/pci/hda/hda_generic.c            |  9 ++++-
 sound/pci/hda/hda_generic.h            |  1 +
 sound/pci/hda/patch_realtek.c          | 72 ++++++++++++++++++++++++++++++----
 6 files changed, 77 insertions(+), 9 deletions(-)

-- 
2.11.1
