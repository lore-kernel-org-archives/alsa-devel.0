From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Odd behaviour with my driver
Date: Mon, 20 Mar 2006 08:58:10 +0100
Message-ID: <20060320075810.GA5574@turing.informatik.uni-halle.de>
References: <1142714245.9435.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1142714245.9435.29.camel@localhost.localdomain>
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
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> For some reason the trigger (and prepare) callbacks are continually
> being called

When the midlevel code thinks that there is an xrun, it calls stop,
prepare, and start.

> ALSA sound/core/pcm_lib.c:158: BUG: stream = 0, pos = 0x3066, buffer
> size = 0x2000, period size = 0x400
> 
> The hardware buffer is 0x8000 in size and I think that means pos might
> quite legitamtely go as high as 0x3FFF.

This message shows that the buffer size is 0x2000 frames.  If your
number 0x8000 is in bytes, then each frame has four bytes.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
