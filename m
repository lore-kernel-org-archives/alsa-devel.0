From: Martin Langer <martin-langer@gmx.de>
Subject: compiling pcm_jack fails
Date: Thu, 6 Mar 2003 23:10:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030306221057.GC14305@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Hi,

using latest CVS on a jack-free system produces a lot of output. I've never
saw that before during "make build". For me it looks like a consequence of
moving jack plugin to a new directory.

martin


make[4]: Entering directory /usr/local/src/alsa-cvs/alsa-lib/src/pcm/ext'
/bin/sh ../../../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I.
-I../../../include -I../../../include -I../../../src/pcm    -O2 -Wall -W
-pipe -g -c pcm_jack.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include
-I../../../src/pcm -O2 -Wall -W -pipe -g -Wp,-MD,.deps/pcm_jack.pp -c
pcm_jack.c
-fPIC -DPIC -o pcm_jack.lo
pcm_jack.c:36: jack/jack.h: No such file or directory
pcm_jack.c:68: parse error before jack_port_t'
pcm_jack.c:68: warning: no semicolon at end of struct or union
pcm_jack.c:69: warning: type defaults to int' in declaration of client'
pcm_jack.c:69: warning: data definition has no type or storage class
pcm_jack.c:70: parse error before }'
pcm_jack.c:70: warning: type defaults to int' in declaration of
snd_pcm_jack_t'
pcm_jack.c:70: warning: data definition has no type or storage class
pcm_jack.c: In function snd_pcm_jack_close':
pcm_jack.c:76: jack' undeclared (first use in this function)
pcm_jack.c:76: (Each undeclared identifier is reported only once
pcm_jack.c:76: for each function it appears in.)
pcm_jack.c:77: parse error before int'
pcm_jack.c:84: warning: implicit declaration of function jack_client_close'
pcm_jack.c:96: err' undeclared (first use in this function)
pcm_jack.c:97: warning: control reaches end of non-void function
pcm_jack.c: In function snd_pcm_jack_status':
pcm_jack.c:158: jack' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_state':
pcm_jack.c:173: jack' undeclared (first use in this function)
pcm_jack.c:178: warning: control reaches end of non-void function
pcm_jack.c: At top level:
pcm_jack.c:198: parse error before nframes'
pcm_jack.c: In function snd_pcm_jack_process_cb':
pcm_jack.c:200: jack' undeclared (first use in this function)
pcm_jack.c:200: pcm' undeclared (first use in this function)
pcm_jack.c:201: parse error before const'
pcm_jack.c:210: channel' undeclared (first use in this function)
pcm_jack.c:212: warning: implicit declaration of function
jack_port_get_buffer'
pcm_jack.c:212: nframes' undeclared (first use in this function)
pcm_jack.c:226: areas' undeclared (first use in this function)
pcm_jack.c:228: xfer' undeclared (first use in this function)
pcm_jack.c:256: samples' undeclared (first use in this function)
pcm_jack.c:267: buf' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_prepare':
pcm_jack.c:280: jack' undeclared (first use in this function)
pcm_jack.c:290: jack_port_t' undeclared (first use in this function)
pcm_jack.c:290: parse error before )'
pcm_jack.c:297: warning: implicit declaration of function jack_port_register'
pcm_jack.c:298: JACK_DEFAULT_AUDIO_TYPE' undeclared (first use in this
function)
pcm_jack.c:298: JackPortIsOutput' undeclared (first use in this function)
pcm_jack.c:302: JackPortIsInput' undeclared (first use in this function)
pcm_jack.c:306: warning: implicit declaration of function
jack_set_process_callback'
pcm_jack.c:307: JackProcessCallback' undeclared (first use in this function)
pcm_jack.c:307: parse error before snd_pcm_jack_process_cb'
pcm_jack.c: In function snd_pcm_jack_start':
pcm_jack.c:323: jack' undeclared (first use in this function)
pcm_jack.c:324: parse error before unsigned'
pcm_jack.c:333: warning: implicit declaration of function jack_activate'
pcm_jack.c:338: i' undeclared (first use in this function)
pcm_jack.c:341: warning: implicit declaration of function jack_connect'
pcm_jack.c:342: warning: implicit declaration of function jack_port_name'
pcm_jack.c:347: warning: format argument is not a pointer (arg 3)
pcm_jack.c:353: warning: format argument is not a pointer (arg 2)
pcm_jack.c:368: warning: format argument is not a pointer (arg 4)
pcm_jack.c:374: warning: format argument is not a pointer (arg 3)
pcm_jack.c:381: tv' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_drop':
pcm_jack.c:391: jack' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_drain':
pcm_jack.c:417: jack' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_pause':
pcm_jack.c:427: jack' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_avail_update':
pcm_jack.c:483: jack' undeclared (first use in this function)
pcm_jack.c:484: parse error before ret'
pcm_jack.c:486: ret' undeclared (first use in this function)
pcm_jack.c:489: warning: control reaches end of non-void function
pcm_jack.c: In function snd_pcm_jack_hw_refine':
pcm_jack.c:506: jack' undeclared (first use in this function)
pcm_jack.c:507: parse error before static'
pcm_jack.c:520: warning: passing arg 2 of snd_mask_refine' from incompatible
pointer type
pcm_jack.c:523: format_mask' undeclared (first use in this function)
pcm_jack.c:529: warning: implicit declaration of function
jack_get_sample_rate'
pcm_jack.c:533: t' undeclared (first use in this function)
pcm_jack.c: In function snd_pcm_jack_open':
pcm_jack.c:694: jack' undeclared (first use in this function)
pcm_jack.c:694: warning: statement with no effect
pcm_jack.c:695: parse error before int'
pcm_jack.c:713: err' undeclared (first use in this function)
pcm_jack.c:725: warning: implicit declaration of function jack_client_new'
pcm_jack.c:752: fd' undeclared (first use in this function)
make[4]: *** [pcm_jack.lo] Error 1
make[4]: Leaving directory /usr/local/src/alsa-cvs/alsa-lib/src/pcm/ext'
make[3]: *** [install-recursive] Error 1
make[3]: Leaving directory /usr/local/src/alsa-cvs/alsa-lib/src/pcm'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory /usr/local/src/alsa-cvs/alsa-lib/src'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory /usr/local/src/alsa-cvs/alsa-lib'




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
