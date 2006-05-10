From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: aplay and arecord can't set sw params
Date: Wed, 10 May 2006 16:18:24 +0200
Message-ID: <4461F630.2060707@atmel.com>
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

Does this output give any signs of where the error is?

~ # aplay /stk1000/gorillaz.wav
Playing WAVE '/stk1000/gorillaz.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
aplay: set_params:1012: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 0
silence_threshold: 0
silence_size: 0
boundary: 1231028224

~ # arecord -f S16_BE /stk1000/rec.wav
Recording WAVE '/stk1000/rec.wav' : Signed 16 bit Big Endian, Rate 8000
Hz, Mono
arecord: set_params:1012: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 0
silence_threshold: 0
silence_size: 0
boundary: 1073741824


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
