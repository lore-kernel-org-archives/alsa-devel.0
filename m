From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] sound: oss: make the function argument and structure const
Date: Fri, 13 Oct 2017 19:16:31 +0200
Message-ID: <1507914993-6015-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make the function argument of function sound_install_audiodrv const. 
After this change, make the structures audio_driver const as they are 
only passed to the const argument (made const in Patch[1/2])
of the function sound_install_audiodrv .

Bhumika Goyal (2):
  sound: oss: make the function argument as const
  sound: oss: make audio_driver structure const

 sound/oss/dev_table.c  | 2 +-
 sound/oss/dev_table.h  | 2 +-
 sound/oss/pas2_pcm.c   | 2 +-
 sound/oss/waveartist.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
