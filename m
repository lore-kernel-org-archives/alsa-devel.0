From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] alsa-lib-0.9.8/test/pcm strangeness
Date: Thu, 22 Jan 2004 14:23:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401221422370.2314@pnote.perex-int.cz>
References: <3ohdyqvyuq.fsf@tba.elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA06414
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2004 14:25:59 +0100
In-Reply-To: <3ohdyqvyuq.fsf@tba.elte.hu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ferenc Wagner <wferi@afavant.elte.hu>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2004, Ferenc Wagner wrote:

>                Hello!
> 
> $ ./pcm
> Playback device is plughw:0,0
> Stream parameters are 44100Hz, S16_LE, 1 channels
> Sine wave rate is 440.0000Hz
> Using transfer method: write
> ALSA lib pcm.c:1876:(snd_pcm_open_conf) symbol _snd_pcm_plug_open is not defined inside (null)
> Playback open error: No such device or address

perex@pnote:~/alsa/alsa-lib/test> make pcm
if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -static -Wall 
-pipe -g -MT pcm.o -MD -MP -MF ".deps/pcm.Tpo" \
  -c -o pcm.o `test -f 'pcm.c' || echo './'`pcm.c; \
then mv -f ".deps/pcm.Tpo" ".deps/pcm.Po"; \
else rm -f ".deps/pcm.Tpo"; exit 1; \
fi
/bin/sh ../libtool --mode=link gcc  -static -Wall -pipe -g   -o pcm  pcm.o 
../src/libasound.la
mkdir .libs
gcc -Wall -pipe -g -o pcm pcm.o  ../src/.libs/libasound.so -lm -ldl 
-lpthread -Wl,--rpath -Wl,/home/perex/alsa/alsa-lib/src/.libs
perex@pnote:~/alsa/alsa-lib/test> ./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write


So, what's your problem?

perex@pnote:~/alsa/alsa-lib/test> libtool --version
ltmain.sh (GNU libtool) 1.5 (1.1220.2.1 2003/04/14 22:48:00)

perex@pnote:~/alsa/alsa-lib/test> automake --version
automake (GNU automake) 1.7.6

perex@pnote:~/alsa/alsa-lib/test> autoconf --version
autoconf (GNU Autoconf) 2.57

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
