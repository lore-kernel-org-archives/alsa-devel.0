From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 00/11] ALSA: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:54:16 -0400
Message-ID: <cover.1464709438.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: alsa-devel@alsa-project.org

The module_isa_driver macro is a helper macro for ISA drivers which do
not do anything special in module init/exit. This patchset eliminates a
lot of ISA driver registration boilerplate code by utilizing
module_isa_driver, which replaces module_init and module_exit.

William Breathitt Gray (11):
  ALSA: sb8: Utilize the module_isa_driver macro
  ALSA: jazz16: Utilize the module_isa_driver macro
  ALSA: ad1848: Utilize the module_isa_driver macro
  ALSA: cmi8328: Utilize the module_isa_driver macro
  ALSA: cs4231: Utilize the module_isa_driver macro
  ALSA: gusmax: Utilize the module_isa_driver macro
  ALSA: gusextreme: Utilize the module_isa_driver macro
  ALSA: gusclassic: Utilize the module_isa_driver macro
  ALSA: sc6000: Utilize the module_isa_driver macro
  ALSA: galaxy: Utilize the module_isa_driver macro
  ALSA: adlib: Utilize the module_isa_driver macro

 sound/isa/ad1848/ad1848.c  | 13 +------------
 sound/isa/adlib.c          | 13 +------------
 sound/isa/cmi8328.c        | 13 +------------
 sound/isa/cs423x/cs4231.c  | 13 +------------
 sound/isa/galaxy/galaxy.c  | 13 +------------
 sound/isa/gus/gusclassic.c | 13 +------------
 sound/isa/gus/gusextreme.c | 13 +------------
 sound/isa/gus/gusmax.c     | 13 +------------
 sound/isa/sb/jazz16.c      | 13 +------------
 sound/isa/sb/sb8.c         | 13 +------------
 sound/isa/sc6000.c         | 13 +------------
 11 files changed, 11 insertions(+), 132 deletions(-)

-- 
2.7.3
