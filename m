From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] HD-audio regmap support
Date: Fri, 27 Feb 2015 22:28:15 +0100
Message-ID: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C46652610A6
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 58C82ABED
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:28:27 +0000 (UTC)
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

this patch adds the regmap support to HD-audio and convert the
house-made amp/verb caches to regmap.  Because of the asymmetrical
nature of HD-audio verbs, the adaption of regmap isn't straightforward
at all, and has many limitations.  But this still reduces the
complexity in struct hda_codec a bit.

The patches are applied on top of the previous patch series (found in
topic/hda-bus branch of sound git tree).  This patchset is also found
in sound git tree topic/hda-regmap branch.


Takashi

===

Takashi Iwai (7):
  ALSA: hda - Add regmap support
  ALSA: hda - Use regmap for codec parameter reads
  ALSA: hda - Use regmap for amp accesses
  ALSA: hda - Use regmap for parameter caches, too
  ALSA: hda - Allow driver to add vendor-specific verbs for regmap
  ALSA: hda - Use regmap for command verb caches, too
  ALSA: hda - Reduce verbs during generic parser initialization

 sound/pci/hda/Kconfig          |   1 +
 sound/pci/hda/Makefile         |   3 +-
 sound/pci/hda/hda_beep.c       |   3 +-
 sound/pci/hda/hda_bind.c       |   6 +
 sound/pci/hda/hda_codec.c      | 645 +++++++----------------------------------
 sound/pci/hda/hda_codec.h      |  45 +--
 sound/pci/hda/hda_generic.c    |  32 +-
 sound/pci/hda/hda_jack.c       |   6 +-
 sound/pci/hda/hda_local.h      |  31 +-
 sound/pci/hda/hda_regmap.c     | 409 ++++++++++++++++++++++++++
 sound/pci/hda/hda_regmap.h     |  38 +++
 sound/pci/hda/patch_analog.c   |  30 +-
 sound/pci/hda/patch_conexant.c |  12 +-
 sound/pci/hda/patch_hdmi.c     |  24 +-
 sound/pci/hda/patch_realtek.c  |  11 +-
 sound/pci/hda/patch_si3054.c   |   5 +-
 sound/pci/hda/patch_sigmatel.c |  38 ++-
 17 files changed, 660 insertions(+), 679 deletions(-)
 create mode 100644 sound/pci/hda/hda_regmap.c
 create mode 100644 sound/pci/hda/hda_regmap.h

-- 
2.3.0
