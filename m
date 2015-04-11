From: Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH] ALSA: hda - Add dock support for ThinkPad X250
Date: Sat, 11 Apr 2015 09:31:34 +0200
Message-ID: <1428737495-9906-1-git-send-email-corsac@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Arnaud Ebalard <arno@natisbad.org>, Yves-Alexis Perez <corsac@debian.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I recently bought a 2015 ThinkPad (X250) along with a dockstation (ThinkPad
Ultra dock). The audio output (mini-jack) doesn't work on the dock station, but
after some research it seems that the snd_hda_intel module just miss the
correct pin configuration.

This pin configuration seems shared between 2014 and 2015 ThinkPads, so this
patch just add the same quirk for the X250 subsystem product id.

After that, the audio output works fine on the internal speakers, on the laptop
output jack and on the dockstation output jack.

I didn't add the CC: stable@vger.kernel.org because I'm unsure how the ALSA
maintainers stand on this, but similar previous patches have been targeted to
stable so it might be worth adding it.

Regards,
-- 
Yves-Alexis Perez

Yves-Alexis Perez (1):
  ALSA: hda - Add dock support for ThinkPad X250 (17aa:2226)

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.1.4
