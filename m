From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: "sbase.c:206: warning: unused variable 's'...  "
Date: Tue, 08 Nov 2005 22:47:01 +0100
Message-ID: <43711CD5.4080507@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some warning messages when building rc3.

Making all in simple
make[4]: Entering directory `/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9+1.0.10rc3/modules/mixer/simple'
if /bin/sh ../../../libtool --mode=compile i486-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include   -g -O2 -W -Wall -g -Wall -O2 -MT sbase.lo -MD -MP -MF ".deps/sbase.Tpo" \
  -c -o sbase.lo `test -f 'sbase.c' || echo './'`sbase.c; \
then mv -f ".deps/sbase.Tpo" ".deps/sbase.Plo"; \
else rm -f ".deps/sbase.Tpo"; exit 1; \
fi
mkdir .libs
 i486-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include -g -O2 -W -Wall -g -Wall -O2 -MT sbase.lo -MD -MP -MF .deps/sbase.Tpo -c sbase.c  -fPIC -DPIC -o .libs/sbase.o
sbase.c: In function 'get_switch_ops':
sbase.c:206: warning: unused variable 's'
sbase.c:203: warning: unused parameter 'dir'
sbase.c:204: warning: unused parameter 'channel'
sbase.c: In function 'set_volume_ops':
sbase.c:214: warning: unused variable 's'
sbase.c:211: warning: unused parameter 'dir'
sbase.c:212: warning: unused parameter 'channel'
sbase.c:212: warning: unused parameter 'value'
sbase.c: In function 'set_switch_ops':
sbase.c:231: warning: unused variable 'changed'
sbase.c:230: warning: unused variable 's'
sbase.c:227: warning: unused parameter 'dir'
sbase.c:228: warning: unused parameter 'channel'
sbase.c:228: warning: unused parameter 'value'
sbase.c: In function 'enum_item_name_ops':
sbase.c:239: warning: unused variable 's'
sbase.c:236: warning: unused parameter 'item'
sbase.c:237: warning: unused parameter 'maxlen'
sbase.c:237: warning: unused parameter 'buf'
sbase.c: In function 'get_enum_item_ops':
sbase.c:247: warning: unused variable 's'
sbase.c:244: warning: unused parameter 'channel'
sbase.c:245: warning: unused parameter 'itemp'
sbase.c: In function 'set_enum_item_ops':
sbase.c:255: warning: unused variable 's'
sbase.c:252: warning: unused parameter 'channel'
sbase.c:253: warning: unused parameter 'item'
sbase.c: In function 'simple_event_remove':
sbase.c:286: warning: unused parameter 'melem'
sbase.c: In function 'simple_event_add1':
sbase.c:312: warning: unused variable 'count'
sbase.c: At top level:
sbase.c:54: warning: 'to_user' defined but not used
sbase.c:63: warning: 'from_user' defined but not used


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
