From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: How is buffer size, periode size and periods determined?
Date: Fri, 12 May 2006 15:55:38 +0200
Message-ID: <446493DA.407@atmel.com>
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
List-Id: alsa-devel@alsa-project.org

Hi

I'm experiencing that my aplay/arecord (1.0.11) is setting up a bit
weird values for buffer size, period size and periods.

For example when trying to record S16_LE 44100 Hz Mono I get the
following parameters:
buffer size: 44100
period size: 4094
periods    : 10

10 * 4094 = 40940 != 44100, the player asks for a bigger buffer than needed.

Other example, S16_LE 32000 Hz Mono:
buffer size: 32752
period size: 4094
periods    : 8

8 * 4094 = 32752 == 32752, which is a correct buffer size.

How come the alsa-lib/aplay behaves like this? I would like to see the
last behaviour all the time. Does this point to a bug on my platform, or
is this the way alsa-lib can calculate the buffers?

The reason I'm asking is that it wastes some memory and the DMA
controller currently in the Linux for my platform doesn't like the
buffersize to be greater than periode size * periods.

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
