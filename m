From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/30] Modernize documents
Date: Thu, 10 Nov 2016 22:06:11 +0100
Message-ID: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B8612673BA
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 85B36ADD3
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:52 +0000 (UTC)
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

this is a patch set to convert most of document files in
Documentation/sound/alsa/ and Documentation/DocBook/ to the ReST
format that has been recently introduced.

The files are moved to a few different subdirectories depending on the
contents, with renames to lower letters to be more consistent.

I didn't try to correct / update the contents unless really needed,
but only concentrate on reformatting.   Most of changes are trivial,
and can be seen easily in git diff.  Some are more intrusive (e.g. the
conversion from DocBook or HTML).

The ASoC documents aren't included in this patch set.  They will
follow later.

The latest changes are found in topic/restize-docs branch of my sound
git tree.


Takashi

===

Takashi Iwai (30):
  ALSA: doc: Remove alsa-parameters.txt
  ALSA: doc: ReSTize alsa-driver-api document
  ALSA: doc: ReSTize writing-an-alsa-driver document
  ALSA: doc: ReSTize HD-Audio document
  ALSA: doc: ReSTize HD-Audio-Models document
  ALSA: doc: ReSTize HD-Audio-Controls document
  ALSA: doc: ReSTize HD-Audio-DP-MST-audio.txt
  ALSA: doc: ReSTize ALSA-Configuration document
  ALSA: doc: ReSTize Procfile document
  ALSA: doc: ReSTize powersave document
  ALSA: doc: ReSTize Channel-Mapping-API document
  ALSA: doc: ReSTize OSS-Emulation document
  ALSA: doc: ReSTize seq_oss document
  ALSA: doc: ReSTize ControlNames.txt
  ALSA: doc: ReSTize compress-offload document
  ALSA: doc: ReSTize timestamping document
  ALSA: doc: ReSTize Jack-Controls.txt
  ALSA: doc: ReSTize Joystick document
  ALSA: doc: ReSTize CMIPCI document
  ALSA: doc: ReSTize SB-Live-mixer document
  ALSA: doc: ReSTize Audigy-mixer.txt
  ALSA: doc: ReSTize emu10k1-jack.txt
  ALSA: doc: ReSTize VIA82xx-mixer.txt
  ALSA: doc: ReSTize Audiophile-USB.txt
  ALSA: doc: ReSTize MIXART.txt
  ALSA: doc: ReSTize Bt87x.txt
  ALSA: doc: ReSTize README.maya44
  ALSA: doc: ReSTize hdspm.txt
  ALSA: doc: ReSTize serial-u16550.txt
  ALSA: doc: ReSTize img,spdif-in.txt

 Documentation/DocBook/Makefile                     |    3 +-
 Documentation/DocBook/alsa-driver-api.tmpl         |  142 -
 Documentation/DocBook/writing-an-alsa-driver.tmpl  | 6206 --------------------
 Documentation/index.rst                            |    1 +
 Documentation/sound/alsa-configuration.rst         | 2683 +++++++++
 Documentation/sound/alsa/ALSA-Configuration.txt    | 2330 --------
 Documentation/sound/alsa/ControlNames.txt          |  107 -
 Documentation/sound/alsa/HD-Audio-Models.txt       |  324 -
 Documentation/sound/alsa/VIA82xx-mixer.txt         |    8 -
 Documentation/sound/alsa/alsa-parameters.txt       |  135 -
 Documentation/sound/alsa/seq_oss.html              |  409 --
 .../Audigy-mixer.txt => cards/audigy-mixer.rst}    |  297 +-
 .../audiophile-usb.rst}                            |  258 +-
 .../sound/{alsa/Bt87x.txt => cards/bt87x.rst}      |   23 +-
 .../sound/{alsa/CMIPCI.txt => cards/cmipci.rst}    |   62 +-
 .../emu10k1-jack.txt => cards/emu10k1-jack.rst}    |   20 +-
 .../sound/{alsa/hdspm.txt => cards/hdspm.rst}      |  253 +-
 .../img,spdif-in.txt => cards/img-spdif-in.rst}    |   24 +-
 Documentation/sound/cards/index.rst                |   19 +
 .../{alsa/Joystick.txt => cards/joystick.rst}      |   71 +-
 .../sound/{alsa/README.maya44 => cards/maya44.rst} |  137 +-
 .../sound/{alsa/MIXART.txt => cards/mixart.rst}    |   26 +-
 .../SB-Live-mixer.txt => cards/sb-live-mixer.rst}  |  337 +-
 .../serial-u16550.txt => cards/serial-u16550.rst}  |   21 +-
 Documentation/sound/cards/via82xx-mixer.rst        |    8 +
 .../channel-mapping-api.rst}                       |   77 +-
 .../compress-offload.rst}                          |  127 +-
 Documentation/sound/designs/control-names.rst      |  142 +
 Documentation/sound/designs/index.rst              |   15 +
 .../jack-controls.rst}                             |   13 +-
 .../oss-emulation.rst}                             |  169 +-
 .../{alsa/powersave.txt => designs/powersave.rst}  |   16 +-
 .../{alsa/Procfile.txt => designs/procfile.rst}    |  106 +-
 Documentation/sound/designs/seq-oss.rst            |  371 ++
 .../timestamping.txt => designs/timestamping.rst}  |  143 +-
 .../controls.rst}                                  |   33 +-
 .../dp-mst.rst}                                    |   30 +-
 Documentation/sound/hd-audio/index.rst             |   10 +
 Documentation/sound/hd-audio/models.rst            |  518 ++
 .../{alsa/HD-Audio.txt => hd-audio/notes.rst}      |  635 +-
 Documentation/sound/index.rst                      |   19 +
 Documentation/sound/kernel-api/alsa-driver-api.rst |  134 +
 Documentation/sound/kernel-api/index.rst           |    8 +
 .../sound/kernel-api/writing-an-alsa-driver.rst    | 4219 +++++++++++++
 44 files changed, 9766 insertions(+), 10923 deletions(-)
 delete mode 100644 Documentation/DocBook/alsa-driver-api.tmpl
 delete mode 100644 Documentation/DocBook/writing-an-alsa-driver.tmpl
 create mode 100644 Documentation/sound/alsa-configuration.rst
 delete mode 100644 Documentation/sound/alsa/ALSA-Configuration.txt
 delete mode 100644 Documentation/sound/alsa/ControlNames.txt
 delete mode 100644 Documentation/sound/alsa/HD-Audio-Models.txt
 delete mode 100644 Documentation/sound/alsa/VIA82xx-mixer.txt
 delete mode 100644 Documentation/sound/alsa/alsa-parameters.txt
 delete mode 100644 Documentation/sound/alsa/seq_oss.html
 rename Documentation/sound/{alsa/Audigy-mixer.txt => cards/audigy-mixer.rst} (57%)
 rename Documentation/sound/{alsa/Audiophile-Usb.txt => cards/audiophile-usb.rst} (81%)
 rename Documentation/sound/{alsa/Bt87x.txt => cards/bt87x.rst} (82%)
 rename Documentation/sound/{alsa/CMIPCI.txt => cards/cmipci.rst} (86%)
 rename Documentation/sound/{alsa/emu10k1-jack.txt => cards/emu10k1-jack.rst} (89%)
 rename Documentation/sound/{alsa/hdspm.txt => cards/hdspm.rst} (56%)
 rename Documentation/sound/{alsa/img,spdif-in.txt => cards/img-spdif-in.rst} (68%)
 create mode 100644 Documentation/sound/cards/index.rst
 rename Documentation/sound/{alsa/Joystick.txt => cards/joystick.rst} (56%)
 rename Documentation/sound/{alsa/README.maya44 => cards/maya44.rst} (65%)
 rename Documentation/sound/{alsa/MIXART.txt => cards/mixart.rst} (83%)
 rename Documentation/sound/{alsa/SB-Live-mixer.txt => cards/sb-live-mixer.rst} (54%)
 rename Documentation/sound/{alsa/serial-u16550.txt => cards/serial-u16550.rst} (92%)
 create mode 100644 Documentation/sound/cards/via82xx-mixer.rst
 rename Documentation/sound/{alsa/Channel-Mapping-API.txt => designs/channel-mapping-api.rst} (75%)
 rename Documentation/sound/{alsa/compress_offload.txt => designs/compress-offload.rst} (73%)
 create mode 100644 Documentation/sound/designs/control-names.rst
 create mode 100644 Documentation/sound/designs/index.rst
 rename Documentation/sound/{alsa/Jack-Controls.txt => designs/jack-controls.rst} (86%)
 rename Documentation/sound/{alsa/OSS-Emulation.txt => designs/oss-emulation.rst} (70%)
 rename Documentation/sound/{alsa/powersave.txt => designs/powersave.rst} (76%)
 rename Documentation/sound/{alsa/Procfile.txt => designs/procfile.rst} (71%)
 create mode 100644 Documentation/sound/designs/seq-oss.rst
 rename Documentation/sound/{alsa/timestamping.txt => designs/timestamping.rst} (56%)
 rename Documentation/sound/{alsa/HD-Audio-Controls.txt => hd-audio/controls.rst} (92%)
 rename Documentation/sound/{alsa/HD-Audio-DP-MST-audio.txt => hd-audio/dp-mst.rst} (69%)
 create mode 100644 Documentation/sound/hd-audio/index.rst
 create mode 100644 Documentation/sound/hd-audio/models.rst
 rename Documentation/sound/{alsa/HD-Audio.txt => hd-audio/notes.rst} (61%)
 create mode 100644 Documentation/sound/index.rst
 create mode 100644 Documentation/sound/kernel-api/alsa-driver-api.rst
 create mode 100644 Documentation/sound/kernel-api/index.rst
 create mode 100644 Documentation/sound/kernel-api/writing-an-alsa-driver.rst

-- 
2.10.2
