From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa substreams +rates
Date: Tue, 13 Apr 2004 18:21:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404131816270.10741-100000@studcom.urz.uni-halle.de>
References: <20040409104120.63050.qmail@web25101.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040409104120.63050.qmail@web25101.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Brian Furey wrote:
> with the ALSA driver, what do the OSS substream mean?

There are no "OSS substreams".  ALSA PCM devices have substreams.  A
device with more than one substream can be opened multiple times
simultaneously.

> If you have a 2 main capture channels, how many substream would
> you have?

Depends on the hardware, and is completely unrelated to the number of
channels.

> Also the capture stream is supposed to operate at 8000
> Hz per second.

8000 Hz is just the default.

> Is it possible that it is actually say 8192, a value to the
> power-of-two?

It's 8000, for historical reasons (the standard rate of some telephony
codec, which was then used on some early UNIX systems, or something
like that).


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
