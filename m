From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: unterminated conditionals: @HAVE_JACK_TRUE@
Date: Thu, 20 Feb 2003 20:57:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302202057290.1266-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0302201956530.17762-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0302201956530.17762-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Feb 2003, tomasz motylewski wrote:

> 
> Debian woody, current cvs:
> 
> ./build  prep
> Pre-configuring alsa-driver
> make: Nothing to be done for `all-deps'.
> Pre-configuring alsa-lib
> src/pcm/Makefile.am:6: JACK_PLUGIN multiply defined in condition
> automake: src/pcm/Makefile.am: unterminated conditionals: @HAVE_JACK_TRUE@
> src/pcm/Makefile.am:9: warning: automake does not support conditional
> definition of JACK_PLUGIN in libpcm_la_SOURCES
> 
> Then after ./build config I get in alsa-lib/src/pcm/Makefile
> 
> @HAVE_JACK_TRUE@else !HAVE_JACK
> @HAVE_JACK_TRUE@endif !HAVE_JACK
> 
> @HAVE_JACK_TRUE@all: libpcm.la

Could you try to remove !HAVE_JACK string?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
