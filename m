From: DAMWID <damwid@gmail.com>
Subject: aplay: set_params:1005: unable to install sw params
Date: Tue, 17 Oct 2006 11:35:48 +0800
Message-ID: <45344F94.6070701@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0141437523=="
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

--===============0141437523==
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit

hi all,

I'm trying to get alsa work with kernel 2.6.18.1 on PXA270 platform, 
after rebuild kernel with CONFIG_SND_PXA2XX_AC97 enabled and boot, 
device is found. then I build alsa-lib and alsa-utils, and run aplay to 
play a wav file, but get the following error:

# aplay Front_Center.wav
Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate 
48000 Hz, Mono
aplay: set_params:1005: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 10
silence_threshold: 0
silence_size: 0
boundary: 1434451968

What does this error mean? Can anybody help?

Thanks,

Damwid


--===============0141437523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0141437523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0141437523==--
