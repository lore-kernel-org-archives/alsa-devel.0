From: Chris Rankin <rankincj@yahoo.com>
Subject: Why is a USB capture device showing up in "aplay -L"?
Date: Sat, 1 Dec 2007 15:58:41 +0000 (GMT)
Message-ID: <574657.43424.qm@web52911.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52911.mail.re2.yahoo.com (web52911.mail.re2.yahoo.com
	[206.190.49.21]) by alsa0.perex.cz (Postfix) with SMTP id C25EA103800
	for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2007 16:58:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a webcam which has microphone-only USB audio capability. However, not only has this device
stopped recording anything but it has also vanished from the "arecord -L" list and appeared in the
"aplay -L" one instead:

$ arecord -L
default:CARD=Audigy2
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Default Audio Device
front:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Front speakers
rear:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Rear speakers
center_lfe:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Center and Subwoofer speakers
side:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Side speakers
surround40:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

and:

$ aplay -L
default:CARD=Audigy2
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Default Audio Device
front:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Front speakers
rear:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Rear speakers
center_lfe:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Center and Subwoofer speakers
side:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    Side speakers
surround40:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Audigy2,DEV=0
    Audigy 2 ZS [SB0353], ADC Capture/Standard PCM Playback
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=WebCam
    USB Device 0x46d:0x8b4, USB Audio
    Default Audio Device
front:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    Front speakers
surround40:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=WebCam,DEV=0
    USB Device 0x46d:0x8b4, USB Audio
    IEC958 (S/PDIF) Digital Audio Output

Here is my .asoundrc file:

ctl.Audigy2 {
        type hw
        card 0
}

pcm.Audigy2 {
        type plug
        slave {
                pcm "hw:0,0"
        }
}

ctl.webcam {
        type hw
        card 1
}

pcm.webcam {
        type plug
        slave {
                pcm "hw:1,0"
        }
}

and here is what /proc/asound looks like:

]$ ls -als /proc/asound/
total 0
0 dr-xr-xr-x   6 root root 0 2007-12-01 15:55 .
0 dr-xr-xr-x 172 root root 0 2007-12-01 14:37 ..
0 lrwxrwxrwx   1 root root 5 2007-12-01 15:55 Audigy2 -> card0
0 dr-xr-xr-x  11 root root 0 2007-12-01 15:55 card0
0 dr-xr-xr-x   3 root root 0 2007-12-01 15:55 card1
0 -r--r--r--   1 root root 0 2007-12-01 15:55 cards
0 -r--r--r--   1 root root 0 2007-12-01 15:55 devices
0 -r--r--r--   1 root root 0 2007-12-01 15:55 hwdep
0 -r--r--r--   1 root root 0 2007-12-01 15:55 modules
0 dr-xr-xr-x   2 root root 0 2007-12-01 15:55 oss
0 -r--r--r--   1 root root 0 2007-12-01 15:55 pcm
0 dr-xr-xr-x   2 root root 0 2007-12-01 15:55 seq
0 -r--r--r--   1 root root 0 2007-12-01 15:55 timers
0 -r--r--r--   1 root root 0 2007-12-01 15:55 version
0 lrwxrwxrwx   1 root root 5 2007-12-01 15:55 WebCam -> card1

This happens with both Fedora 7 and Fedora 8. Could there be a problem with the snd-usb-audio
kernel module, please?

Cheers,
Chris




      ___________________________________________________________
Yahoo! Answers - Got a question? Someone out there knows the answer. Try it
now.
http://uk.answers.yahoo.com/ 
