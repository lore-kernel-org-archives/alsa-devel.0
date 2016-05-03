From: Kangjie Lu <kangjielu@gmail.com>
Subject: [PATCH] infoleak fix1 in timer
Date: Tue,  3 May 2016 16:44:07 -0400
Message-ID: <1462308247-6178-1-git-send-email-kjlu@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, taesoo@gatech.edu, insu@gatech.edu, Kangjie Lu <kjlu@gatech.edu>
List-Id: alsa-devel@alsa-project.org

The stack object =E2=80=9Ctread=E2=80=9D has a total size of 32 bytes. =
Its field
=E2=80=9Cevent=E2=80=9D and =E2=80=9Cval=E2=80=9D both contain 4 bytes =
padding. These 8 bytes
padding bytes are sent to user without being initialized.

Signed-off-by: Kangjie Lu <kjlu@gatech.edu>
---
 sound/core/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6469bed..964f5eb 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1739,6 +1739,7 @@ static int snd_timer_user_params(struct file *fil=
e,
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
 			struct snd_timer_tread tread;
+			memset(&tread, 0, sizeof(tread));
 			tread.event =3D SNDRV_TIMER_EVENT_EARLY;
 			tread.tstamp.tv_sec =3D 0;
 			tread.tstamp.tv_nsec =3D 0;
--=20
1.9.1
