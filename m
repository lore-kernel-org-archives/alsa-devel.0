From: Clemens Ladisch <clemens@ladisch.de>
Subject: [git pull] usb-audio: RME Babyface/Fireface fix
Date: Sat, 26 Jan 2013 17:56:33 +0100
Message-ID: <51040AC1.4080802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 6C696262601
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 17:57:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following change since commit 29594404d7fe73cd80eaa4ee8c43dcc53970c60e:

  Linux 3.7 (2012-12-10 19:30:57 -0800)

is available in the git repository at:

  git://git.alsa-project.org/alsa-kprivate.git usb-audio-fix

for you to fetch changes up to 5fcbad428a81efa318f15bfcfbcd8f0a98ec0b11:

  ALSA: usb-audio: fix invalid length check for RME and other UAC 2 devices (2013-01-26 17:49:35 +0100)

----------------------------------------------------------------
Clemens Ladisch (1):
      ALSA: usb-audio: fix invalid length check for RME and other UAC 2 devices

 sound/usb/mixer.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

ALSA: usb-audio: fix invalid length check for RME and other UAC 2 devices

Commit 23caaf19b11e (ALSA: usb-mixer: Add support for Audio Class v2.0)
forgot to adjust the length check for UAC 2.0 feature unit descriptors.
This would make the code abort on encountering a feature unit without
per-channel controls, and thus prevented the driver to work with any
device having such a unit, such as the RME Babyface or Fireface UCX.

Reported-by: Florian Hanisch <fhanisch@uni-potsdam.de>
Tested-by: Matthew Robbetts <wingfeathera@gmail.com>
Tested-by: Michael Beer <beerml@sigma6audio.de>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: 2.6.35+ <stable@vger.kernel.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 298070e..41e8bfb 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1259,16 +1259,23 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		}
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
+		if (hdr->bLength < 7 + csize) {
+			snd_printk(KERN_ERR "usbaudio: unit %u: "
+				   "invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 	} else {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;
 		csize = 4;
 		channels = (hdr->bLength - 6) / 4 - 1;
 		bmaControls = ftr->bmaControls;
-	}
-
-	if (hdr->bLength < 7 || !csize || hdr->bLength < 7 + csize) {
-		snd_printk(KERN_ERR "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n", unitid);
-		return -EINVAL;
+		if (hdr->bLength < 6 + csize) {
+			snd_printk(KERN_ERR "usbaudio: unit %u: "
+				   "invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 	}

 	/* parse the source unit */
