From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Memory leaks in alsa-lib
Date: Mon, 25 Aug 2003 18:07:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xznhxpvou.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Is there a memory leak in alsa-lib?  When playing music with a player
I'm writing (TCVP, http://tcvp.sf.net), the memory usage reported by
top grows for each file I play, but only if I use ALSA for sound
playback.  If I use OSS the memory usage varies around 1.5 MB, but if
I use ALSA, it starts at 1.9 MB (OK, libasound takes some space) and
grows by 30-40 kB for each played file.  Running the whole thing under
valgrind gives me this, which is all alsa-related.  When using OSS,
valgrind reports no leaks.

=3D=3D3078=3D=3D 8 bytes in 1 blocks are still reachable in loss record 1=
 of 20
=3D=3D3078=3D=3D    at 0x4002AC23: calloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:273)
=3D=3D3078=3D=3D    by 0x4377069D: snd_config_update_r (conf.c:2953)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)
=3D=3D3078=3D=3D    by 0x424D7AC9: t_event (../../../../tcvp/src/tcvp/tcv=
p.c:581)
=3D=3D3078=3D=3D    by 0x402737B3: thread_wrapper (../../../valgrind/core=
grind/vg_libpthread.c:667)
=3D=3D3078=3D=3D    by 0x40175153: do__quit (../../../valgrind/coregrind/=
vg_scheduler.c:2146)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 20 bytes in 1 blocks are still reachable in loss record =
6 of 20
=3D=3D3078=3D=3D    at 0x4002AC23: calloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:273)
=3D=3D3078=3D=3D    by 0x437706DC: snd_config_update_r (conf.c:2957)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)
=3D=3D3078=3D=3D    by 0x424D7AC9: t_event (../../../../tcvp/src/tcvp/tcv=
p.c:581)
=3D=3D3078=3D=3D    by 0x402737B3: thread_wrapper (../../../valgrind/core=
grind/vg_libpthread.c:667)
=3D=3D3078=3D=3D    by 0x40175153: do__quit (../../../valgrind/coregrind/=
vg_scheduler.c:2146)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 48 bytes in 5 blocks are still reachable in loss record =
8 of 20
=3D=3D3078=3D=3D    at 0x4002A745: malloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:153)
=3D=3D3078=3D=3D    by 0x4376C5E2: get_delimstring (conf.c:769)
=3D=3D3078=3D=3D    by 0x4376C6BF: get_string (conf.c:819)
=3D=3D3078=3D=3D    by 0x4376C968: parse_value (conf.c:896)
=3D=3D3078=3D=3D    by 0x4376CCB7: parse_array_def (conf.c:1029)
=3D=3D3078=3D=3D    by 0x4376CE7B: parse_array_defs (conf.c:1051)
=3D=3D3078=3D=3D    by 0x4376D16F: parse_def (conf.c:1170)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376CD90: parse_array_def (conf.c:1008)
=3D=3D3078=3D=3D    by 0x4376CE7B: parse_array_defs (conf.c:1051)
=3D=3D3078=3D=3D    by 0x4376D16F: parse_def (conf.c:1170)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376CD90: parse_array_def (conf.c:1008)
=3D=3D3078=3D=3D    by 0x4376CE7B: parse_array_defs (conf.c:1051)
=3D=3D3078=3D=3D    by 0x4376D16F: parse_def (conf.c:1170)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376DE43: snd_config_load1 (conf.c:1544)
=3D=3D3078=3D=3D    by 0x4376DFDF: snd_config_load (conf.c:1593)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 173 bytes in 69 blocks are still reachable in loss recor=
d 10 of 20
=3D=3D3078=3D=3D    at 0x4002A745: malloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:153)
=3D=3D3078=3D=3D    by 0x4030B0CF: __GI___strdup (in /lib/libc-2.3.1.so)
=3D=3D3078=3D=3D    by 0x437707DC: snd_config_update_r (conf.c:2979)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)
=3D=3D3078=3D=3D    by 0x424D7AC9: t_event (../../../../tcvp/src/tcvp/tcv=
p.c:581)
=3D=3D3078=3D=3D    by 0x402737B3: thread_wrapper (../../../valgrind/core=
grind/vg_libpthread.c:667)
=3D=3D3078=3D=3D    by 0x40175153: do__quit (../../../valgrind/coregrind/=
vg_scheduler.c:2146)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 4820 bytes in 643 blocks are still reachable in loss rec=
ord 16 of 20
=3D=3D3078=3D=3D    at 0x4002A745: malloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:153)
=3D=3D3078=3D=3D    by 0x4376C45B: get_freestring (conf.c:711)
=3D=3D3078=3D=3D    by 0x4376C6EE: get_string (conf.c:825)
=3D=3D3078=3D=3D    by 0x4376CF1F: parse_def (conf.c:1086)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376DE43: snd_config_load1 (conf.c:1544)
=3D=3D3078=3D=3D    by 0x4376DFDF: snd_config_load (conf.c:1593)
=3D=3D3078=3D=3D    by 0x437709C5: snd_config_update_r (conf.c:3054)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)
=3D=3D3078=3D=3D    by 0x424D7AC9: t_event (../../../../tcvp/src/tcvp/tcv=
p.c:581)
=3D=3D3078=3D=3D    by 0x402737B3: thread_wrapper (../../../valgrind/core=
grind/vg_libpthread.c:667)
=3D=3D3078=3D=3D    by 0x40175153: do__quit (../../../valgrind/coregrind/=
vg_scheduler.c:2146)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 5504 bytes in 172 blocks are still reachable in loss rec=
ord 17 of 20
=3D=3D3078=3D=3D    at 0x4002AC23: calloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:273)
=3D=3D3078=3D=3D    by 0x4376C73A: _snd_config_make (conf.c:836)
=3D=3D3078=3D=3D    by 0x4376DD52: snd_config_top (conf.c:1525)
=3D=3D3078=3D=3D    by 0x43770927: snd_config_update_r (conf.c:3045)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)
=3D=3D3078=3D=3D    by 0x424D7AC9: t_event (../../../../tcvp/src/tcvp/tcv=
p.c:581)
=3D=3D3078=3D=3D    by 0x402737B3: thread_wrapper (../../../valgrind/core=
grind/vg_libpthread.c:667)
=3D=3D3078=3D=3D    by 0x40175153: do__quit (../../../valgrind/coregrind/=
vg_scheduler.c:2146)
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D=20
=3D=3D3078=3D=3D 9024 bytes in 282 blocks are possibly lost in loss recor=
d 19 of 20
=3D=3D3078=3D=3D    at 0x4002AC23: calloc (../../../valgrind/coregrind/vg=
_replace_malloc.c:273)
=3D=3D3078=3D=3D    by 0x4376C73A: _snd_config_make (conf.c:836)
=3D=3D3078=3D=3D    by 0x4376C80B: _snd_config_make_add (conf.c:862)
=3D=3D3078=3D=3D    by 0x4376CA4D: parse_value (conf.c:956)
=3D=3D3078=3D=3D    by 0x4376D0F3: parse_def (conf.c:1184)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376CD90: parse_array_def (conf.c:1008)
=3D=3D3078=3D=3D    by 0x4376CE7B: parse_array_defs (conf.c:1051)
=3D=3D3078=3D=3D    by 0x4376D16F: parse_def (conf.c:1170)
=3D=3D3078=3D=3D    by 0x4376D34D: parse_defs (conf.c:1213)
=3D=3D3078=3D=3D    by 0x4376DE43: snd_config_load1 (conf.c:1544)
=3D=3D3078=3D=3D    by 0x4376DFDF: snd_config_load (conf.c:1593)
=3D=3D3078=3D=3D    by 0x437709C5: snd_config_update_r (conf.c:3054)
=3D=3D3078=3D=3D    by 0x43770D67: snd_config_update (conf.c:3095)
=3D=3D3078=3D=3D    by 0x43789CC6: snd_pcm_open (pcm.c:1929)
=3D=3D3078=3D=3D    by 0x4373C262: alsa_open (../../../../../tcvp/src/out=
put/alsa/alsa.c:355)
=3D=3D3078=3D=3D    by 0x424D6E13: new_pipe (../../../../tcvp/src/tcvp/tc=
vp.c:328)
=3D=3D3078=3D=3D    by 0x424D76B9: t_open (../../../../tcvp/src/tcvp/tcvp=
.c:453)


--=20
M=E5ns Rullg=E5rd
mru@users.sf.net


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
