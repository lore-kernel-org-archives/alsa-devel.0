From: John Gotts <jgotts@linuxsavvy.com>
Subject: dxs_support detection or feature broken?
Date: Fri, 23 Jan 2004 23:40:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401240440.i0O4eIOv015342@ann-arbor.fmfts.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ann-arbor.fmfts.com (IDENT:lNSB57wkKDZqYDT0m5LPAz5hZerRUL9m@fmfts.com [64.9.213.97])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA16039
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2004 05:41:11 +0100
Received: from ann-arbor.fmfts.com (localhost [127.0.0.1])
	by ann-arbor.fmfts.com (8.12.8/8.12.8) with ESMTP id i0O4eIsI015346
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2004 23:40:18 -0500
Received: from ann-arbor.fmfts.com (jgotts@localhost)
	by ann-arbor.fmfts.com (8.12.8/8.12.8/Submit) with ESMTP id i0O4eIOv015342
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2004 23:40:18 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have an ASUS A7V8X motherboard with a VIA VT8233 audio controller equipped
with SPDIF.  I have a set of digital speakers and use the SPDIF out for
everything possible.  (The speakers will fall back to analog if there is no
digital signal present.)

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)

For a long time (through 1.0.0rc1) I had been using plug:spdif as my audio
device and aplay had no problems playing 22,050 Hz WAV files:

aplay -D plug:spdif <filename>.wav

But with 1.0.1 my speakers started playing 22,050 Hz WAV files at 48,000 Hz.

After reading the following thread:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10448.html

I added the following line to my /etc/modules.conf:

options snd-via82xx dxs_support=3

and plug:spdif is working again.  One message says "By default snd-via82xx uses
dxs_support=3 (except for certain known motherboards)."  Either my motherboard
should become unknown or this feature is not working correctly.

John

-- 
John GOTTS <jgotts@linuxsavvy.com>  http://linuxsavvy.com/staff/jgotts


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
