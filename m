From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Tue, 22 May 2012 19:22:46 +0100
Message-ID: <CAE-xCyPEhMQjPYdbSShDo8P6nEeYSrKWJdKTMi+B_ws7Wq8sUA@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
	<CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
	<4FBAC776.9060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0970E2415E
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 20:22:47 +0200 (CEST)
Received: by vbip1 with SMTP id p1so4363385vbi.38
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2012 11:22:47 -0700 (PDT)
In-Reply-To: <4FBAC776.9060801@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Hello Daniel,

Here are the results of today's testing.
I don't know if they'll help in anyway, but here we go.


BOOT WITH THE UA-25EX

Trying to use aplay:

blablack@igorito:~$ aplay 10\ -\ Track\ 10-L.wav
ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:4241:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_concat
returned error: No such file or directory
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_refer
returned error: No such file or directory
ALSA lib conf.c:4720:(snd_config_expand) Evaluate error: No such file
or directory
ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:682: audio open error: No such file or directory

blablack@igorito:~$ aplay -D default:CARD=3DUA25EX 10\ -\ Track\ 10-L.wav

Second one work ok... Let it play for several minutes and it's all fine.


BOOT WITH THE FTU

blablack@igorito:~$ aplay 10\ -\ Track\ 10-L.wav
ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:4241:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_concat
returned error: No such file or directory
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_refer
returned error: No such file or directory
ALSA lib conf.c:4720:(snd_config_expand) Evaluate error: No such file
or directory
ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:682: audio open error: No such file or directory

blablack@igorito:~$ aplay -D default:CARD=3DUltra 10\ -\ Track\ 10-L.wav

No sound...
I tried to reboot several times, unplug/replug, checked alsamixer: all
look fine to me but still no sound.
Actually, it is not "exactly" no sound: I can see the 4 front leds
flash very quickly, and I can hear a click in the speakers (with the
FX, the click is longer due to the reverb, handy to notice it!).

Using mplayer...well I don't know if I'm just an idiot or if there is
a deeper problem, but I can't get the alsa parameter to connect to the
sound card. And if I don't specify the -ao parameter, I get the same
error as aplay "cannot find card 0".

Using VLC, I can see that VLC doesn't get stuck but plays something,
unfortunately, still no sound.


In dmesg, I get:
[    3.031270] usb 2-1.2: new high-speed USB device number 3 using ehci_hcd
[    3.118175] usb 2-1.2: config 1 interface 3 altsetting 0 bulk
endpoint 0x7 has invalid maxpacket 8
[    3.118185] usb 2-1.2: config 1 interface 3 altsetting 0 bulk
endpoint 0x87 has invalid maxpacket 8
...
[   18.090854] ALSA mixer.c:796 usb-audio: set quirks for FTU Effect
Feedback/Volume
[   18.107831] ALSA mixer.c:787 usb-audio: set quirk for FTU Effect Duration
[   18.109496] ALSA mixer.c:796 usb-audio: set quirks for FTU Effect
Feedback/Volume

The first error message is "ok" I far as I remember, and the second
message shows the detection of the FTU - all look fine to me...



IN BOTH CASES, FTU AND UA-25EX

Starting jack result in an immediate freeze of the system.


If there is anything else I can provide to you, let me know.
Hope all this help somehow!

Aur=E9lien
