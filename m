From: Ralf Zink <ralfzink@freenet.de>
Subject: [PATCH] alsa-kernel/core/pcm_native.c
Date: Fri, 10 Oct 2003 16:06:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310101606.04477.ralfzink@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

When trying to open an already opened /dev/snd/pcmCxDx? up(&pcm->open_mutex)
is not called, so the next open calls hang forever.
I don=C2=B4t know, if there is a better place for the up call, but this wor=
ks.

Index: pcm_native.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
retrieving revision 1.82
diff -u -r1.82 pcm_native.c
=2D-- pcm_native.c        30 Sep 2003 09:28:26 -0000      1.82
+++ pcm_native.c        10 Oct 2003 10:34:44 -0000
@@ -1982,9 +1982,9 @@
                }
        }
        remove_wait_queue(&pcm->open_wait, &wait);
+       up(&pcm->open_mutex);
        if (err < 0)
                goto __error;
=2D       up(&pcm->open_mutex);
        return err;

       __error:

mfg Ralf Zink


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
