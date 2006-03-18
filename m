From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Odd behaviour with my driver
Date: Sat, 18 Mar 2006 20:37:25 +0000
Message-ID: <1142714245.9435.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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

I am testing out my driver (for the AICA sound device on the Dreamcast)
with mpg123 compiled for OSS only (I am using the oss emulation as I
cannot seem to get pure ALSA to work).

For some reason the trigger (and prepare) callbacks are continually
being called and this is (afaics) dynamically resizing the runtime
buffer to the size of the samples being transferred (in this case 2
periods - one for each channel), which is in turn generating bug reports
such as the one below:

ALSA sound/core/pcm_lib.c:158: BUG: stream = 0, pos = 0x3066, buffer
size = 0x2000, period size = 0x400

The hardware buffer is 0x8000 in size and I think that means pos might
quite legitamtely go as high as 0x3FFF.

Does any of this make sense and can someone point me to a reason why
this might be happening?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
