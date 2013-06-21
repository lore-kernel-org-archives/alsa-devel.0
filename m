From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH 0/4] ALSA: usb: misc consistency fixes
Date: Fri, 21 Jun 2013 13:11:47 +0200
Message-ID: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Torsten Schenk <torsten.schenk@zoho.com>, Daniel Mack <daniel@caiaq.de>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Hi,

when working on the hiFace driver (which I plan on re-sending later
today BTW) I've been reading the code of other drivers and I've stumbled
on a couple of minor inconsistencies which were also spotted during the
review rounds for the hiFace driver.

I am sending some patches to address these issues, so that new drivers
authors won't do the same mistakes I did when copying code over.

Please take a closer look at the ones about vmalloc buffers, do we need
an actual Tested-by for these?

Patches are against 3.10-rc6.

Thanks,
   Antonio

Antonio Ospite (4):
  ALSA: snd-usb-caiaq: remove the unused snd_card_used variable
  ALSA: snd-usb-caiaq: use vmalloc buffers
  ALSA: snd-usb-6fire: use vmalloc buffers
  ALSA: usb: uniform style used in MODULE_SUPPORTED_DEVICE()

 sound/usb/6fire/chip.c     |  2 +-
 sound/usb/6fire/pcm.c      | 12 +++++-------
 sound/usb/caiaq/audio.c    | 12 +++++-------
 sound/usb/caiaq/device.c   | 31 +++++++++++++++----------------
 sound/usb/usx2y/usbusx2y.c |  2 +-
 5 files changed, 27 insertions(+), 32 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
