From: Kangjie Lu <kangjielu@gmail.com>
Subject: [PATCH] infoleak fix2 in timer
Date: Tue,  3 May 2016 16:44:20 -0400
Message-ID: <1462308260-6219-1-git-send-email-kjlu@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, taesoo@gatech.edu, insu@gatech.edu, Kangjie Lu <kjlu@gatech.edu>
List-Id: alsa-devel@alsa-project.org

The stack object =E2=80=9Cr1=E2=80=9D has a total size of 32 bytes. Its=
 field
=E2=80=9Cevent=E2=80=9D and =E2=80=9Cval=E2=80=9D both contain 4 bytes =
padding. These 8 bytes
padding bytes are sent to user without being initialized.

Signed-off-by: Kangjie Lu <kjlu@gatech.edu>
---
 sound/core/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 964f5eb..e98fa5f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1225,6 +1225,7 @@ static void snd_timer_user_ccallback(struct snd_t=
imer_instance *timeri,
 		tu->tstamp =3D *tstamp;
 	if ((tu->filter & (1 << event)) =3D=3D 0 || !tu->tread)
 		return;
+	memset(&r1, 0, sizeof(r1));
 	r1.event =3D event;
 	r1.tstamp =3D *tstamp;
 	r1.val =3D resolution;
--=20
1.9.1
