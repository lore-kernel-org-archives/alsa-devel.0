From: Martin Langer <martin-langer@gmx.de>
Subject: Re: switch to new PCM API for 1.0 release
Date: Sat, 8 Nov 2003 17:39:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031108163922.GA6647@tuba.home>
References: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA00793
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2003 17:38:49 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2003 at 11:47:58AM +0100, Jaroslav Kysela wrote:
> 
> 	I decided to switch to new PCM API (values are returned using an
> indirect pointer rather as return value, so error codes are not mixed with
> values). The binary compatibility is kept. So, you can use old
> applications with new libraries and you can even use applications compiled
> against 1.0 alsa-lib with 0.9 library binaries.

FYI,

aplay/arecord doesn't work at the moment:

Playing WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: set_params:874: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE
^^^^^^^^^^
PERIOD_TIME: (170666 170667)
PERIOD_SIZE: (22963264 22963265)
PERIOD_BYTES: (91853056 91853060)
PERIODS: (2 3)
BUFFER_TIME: (341333 341334)
BUFFER_SIZE: 45926708
BUFFER_BYTES: 183706832
TICK_TIME: 10000


martin


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
