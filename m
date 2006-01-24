From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio
Date: Tue, 24 Jan 2006 17:40:58 +0100
Message-ID: <1138120858.43d6589a3c429@webmail.uni-halle.de>
References: <43D60350.5090003@tbridge.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43D60350.5090003@tbridge.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stefano Papini <s.papini@tbridge.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stefano Papini wrote:
> would you mind sending me where may I find snd-usb-audio in order to let
> a Swissonic USB Studio D MkII working through its USB interface?

If the device is class compliant, any version of snd-usb-audio will work.

If the device is not, no version will work (yet).  In that case, what is
the output of "lsusb -v" for this device?


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
