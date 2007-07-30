From: Susovan Ghosh <susovan@tataelxsi.co.in>
Subject: problem to build alsa shared library for arm platform
Date: Mon, 30 Jul 2007 09:38:58 +0530
Message-ID: <000201c7d25f$5b539980$9529320a@telxsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 053A1103803
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 06:07:22 +0200 (CEST)
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



Hi All,

 we want to use alsa library for arm platform.
  while configuration we specified option for shared library.
  but its alwaye creating static library after compilation.
  when we build the test application pcm_min.c we got the
  following error.

   /usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0x194): In function
`snd_pcm_ladspa_free_plugins':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:188:
undefined reference to `dlclose'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xd28): In function
`snd_pcm_ladspa_connect_controls':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:515:
undefined reference to `log'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xd50):/home/susovan/alsa/lib/
alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:515: undefined reference to `log'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xd74):/home/susovan/alsa/lib/
alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:536: undefined reference to `exp'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xd9c):/home/susovan/alsa/lib/
alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:526: undefined reference to `sqrtf'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xdac):/home/susovan/alsa/lib/
alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:536: undefined reference to `log'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0xdd4):/home/susovan/alsa/lib/
alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:536: undefined reference to `log'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0x1fac): In function
`snd_pcm_ladspa_check_file':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:1087:
undefined reference to `dlopen'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0x1fc0):/home/susovan/alsa/lib
/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:1089: undefined reference to
`dlsym'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0x20b8):/home/susovan/alsa/lib
/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:1132: undefined reference to
`dlclose'
/usr/lib_alsa/libasound.a(pcm_ladspa.o)(.text+0x20e0):/home/susovan/alsa/lib
/alsa-lib-1.0.14rc4/src/pcm/pcm_ladspa.c:1124: undefined reference to
`dlclose'
/usr/lib_alsa/libasound.a(dlmisc.o)(.text+0xc): In function `snd_dlopen':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/dlmisc.c:64: undefined
reference to `dlopen'
/usr/lib_alsa/libasound.a(dlmisc.o)(.text+0x24): In function `snd_dlclose':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/dlmisc.c:85: undefined
reference to `dlclose'
/usr/lib_alsa/libasound.a(dlmisc.o)(.text+0xa8): In function
`snd_dlsym_verify':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/dlmisc.c:115: undefined
reference to `dlsym'
/usr/lib_alsa/libasound.a(dlmisc.o)(.text+0x144): In function `snd_dlsym':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/dlmisc.c:161: undefined
reference to `dlsym'
/usr/lib_alsa/libasound.a(pcm_meter.o)(.text+0x74c): In function
`snd_pcm_meter_avail_update':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_meter.c:106: undefined
reference to `pthread_mutex_trylock'
/usr/lib_alsa/libasound.a(pcm_meter.o)(.text+0xa54): In function
`snd_pcm_meter_hw_params':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_meter.c:470: undefined
reference to `pthread_create'
/usr/lib_alsa/libasound.a(pcm_meter.o)(.text+0xaec): In function
`snd_pcm_meter_hw_free':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_meter.c:483: undefined
reference to `pthread_join'
/usr/lib_alsa/libasound.a(pcm_meter.o)(.text+0xf84): In function
`snd_pcm_meter_add_scope_conf':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_meter.c:664: undefined
reference to `dlsym'
/usr/lib_alsa/libasound.a(pcm_route.o)(.text+0x12c8): In function
`snd_pcm_route_convert1_many':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_route.c:453: undefined
reference to `rint'
/usr/lib_alsa/libasound.a(pcm_share.o)(.text+0x1dd0): In function
`snd_pcm_share_close':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_share.c:1243:
undefined reference to `pthread_join'
/usr/lib_alsa/libasound.a(pcm_share.o)(.text+0x21b8): In function
`snd_pcm_share_open':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_share.c:1474:
undefined reference to `pthread_create'
/usr/lib_alsa/libasound.a(pcm_softvol.o)(.text+0x18a4): In function
`softvol_load_control':
/home/susovan/alsa/lib/alsa-lib-1.0.14rc4/src/pcm/pcm_softvol.c:665:
undefined reference to `pow'


we tried with the following releases-
        1)alsa-lib-1.0.14
        2) alsa-lib-1.0.14a
        3)alsa-lib-1.0.14rc4
But when we tried to build alsa shared library for x68 platform we did not
face
this problem , but when we built the alsa static library for x86 and tried
to compile the
test application we face the above "undefine reference " error.

Can any one help me to understand and solve this problem?

Thank you

Susovan Ghosh
Engineer (D&D )
PRDE
Ph No:-998667320
Bangalore-560048
