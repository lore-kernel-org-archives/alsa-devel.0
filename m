From: Andreas Irestal <andreas.irestal@axis.com>
Subject: [PATCH] ASoC: codecs: tlv320aic3x: Remove deadlock
	from snd_soc_dapm_put_volsw_aic3x()
Date: Wed, 5 Jun 2013 08:49:47 +0200
Message-ID: <201306050849.47726.Andreas.Irestal@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E7426167E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by anubis.se.axis.com (Postfix) with ESMTP id E204B19E15
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:50 +0200 (CEST)
Received: from anubis.se.axis.com ([127.0.0.1])
 by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id bs0hfkGgKVXZ for <alsa-devel@alsa-project.org>;
 Wed,  5 Jun 2013 08:49:50 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
 by anubis.se.axis.com (Postfix) with ESMTP id 18C5519E11
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:49 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 230A3581
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:49 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.localdomain (Postfix) with ESMTP id 1833E347
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:49 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 16AE73E06D
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:49:49 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Andreas Irest=E5l <Andreas.Irestal@axis.com>

When calling snd_soc_dapm_sync(), it eventually tries to lock the same mutex
already locked in snd_soc_dapm_put_volsw_aic3x() and a deadlock occurs. By
moving the mutex unlock to just before snd_soc_dapm_sync(), this deadlock is
prevented. This problem was introduced in Linux 3.5

Signed-off-by: Andreas Irest=E5l <Andreas.Irestal@axis.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 65d09d6..1514bf8 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -187,14 +187,14 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kc=
ontrol *kcontrol,
 =

 			break;
 		}
-
-		if (found)
-			snd_soc_dapm_sync(widget->dapm);
 	}
 =

-	ret =3D snd_soc_update_bits(widget->codec, reg, val_mask, val);
-
 	mutex_unlock(&widget->codec->mutex);
+
+	if (found)
+		snd_soc_dapm_sync(widget->dapm);
+
+	ret =3D snd_soc_update_bits_locked(widget->codec, reg, val_mask, val);
 	return ret;
 }
 =
