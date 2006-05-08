From: "Stefano D Angelo" <daste@oneonline.it>
Subject: Line6 TonePort UX1 driver
Date: Mon, 8 May 2006 20:16:19 +0300
Message-ID: <20060508201619.M38508@oneonline.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hello everyone,
I'm an italian university student and I'm developing an ALSA driver for Line6
TonePort UX1 USB sound card.
This is my first driver-writing experience, so maybe this is a dumb question
for you.
This soundcard supports 44.1/48 kHz 16/24-bits modes and full-duplex, but only
in one mode due to USB altesttings.
To be more precise if you are playing some audio stream at 44.1 kHz, 16-bits,
you can only capture data at 44.1 kHz and 16-bits, for example.
The Windows' driver uses some kind of implicit conversion for
playback/capture, so that it uses only 48 kHz, 24-bit mode (unless you use a
program to switch).
Do you think I should use such a compromise too or go on another way?

Stefano D'Angelo

-----------------
Registra il tuo nome di dominio su: http://www.oneonline.it/domini
One On Line ti offre domino + spazio web illimitato + 5 email + 5000 uscite banner + PHP + Link a soli Euro 15 iva compresa



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
