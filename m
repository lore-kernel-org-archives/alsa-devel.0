From: Olivier Trichet <nive@nivalis.org>
Subject: [PATCH] snd_mixer_poll_descriptors_revents: iterate
	over all descriptors
Date: Thu, 4 Aug 2011 12:06:19 +0200
Message-ID: <201108041206.19476.nive@nivalis.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b8mOO8W+Xid3Hmd"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bise.nivalis.org (can59-2-82-224-119-179.fbx.proxad.net
	[82.224.119.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B65924546
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 12:06:21 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--Boundary-00=_b8mOO8W+Xid3Hmd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello,

Reading the method snd_mixer_poll_descriptors_revents, it seems to me that the 
iteration over the array 'pfds' is wrong.
Shouldn't the attached patch be applied?

Regards,
Olivier

--Boundary-00=_b8mOO8W+Xid3Hmd
Content-Type: text/x-patch;
  charset="utf-8";
  name="0001-snd_mixer_poll_descriptors_revents-iterate-over-all-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="0001-snd_mixer_poll_descriptors_revents-iterate-over-all-.patch"

diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 85d843f..c3269ea 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -744,7 +744,7 @@ int snd_mixer_poll_descriptors_revents(snd_mixer_t *m=
ixer, struct pollfd *pfds,
 		return -EINVAL;
 	res =3D 0;
 	for (idx =3D 0; idx < nfds; idx++)
-		res |=3D pfds->revents & (POLLIN|POLLERR|POLLNVAL);
+		res |=3D pfds[i]->revents & (POLLIN|POLLERR|POLLNVAL);
 	*revents =3D res;
 	return 0;
 }

--Boundary-00=_b8mOO8W+Xid3Hmd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_b8mOO8W+Xid3Hmd--
