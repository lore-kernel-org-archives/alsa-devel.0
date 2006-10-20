From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Snd-usb-audio and usb-phones.
Date: Fri, 20 Oct 2006 11:53:49 +0200
Message-ID: <1161338029.17815.273804883@webmail.messagingengine.com>
References: <20061020083657.GA8792@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061020083657.GA8792@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "K.A." <deb.lists@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

K.A. wrote:
>  I bought a noname usb ip-phone. So when plugging it in, your driver
>  snd-usb-audio is used. So I decided to ask whether you know if drivers
>  for such devices exist.

Yes, a driver for USB audio devices does exist.
Its name is snd-usb-audio.

>  The problem is that the phone is found as an audio device, it uses
>  the hiddev96 driver, but I can't hear any sound when trying to call to
>  my Skype contact -- only noise, and crack, and flicks while the call is
>  processing.
> ...
>  2:1:1: cannot get freq at ep 0x2
>  2:2:1: cannot get freq at ep 0x82

These error messages indicate that your device isn't quite compatible
with the USB audio specification.

Please show the output of "lsusb -v" for this device.

Does this device require a separate driver for Windows, or does it work
with the standard driver shipped with Windows?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
