From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/16] ALSA: hda - GPIO cleanups
Date: Fri, 22 Jun 2018 11:53:36 +0200
Message-ID: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 101002676DD
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:54 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 482EAADC6
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
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

this is a series of cleanup patches for GPIO handlings in HD-audio
codec drivers.  Not really fixing bugs but mostly for straightening
the code flow.


Takashi

===

Takashi Iwai (16):
  ALSA: hda/realtek - Allow skipping spec->init_amp detection
  ALSA: hda/realtek - Manage GPIO bits commonly
  ALSA: hda/realtek - Add GPIO data update helper
  ALSA: hda/realtek - Consolidate gpio_data and gpio_led
  ALSA: hda/realtek - Simplify alc885_fixup_macpro_gpio()
  ALSA: hda/realtek - Simplify mute LED GPIO handling
  ALSA: hda/realtek - Convert some manual GPIO setups
  ALSA: hda/realtek - Simplify Dell XPS13 GPIO handling
  ALSA: hda/realtek - Use common GPIO mask for ALC660VD ASUS fixup
  ALSA: hda/realtek - Use common helper for creating ALC268 beep
    controls
  ALSA: hda/realtek - Use common helper for creating beep controls
  ALSA: hda/conexant - Clean up beep code
  ALSA: hda/cirrus - Simplify creation of new controls
  ALSA: hda/via - Rewrite with error goto
  ALSA: hda/via - Simplify control management
  ALSA: hda/via - Use standard verb containers

 sound/pci/hda/patch_cirrus.c   |  29 +-
 sound/pci/hda/patch_conexant.c |  85 ++---
 sound/pci/hda/patch_realtek.c  | 639 +++++++++++++++------------------
 sound/pci/hda/patch_via.c      | 294 +++++++--------
 4 files changed, 462 insertions(+), 585 deletions(-)

-- 
2.17.1
