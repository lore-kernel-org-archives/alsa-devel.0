From: Harri =?iso-8859-1?Q?J=E4rvi?= <harri.jarvi@ajatus.org>
Subject: snd-usb-audio HP-107 midi broke at 2.6.13 or 2.6.14
Date: Sun, 1 Jan 2006 21:34:07 +0200
Message-ID: <20060101193407.GA18702@novelli>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I have Roland HP-107 with builtin USB support. I have successfully used=20
it with snd-usb-audio on Linux 2.6.8, 2.6.10 and 2.6.12.3.

On 2.6.14.4 and 2.6.14.5 it doesn't work. I replaced the sound/usb=20
directory of 2.6.14.5 from 2.6.12.3 to test if the problem can be
isolated to that directory. I got it compiled with removing the two=20
lines that the compiler complained about. And it worked well.

I can reproduce the problem on both i386 and powerpc. On i386 I have=20
uhci and on powerpc I have ohci.

Output from kernel on 2.6.14.5 with faulty snd-usb-audio is as follows:

usb 2-1: new full speed USB device using ohci_hcd and address 2
snd-usb-audio: probe of 2-1:1.0 failed with error -5
usbcore: registered new driver snd-usb-audio

Output from a working kernel version (2.6.12.3) is as follows:

usb 2-1: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver snd-usb-audio

On 2.6.14.4 and 2.6.14.5 I could get Edirol UM 1-SX to work.

Yours,
Harri J=E4rvi

PS. Please Cc me when replying.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
