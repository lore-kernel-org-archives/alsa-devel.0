From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: unterminated conditionals: @HAVE_JACK_TRUE@
Date: Thu, 20 Feb 2003 21:30:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302202109150.17762-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.44.0302202057290.1266-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302202057290.1266-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Feb 2003, Jaroslav Kysela wrote:

> > Then after ./build config I get in alsa-lib/src/pcm/Makefile
> > 
> > @HAVE_JACK_TRUE@else !HAVE_JACK
> > @HAVE_JACK_TRUE@endif !HAVE_JACK
> > 
> > @HAVE_JACK_TRUE@all: libpcm.la
> 
> Could you try to remove !HAVE_JACK string?

>From where?

I have just removed that 3 lines from that Makefile amd run ./build all
again. This time:

Making all in alsamixer
make[1]: Entering directory `/root/ALSA/alsa-utils/alsamixer'
cd .. && automake --foreign alsamixer/Makefile
cd .. \
  && CONFIG_FILES=alsamixer/Makefile CONFIG_HEADERS= /bin/sh ./config.status
creating alsamixer/Makefile
make[1]: Leaving directory `/root/ALSA/alsa-utils/alsamixer'
make[1]: Entering directory `/root/ALSA/alsa-utils/alsamixer'
gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -c alsamixer.c
gcc  -g -O2  -o alsamixer  alsamixer.o -lncurses -lasound -lm -ldl -lpthread
alsamixer.o: In function `update_enum_list':
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:513: undefined reference to
`snd_mixer_selem_get_enum_item'
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:520: undefined reference to
`snd_mixer_selem_get_enum_items'
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:527: undefined reference to
`snd_mixer_selem_set_enum_item'
alsamixer.o: In function `display_enum_list':
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:696: undefined reference to
`snd_mixer_selem_get_enum_item'
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:699: undefined reference to
`snd_mixer_selem_get_enum_item_name'
alsamixer.o: In function `mixer_reinit':
/root/ALSA/alsa-utils/alsamixer/alsamixer.c:1512: undefined reference to
`snd_mixer_selem_is_enumerated'
collect2: ld returned 1 exit status
make[1]: *** [alsamixer] Error 1
make[1]: Leaving directory `/root/ALSA/alsa-utils/alsamixer'
make: *** [all-recursive] Error 1


The problem is I have (previous version?) of
/usr/lib/libasound.so.2
/usr/lib/libasound.so.2.0.0

But should not build script take care of it by linking ../../alsa-lib/ ?

I have run "make install" in alsa-lib and then again ./build all
it went through OK.


Best regards,
--
Tomek



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
