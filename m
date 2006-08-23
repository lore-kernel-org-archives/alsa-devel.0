From: Sven Geggus <sven@geggus.net>
Subject: Bug: aplay/alsa-lib problem on mips (openwrt, uclibc)
Date: Wed, 23 Aug 2006 19:29:21 +0000 (UTC)
Message-ID: <eciaah$qi9$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Dear alsa developers,

I almost succeeded in running alsa (1.0.11/snd-usb-audio) on openwrt (Kernel
2.4.32, uClibc-0.9.28). While OSS emulation is working aplay just
generates an error:

root@(none):/# /usr/local/bin/aplay -f cd -t raw </dev/urandom 
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
aplay: set_params:1012: unable to install sw params:
start_mode: EXPLICIT
xrun_mode: NONE
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 718523216
silence_threshold: 0
silence_size: 0
boundary: 1073741824

speaker-test is generating a very simular error:

root@(none):/# /usr/local/bin/speaker-test -r 44100

speaker-test 1.0.11

Playback device is default
Stream parameters are 44100Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 90 to 262144
Period size range from 45 to 131072
Using max buffer size 262144
Periods = 4
was set period_size = 0
was set buffer_size = 262144
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument

Can you tell me how I could further debug this?

Regards

Sven

P.S.: The Soundcard is working fine on my desktop PC

-- 
"Thinking of using NT for your critical apps?
                                  Isn't there enough suffering in the world?"
                   (Advertisement of Sun Microsystems in Wall Street Journal)
/me is giggls@ircnet, http://sven.gegg.us/ on the Web

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
