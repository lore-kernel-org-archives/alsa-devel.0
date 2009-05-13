From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: ALSA 1.0.20 PCM Capture Problem (Does not happen
	on ALSA 1.0.19)
Date: Tue, 12 May 2009 22:45:29 -0400
Message-ID: <b24e53350905121945q35b1e515q1ad1a808b8d1539a@mail.gmail.com>
References: <4A09E719.9040100@messagenetsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 3809710387D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 04:45:30 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so264494ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 19:45:29 -0700 (PDT)
In-Reply-To: <4A09E719.9040100@messagenetsystems.com>
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

Sorry, on the last e-mail I sent the output of the VLC client and not
the server.  Here is the output of the VLC server:

[00000439] main mux warning: late buffer for mux input (227866)
[00000439] mux_ts mux debug: adjusting rate at -305054/202926 (40/374)
[00000439] mux_ts mux debug: adjusting rate at -507980/230348 (124/153)
[00000439] main mux warning: late buffer for mux input (205520)
[00000439] main mux warning: late buffer for mux input (181554)
[00000439] main mux warning: late buffer for mux input (157572)
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000439] main mux warning: late buffer for mux input (605778)
[00000439] main mux warning: late buffer for mux input (582566)
[00000439] main mux warning: late buffer for mux input (559234)
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000431] stream_out_transcode stream out debug: drift is too high,
resetting master sync
[00000439] main mux warning: late buffer for mux input (219019)
[00000439] mux_ts mux debug: adjusting rate at -205269/234561 (210/67)
[00000439] mux_ts mux debug: adjusting rate at -439830/264004 (399/15)
[00000439] main mux warning: late buffer for mux input (196696)
[00000439] main mux warning: late buffer for mux input (172734)
[00000439] main mux warning: late buffer for mux input (148752)


On Tue, May 12, 2009 at 5:16 PM, Robert Vincent Krakora
<rob.krakora@messagenetsystems.com> wrote:
> Hello,
>
> I am utilizing an external mic on my machine in conjunction with a
> VF0560 Live! Cam Optia AF webcam. =A0I am running CentOS 5.3 with the
> kernel listed below and ALSA 1.0.20. =A0I using the machine to stream
> video with VLC 9.9 (see further below). =A0VLC spits out the following on
> the console of my machine whist capturing A/V and serving it up on the
> network...ALSA 1.0.19 did not exhibit this problem while streaming it
> did lock up after 20 minutes or so (audio could be heard on the VLC or
> mplayer client with ALSA 1.0.19...just bits and pieces of audio every
> now and then with ALSA 1.0.20. =A0V4L is not the culprit here as video
> streams and can be received without incident if I do not also capture
> audio. =A0The mic is plugged into the onboard sound on the motherboard. =
=A0I
> have not yet tried my USB mic with ALSA 1.0.20, but I will try it later
> tonight. =A0Any and all help would be greatly appreciate. =A0Thanks in ad=
vance.
>
> [00000473] main audio output warning: audio drift is too big (-146765),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29715)
> [00000473] main audio output warning: audio drift is too big (-150692),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30980)
> [00000493] main spu text debug: looking for text renderer module: 3
> candidates
> [00000493] freetype spu text error: failed to load font file
> /usr/share/fonts/truetype/freefont/FreeSerifBold.ttf
> [00000493] main spu text debug: using text renderer module "svg"
> [00000493] main spu text debug: TIMER module_Need() : 29.750 ms - Total
> 29.750 ms / 1 intvls (Avg 29.750 ms)
> [00000492] main blend debug: looking for video blending module: 1 candida=
te
> [00000492] blend blend debug: chroma: YUVA -> I420
> [00000492] main blend debug: using video blending module "blend"
> [00000492] main blend debug: TIMER module_Need() : 0.433 ms - Total
> 0.433 ms / 1 intvls (Avg 0.433 ms)
> [00000473] main audio output warning: audio drift is too big (-147017),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29763)
> [00000473] main audio output warning: audio drift is too big (-147157),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30302)
> [00000473] main audio output warning: audio drift is too big (-150434),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30931)
> [00000473] main audio output warning: buffer is 114796 in advance,
> triggering downsampling
> [00000473] main audio output warning: audio drift is too big (-261628),
> clearing out
> [00000473] main audio output warning: timing screwed, stopping resampling
> [00000473] main audio output warning: mixer start isn't output start
> (-53788)
> [00000473] main audio output warning: audio drift is too big (-146580),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29711)
> [00000473] main audio output warning: audio drift is too big (-150686),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30979)
> [00000473] main audio output warning: audio drift is too big (-146733),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29708)
> [00000473] main audio output warning: audio drift is too big (-146978),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30267)
> [00000473] main audio output warning: audio drift is too big (-150569),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30445)
> [00000473] main audio output warning: buffer is 114650 in advance,
> triggering downsampling
> [00000473] main audio output warning: audio drift is too big (-261447),
> clearing out
> [00000473] main audio output warning: timing screwed, stopping resampling
> [00000473] main audio output warning: mixer start isn't output start
> (-54265)
> [00000473] main audio output warning: audio drift is too big (-146518),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29699)
> [00000473] main audio output warning: audio drift is too big (-146731),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30220)
> [00000473] main audio output warning: audio drift is too big (-150880),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30505)
> [00000473] main audio output warning: audio drift is too big (-146644),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30203)
> [00000473] main audio output warning: audio drift is too big (-146701),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29702)
> [00000473] main audio output warning: audio drift is too big (-150683),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30979)
> [00000473] main audio output warning: audio drift is too big (-146706),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29703)
> [00000473] main audio output warning: audio drift is too big (-146916),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30255)
> [00000473] main audio output warning: audio drift is too big (-150819),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-31005)
> [00000473] main audio output warning: audio drift is too big (-147003),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-29760)
> [00000473] main audio output warning: audio drift is too big (-146886),
> clearing out
> [00000473] main audio output warning: mixer start isn't output start
> (-30250)
> [00000473] main audio output warning: audio drift is too big (-150552),
> clearing out
>
>
> [root@vizioroom105 ~]# uname -a
> Linux vizioroom105.msgnet.com 2.6.27.10 #2 SMP Thu Jan 22 09:09:44 EST
> 2009 x86_64 x86_64 x86_64 GNU/Linux
>
> [root@vizioroom105 ~]# arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: AF [VF0560 Live! Cam Optia AF], device 0: USB Audio [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: SB [HDA ATI SB], device 1: ALC883 Digital [ALC883 Digital]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: SB [HDA ATI SB], device 2: ALC883 Analog [ALC883 Analog]
> =A0Subdevices: 0/1
> =A0Subdevice #0: subdevice #0
>
>
> [root@vizioroom105 ~]# su silentm -c "/usr/bin/vcamera -vvvvv -I dummy
> -V dummy --dscp=3D0x01 v4l2:// :v4l2-dev=3D/dev/video0 :v4l2-adev=3Dhw.1,0
> :v4l2-width=3D720 :v4l2-height=3D480 :v4l2-standard=3D0 --sout
> '#transcode{vcodec=3Dmp4v,vb=3D6000,fps=3D30,scale=3D1,acodec=3Dmpga,ab=
=3D32,channels=3D1}:duplicate{dst=3Drtp{mux=3Dts,port=3D1234,sdp=3Drtsp://1=
92.168.1.179:8080/test.sdp}}'
> vlc://quit"
>
> Best Regards,
> --
> Rob Krakora
> Senior Software Engineer
> MessageNet Systems
> 101 East Carmel Dr. Suite 105
> Carmel, IN 46032
> (317)566-1677 Ext. 206
> (317)663-0808 Fax
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>



-- =

Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
