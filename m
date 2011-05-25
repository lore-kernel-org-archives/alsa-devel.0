From: Daniel Mack <zonque@gmail.com>
Subject: Patch series for Fast Track Ultra mixer quirks
Date: Wed, 25 May 2011 09:08:58 +0200
Message-ID: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C621A103800
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Here's the set of patches to make Fast Track Ultra mixer quirks possible.
It's just a split version of the patch we've discussed on the ALSA ML
before.

These patches can as well be pulled from

  git@github.com:zonque/linux-2.6.git usb-audio

Daniel Mack (5):
      ALSA: usb-audio: move assignment of chip->ctrl_intf
      ALSA: usb-audio: rework add_control_to_empty()
      ALSA: usb-audio: export snd_usb_feature_unit_ctl
      ALSA: usb-audio: add new quirk type QUIRK_AUDIO_STANDARD_MIXER
      ALSA: usb-audio: more control quirks for M-Audio FastTrack devices

 sound/usb/card.c         |   17 ++++++-----
 sound/usb/mixer.c        |   32 ++++++++------------
 sound/usb/mixer.h        |   14 ++++++++-
 sound/usb/mixer_quirks.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |    4 +-
 sound/usb/quirks.c       |   18 +++++++++++-
 sound/usb/usbaudio.h     |    1 +
 7 files changed, 125 insertions(+), 31 deletions(-)
