From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: using more than 8 boards of the same kind, at once,
 on a single system
Date: Mon, 13 Feb 2006 09:32:40 +0100
Message-ID: <20060213083240.GC8896@ifiu25.informatik.uni-halle.de>
References: <1139755387.25868.1.camel@lnx.rgptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1139755387.25868.1.camel@lnx.rgptech.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: hurricane <hurricane@barmusic.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hurricane wrote:
> I have designed a video/audio USB2.0 board (WISIWYG 1.0), that I use
> on 2.6.11-1.27_FC3smp that uses the WIS GO7007 chip, and have run into
> a limit of 8 boards that can be recognized for audio by the WIS device
> driver.

ALSA's latest development relase (1.0.11rc3) supports up to 32 cards
when it is configured with --enable-dynamic-minors.

> I need to use up to 48 boards on one system.

This would require a trivial change in alsa-lib and an unknown amount of
changes in the ALSA kernel code.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
