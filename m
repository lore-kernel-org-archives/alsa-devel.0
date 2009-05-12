From: Robert Vincent Krakora <rob.krakora@messagenetsystems.com>
Subject: ALSA 1.0.20 PCM Capture Problem (Does not happen on
	ALSA 1.0.19)
Date: Tue, 12 May 2009 17:16:09 -0400
Message-ID: <4A09E719.9040100@messagenetsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(mail.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 97B7E10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 23:16:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net, jerry Geis <geisj@messagenetsystems.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I am utilizing an external mic on my machine in conjunction with a 
VF0560 Live! Cam Optia AF webcam.  I am running CentOS 5.3 with the 
kernel listed below and ALSA 1.0.20.  I using the machine to stream 
video with VLC 9.9 (see further below).  VLC spits out the following on 
the console of my machine whist capturing A/V and serving it up on the 
network...ALSA 1.0.19 did not exhibit this problem while streaming it 
did lock up after 20 minutes or so (audio could be heard on the VLC or 
mplayer client with ALSA 1.0.19...just bits and pieces of audio every 
now and then with ALSA 1.0.20.  V4L is not the culprit here as video 
streams and can be received without incident if I do not also capture 
audio.  The mic is plugged into the onboard sound on the motherboard.  I 
have not yet tried my USB mic with ALSA 1.0.20, but I will try it later 
tonight.  Any and all help would be greatly appreciate.  Thanks in advance.

[00000473] main audio output warning: audio drift is too big (-146765), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29715)
[00000473] main audio output warning: audio drift is too big (-150692), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30980)
[00000493] main spu text debug: looking for text renderer module: 3 
candidates
[00000493] freetype spu text error: failed to load font file 
/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf
[00000493] main spu text debug: using text renderer module "svg"
[00000493] main spu text debug: TIMER module_Need() : 29.750 ms - Total 
29.750 ms / 1 intvls (Avg 29.750 ms)
[00000492] main blend debug: looking for video blending module: 1 candidate
[00000492] blend blend debug: chroma: YUVA -> I420
[00000492] main blend debug: using video blending module "blend"
[00000492] main blend debug: TIMER module_Need() : 0.433 ms - Total 
0.433 ms / 1 intvls (Avg 0.433 ms)
[00000473] main audio output warning: audio drift is too big (-147017), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29763)
[00000473] main audio output warning: audio drift is too big (-147157), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30302)
[00000473] main audio output warning: audio drift is too big (-150434), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30931)
[00000473] main audio output warning: buffer is 114796 in advance, 
triggering downsampling
[00000473] main audio output warning: audio drift is too big (-261628), 
clearing out
[00000473] main audio output warning: timing screwed, stopping resampling
[00000473] main audio output warning: mixer start isn't output start 
(-53788)
[00000473] main audio output warning: audio drift is too big (-146580), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29711)
[00000473] main audio output warning: audio drift is too big (-150686), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30979)
[00000473] main audio output warning: audio drift is too big (-146733), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29708)
[00000473] main audio output warning: audio drift is too big (-146978), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30267)
[00000473] main audio output warning: audio drift is too big (-150569), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30445)
[00000473] main audio output warning: buffer is 114650 in advance, 
triggering downsampling
[00000473] main audio output warning: audio drift is too big (-261447), 
clearing out
[00000473] main audio output warning: timing screwed, stopping resampling
[00000473] main audio output warning: mixer start isn't output start 
(-54265)
[00000473] main audio output warning: audio drift is too big (-146518), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29699)
[00000473] main audio output warning: audio drift is too big (-146731), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30220)
[00000473] main audio output warning: audio drift is too big (-150880), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30505)
[00000473] main audio output warning: audio drift is too big (-146644), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30203)
[00000473] main audio output warning: audio drift is too big (-146701), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29702)
[00000473] main audio output warning: audio drift is too big (-150683), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30979)
[00000473] main audio output warning: audio drift is too big (-146706), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29703)
[00000473] main audio output warning: audio drift is too big (-146916), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30255)
[00000473] main audio output warning: audio drift is too big (-150819), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-31005)
[00000473] main audio output warning: audio drift is too big (-147003), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-29760)
[00000473] main audio output warning: audio drift is too big (-146886), 
clearing out
[00000473] main audio output warning: mixer start isn't output start 
(-30250)
[00000473] main audio output warning: audio drift is too big (-150552), 
clearing out


[root@vizioroom105 ~]# uname -a
Linux vizioroom105.msgnet.com 2.6.27.10 #2 SMP Thu Jan 22 09:09:44 EST 
2009 x86_64 x86_64 x86_64 GNU/Linux

[root@vizioroom105 ~]# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: AF [VF0560 Live! Cam Optia AF], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: SB [HDA ATI SB], device 1: ALC883 Digital [ALC883 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: SB [HDA ATI SB], device 2: ALC883 Analog [ALC883 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0


[root@vizioroom105 ~]# su silentm -c "/usr/bin/vcamera -vvvvv -I dummy 
-V dummy --dscp=0x01 v4l2:// :v4l2-dev=/dev/video0 :v4l2-adev=hw.1,0 
:v4l2-width=720 :v4l2-height=480 :v4l2-standard=0 --sout 
'#transcode{vcodec=mp4v,vb=6000,fps=30,scale=1,acodec=mpga,ab=32,channels=1}:duplicate{dst=rtp{mux=ts,port=1234,sdp=rtsp://192.168.1.179:8080/test.sdp}}' 
vlc://quit"

Best Regards,
-- 
Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
