From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: switch to new PCM API for 1.0 release
Date: Sat, 8 Nov 2003 20:04:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311081950460.3073@pnote.perex-int.cz>
References: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de>
 <20031108163922.GA6647@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA03191
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2003 20:04:48 +0100
In-Reply-To: <20031108163922.GA6647@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Nov 2003, Martin Langer wrote:

> On Wed, Nov 05, 2003 at 11:47:58AM +0100, Jaroslav Kysela wrote:
> >
> > 	I decided to switch to new PCM API (values are returned using an
> > indirect pointer rather as return value, so error codes are not mixed with
> > values). The binary compatibility is kept. So, you can use old
> > applications with new libraries and you can even use applications compiled
> > against 1.0 alsa-lib with 0.9 library binaries.
>
> FYI,
>
> aplay/arecord doesn't work at the moment:
>
> Playing WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> aplay: set_params:874: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED

Could you post details? Please, send me output from:

nm /usr/bin/aplay | grep rate

and

nm /usr/lib/libasound.so.2 | grep set_rate


					Thank you,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
