From: sailer@ife.ee.ethz.ch
Subject: Re: USB Headset: no sound / keyboard freeze, occasional kbd freeze or crash when unplugging
Date: Tue, 28 Dec 2004 18:10:35 +0100
Message-ID: <200412281810.36043.sailer@ife.ee.ethz.ch>
References: <m3652olzdx.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3652olzdx.fsf@reason.gnu-hamburg>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: "Georg C. F. Greve" <greve@fsfeurope.org>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 27 December 2004 13:05, Georg C. F. Greve wrote:

> Got myself a Logitech USB Headset recently and tried to get it to work
> on my workplace machine & laptop. Both machines showed the same
> effects (running Kernel 2.6.9 initially and 2.6.10 now): Sound seems
> to work, ALSA claims everything is fine but no sound is ever audible. [*]

Strange. I've got a Logitech USB headset too, and I do hear sound out of it. I 
do have no sound problems too with Dallas 2401 based USB speakers. Also, 
gnomemeeting seems to have troubles opening the Logitech Headset microphone.

> When unplugging/replugging the headset trying to get it to work, I
> experienced strange phenomena: the keyboard would stop working, and
> once it didn't work when I booted the machine with the headset plugged
> in. In one case, I got a kernel crash reported to syslog.

This looks like an X problem to me. I sometimes have the same phenomenon when 
plugging/unplugging USB devices. It doesn't happen however when I'm on a text 
console. Also, to get the keyboard working again, it is sufficient in my case 
to restart X.

Tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
