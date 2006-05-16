From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Best way of adding temporary limits to capture or playback
Date: Tue, 16 May 2006 07:54:16 +0200
Message-ID: <44696908.4070208@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hello

My AC97 controller has a limit when doing capture/playback in full
duplex, the bitrate and endianess has to be the same for both streams
(playback/capture). Is there a nice and easy way to set this limit?

My current plan is to change the hardware parameters in the playback
open and capture open callbacks if there is an active playback or
capture already present. And then reset this hardware limit when the
close callback is called.

I would of course enjoy just setting a flag in the driver telling it
that capture and playback rates/endianess is related, and is locked if
one of the streams is opened.

PS! I'm having some sort of problems getting my emails from this lists,
seems like I don't get a copy anymore :/ I've checked the settings in
mailman, and they seem good.

PPS! Sorry if this is received twice, but I didn't receive a copy or
find a copy in an online repository (twice).

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
