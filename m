From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: assert failures in snd_pcm_mmap_commit
Date: Tue, 04 May 2004 23:32:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xvfjbj2t4.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

When playing music using alsa-lib sometimes, very rarely, the player
crashes and dumps core.  GDB gives me this stack trace:

#0  0xffffe410 in ?? ()
#1  0x4be05684 in ?? ()
#2  0x00000006 in ?? ()
#3  0x00007126 in ?? ()
#4  0x4007e859 in *__GI_raise (sig=3D6)
    at ../nptl/sysdeps/unix/sysv/linux/raise.c:66
#5  0x40080032 in *__GI_abort () at ../sysdeps/generic/abort.c:88
#6  0x4007805f in *__GI___assert_fail (assertion=3D0x0, file=3D0x0, line=3D=
0,=20
    function=3D0x48c9c136 "snd_pcm_mmap_commit") at assert.c:83
#7  0x48c3ef71 in snd_pcm_mmap_commit (pcm=3D0x81232f8, offset=3D3840, fram=
es=3D480)
    at pcm_local.h:289
#8  0x48c5307e in snd_pcm_rate_commit_next_period (pcm=3D0x80b0e68,=20
    appl_offset=3D6248) at pcm_rate.c:1005
#9  0x48c53397 in snd_pcm_rate_mmap_commit (pcm=3D0x80b0e68, offset=3D6028,=
=20
    size=3D220) at pcm_rate.c:1194
#10 0x48c3ef18 in snd_pcm_mmap_commit (pcm=3D0x80b0e68, offset=3D6028, fram=
es=3D440)
    at pcm.c:5920
#11 0x48c5716a in snd_pcm_mmap_write_areas (pcm=3D0x80b0e68, areas=3D0x4be0=
59b0,=20
    offset=3D0, size=3D440) at pcm_mmap.c:120
#12 0x48c3f373 in snd_pcm_write_areas (pcm=3D0x80b0e68, areas=3D0x4be059b0,=
=20
    offset=3D0, size=3D6380, func=3D0x48c57090 <snd_pcm_mmap_write_areas>)
    at pcm.c:6094
#13 0x48c57361 in snd_pcm_mmap_writei (pcm=3D0x80b0e68, buffer=3D0x0, size=
=3D0)
    at pcm_mmap.c:180
#14 0x48c381d2 in snd_pcm_writei (pcm=3D0x7126, buffer=3D0x80fb420, size=3D=
6500)
    at pcm_local.h:370
#15 0x48bfbb81 in alsa_write (ad=3D0x0, data=3D0x0, samples=3D0)
    at ../../tcvp/src/output/drivers/alsa/alsa.c:132
#16 0x4ae01689 in audio_play (p=3D0x80f56f0)
    at ../../tcvp/src/output/audio/audio.c:218
#17 0x4002b853 in start_thread (arg=3D0x0) at pthread_create.c:264
#18 0x4012e3aa in clone () from /lib/libc.so.6

I am using Linux 2.6.4 with ALSA driver 1.0.3 and alsa-lib 1.0.3a
(which I see now is a little out-dated).  The sound card is a SiS7012
in an Asus laptop.

Could this be caused by a bug in the player?

--=20
M=E5ns Rullg=E5rd
mru@kth.se


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
