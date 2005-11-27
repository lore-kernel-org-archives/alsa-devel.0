From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Cross compiling alsa-lib
Date: Sun, 27 Nov 2005 18:31:43 +0000
Message-ID: <1133116303.8952.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is failing due to (seemingly) a missing type definition in
pcm_ladspa.c.

I am trying to compile this against uclibc rather than glibc... does
anyone know what the issue is and how to fix it?

Adrian


if /bin/sh ../../libtool
--mode=compile /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-uclibc-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include    -g -O2 -MT pcm_ladspa.lo -MD -MP -MF ".deps/pcm_ladspa.Tpo" \
  -c -o pcm_ladspa.lo `test -f 'pcm_ladspa.c' || echo './'`pcm_ladspa.c;
\
then mv -f ".deps/pcm_ladspa.Tpo" ".deps/pcm_ladspa.Plo"; \
else rm -f ".deps/pcm_ladspa.Tpo"; exit 1; \
fi
 /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-uclibc-gcc
-DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_ladspa.lo -MD -MP -MF .deps/pcm_ladspa.Tpo -c pcm_ladspa.c  -fPIC
-DPIC -o .libs/pcm_ladspa.o
pcm_ladspa.c:31:21: wordexp.h: No such file or directory
In file included from pcm_plugin.h:22,
                 from pcm_ladspa.c:34:
../../include/iatomic.h:1017:2: warning: #warning "Atomic operations are
not supported on this architecture."
pcm_ladspa.c: In function `snd_pcm_ladspa_look_for_plugin':
pcm_ladspa.c:818: error: `wordexp_t' undeclared (first use in this
function)
pcm_ladspa.c:818: error: (Each undeclared identifier is reported only
once
pcm_ladspa.c:818: error: for each function it appears in.)
pcm_ladspa.c:818: error: parse error before "we"
pcm_ladspa.c:825: error: `we' undeclared (first use in this function)
pcm_ladspa.c:825: error: `WRDE_NOCMD' undeclared (first use in this
function)
pcm_ladspa.c:827: error: `WRDE_NOSPACE' undeclared (first use in this
function)
make[2]: *** [pcm_ladspa.lo] Error 1
make[2]: Leaving directory `/home/adrian/alsa-lib-1.0.10/src/pcm'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/adrian/alsa-lib-1.0.10/src'
make: *** [all-recursive] Error 1




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
