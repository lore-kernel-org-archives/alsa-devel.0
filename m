From: Gilles Stenger <gilles@stengerfamily.fr>
Subject: SB Live! 24-bit External (usb) ir transmitter support
Date: Sun, 13 Aug 2006 16:55:21 +0200
Message-ID: <44DF3D59.6040907@stengerfamily.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

I'have recently bought a SB Live! 24-bit External card. I'm using Alsa 
1.0.11 ( Fedora Core 5, 2.6.16 kernel ).

For this card, sound works with stock snd-usb-audio driver but not the 
remote control ( it remain undetected ).

I'have a patch to make to the usbmixer.c file which enable this remote 
control. Work well ( for me ) with lirc-0.8.0.

First question, where do I submit the patch ? Here is the diff :

1781d1780
<       case USB_ID(0x041e, 0x3040):
1965c1964
<       if (mixer->chip->usb_id == USB_ID(0x041e, 
0x3020)||mixer->chip->usb_id == USB_ID(0x041e, 0x3040)) {
---
 >       if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020)) {

Second question, is there anyone able to test this and report any trouble ?

Gilles


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
