From: Stephen Hassard <steve@hassard.net>
Subject: More envy24ht problems ..
Date: Fri, 18 Apr 2003 10:40:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030418174054.GA5018@www.angiotech.com>
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

Hi there,

I found a few more problems with the envy24ht driver in Alsa (today's CVS).

I'm compiling Alsa directly into my 2.5.67 kernel.

1. Sequencer support must be compiled in to get the envy24ht driver to compile, otherwise linking ther kernel fails with all sorts of mpu/uart objects not found.

2. Both the OSS+Alsa mixers seem to be broken. When I run alsamixer I get a "No mixer elems found". aumix reports "aumix:  no device found". I've run the snddevices to build the correct /dev nodes. I'm not using devfsd. I've tried envy24control, but it reports "invalid card type (driver is ICE1724)".

Playback seems to work (nothing complains), but I can't hear anything until I can use a mixer :P

Thanks,
Stephen Hassard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
