From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio
Date: Wed, 25 Jan 2006 18:43:17 +0100
Message-ID: <20060125174317.GA26956@ifiu25.informatik.uni-halle.de>
References: <43D60350.5090003@tbridge.it>
 <1138120858.43d6589a3c429@webmail.uni-halle.de> <43D730B4.3030907@tbridge.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43D730B4.3030907@tbridge.it>
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
To: Stefano Papini <s.papini@tbridge.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stefano Papini wrote:
> Perhaps I did something wrong in /etc/asound.conf (I follwed PlanetCCRMA 
> hints on writing one)???

You shouldn't need to write such a file.

>   iManufacturer           1 Ego Systems Inc.
>   iProduct                2 U24

I guess this is your "Swissonic Studio D MkII"?

> Intel 810 + AC97 Audio, version 1.01, 10:51:24 Jan 24 2006

This is a message from the OSS driver for your internal sound card.
Better don't use OSS and ALSA drivers at the same time.

> aplay: main:544: audio open error: Broken pipe
> ALSA usbaudio.c:821: cannot submit datapipe for urb 3, err = -28

Disable USB bandwidth checking (CONFIG_USB_BANDWIDTH) in the kernel
configuration.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
