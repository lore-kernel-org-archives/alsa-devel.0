From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi: Control naming, Irritated Currant edition
Date: Thu, 07 Oct 2010 11:55:24 +1300
Message-ID: <4CACFE5C.4080209@audioscience.com>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
	<4CA4F1D8.50800@audioscience.com> <s5haamz9che.wl%tiwai@suse.de>
	<4CAAB343.9040603@audioscience.com> <4CAACEAF.2070208@ladisch.de>
	<4CAADE8F.9030104@audioscience.com> <4CAAF420.9090805@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3EE103805
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 00:55:29 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L9W003R150CMN10@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 07 Oct 2010 11:55:26 +1300 (NZDT)
In-reply-to: <4CAAF420.9090805@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your comments

FYI Here is what I now have for ASI6644 mode 1 (4 player)
http://audioscience.com/internet/products/sound_cards/asi664x.htm

I think it conforms, in that Playback or Capture is the second to last
word, and the last word is the control type. (?)
Of course I'm open to suggestions how to improve further...

numid=1,iface=MIXER,name='Line 0 Capture Level'
numid=2,iface=MIXER,name='Line 1 Capture Level'
numid=3,iface=MIXER,name='Line 2 Capture Level'
numid=4,iface=MIXER,name='Line 3 Capture Level'
numid=5,iface=MIXER,name='Digital 0 Capture Format'
numid=6,iface=MIXER,name='Digital 0 Capture Status'
numid=7,iface=MIXER,name='Digital 1 Capture Format'
numid=8,iface=MIXER,name='Digital 1 Capture Status'
numid=9,iface=MIXER,name='Digital 2 Capture Format'
numid=10,iface=MIXER,name='Digital 2 Capture Status'
numid=11,iface=MIXER,name='Digital 3 Capture Format'
numid=12,iface=MIXER,name='Digital 3 Capture Status'
numid=13,iface=MIXER,name='Clock 0 Capture Format'
numid=14,iface=MIXER,name='Clock 0 Capture Status'
numid=15,iface=MIXER,name='Line 0 Capture Route'
numid=16,iface=MIXER,name='Line 1 Capture Route'
numid=17,iface=MIXER,name='Line 2 Capture Route'
numid=18,iface=MIXER,name='Line 3 Capture Route'
numid=19,iface=MIXER,name='PCM0 Line0 Playback Volume'
numid=20,iface=MIXER,name='PCM1 Line0 Playback Volume'
numid=21,iface=MIXER,name='PCM2 Line0 Playback Volume'
numid=22,iface=MIXER,name='PCM3 Line0 Playback Volume'
numid=23,iface=MIXER,name='Line0 Line0 Monitor Playback Volume'
numid=24,iface=MIXER,name='Line1 Line0 Monitor Playback Volume'
numid=25,iface=MIXER,name='Line2 Line0 Monitor Playback Volume'
numid=26,iface=MIXER,name='Line3 Line0 Monitor Playback Volume'
numid=27,iface=MIXER,name='Line 0 Playback Volume'
numid=28,iface=MIXER,name='PCM0 Line1 Playback Volume'
numid=29,iface=MIXER,name='PCM1 Line1 Playback Volume'
numid=30,iface=MIXER,name='PCM2 Line1 Playback Volume'
numid=31,iface=MIXER,name='PCM3 Line1 Playback Volume'
numid=32,iface=MIXER,name='Line0 Line1 Monitor Playback Volume'
numid=33,iface=MIXER,name='Line1 Line1 Monitor Playback Volume'
numid=34,iface=MIXER,name='Line2 Line1 Monitor Playback Volume'
numid=35,iface=MIXER,name='Line3 Line1 Monitor Playback Volume'
numid=36,iface=MIXER,name='Line 1 Playback Volume'
numid=37,iface=MIXER,name='PCM0 Line2 Playback Volume'
numid=38,iface=MIXER,name='PCM1 Line2 Playback Volume'
numid=39,iface=MIXER,name='PCM2 Line2 Playback Volume'
numid=40,iface=MIXER,name='PCM3 Line2 Playback Volume'
numid=41,iface=MIXER,name='Line0 Line2 Monitor Playback Volume'
numid=42,iface=MIXER,name='Line1 Line2 Monitor Playback Volume'
numid=43,iface=MIXER,name='Line2 Line2 Monitor Playback Volume'
numid=44,iface=MIXER,name='Line3 Line2 Monitor Playback Volume'
numid=45,iface=MIXER,name='Line 2 Playback Volume'
numid=46,iface=MIXER,name='PCM0 Line3 Playback Volume'
numid=47,iface=MIXER,name='PCM1 Line3 Playback Volume'
numid=48,iface=MIXER,name='PCM2 Line3 Playback Volume'
numid=49,iface=MIXER,name='PCM3 Line3 Playback Volume'
numid=50,iface=MIXER,name='Line0 Line3 Monitor Playback Volume'
numid=51,iface=MIXER,name='Line1 Line3 Monitor Playback Volume'
numid=52,iface=MIXER,name='Line2 Line3 Monitor Playback Volume'
numid=53,iface=MIXER,name='Line3 Line3 Monitor Playback Volume'
numid=54,iface=MIXER,name='Line 3 Playback Volume'
numid=55,iface=MIXER,name='PCM 0 Playback Volume'
numid=56,iface=MIXER,name='PCM 1 Playback Volume'
numid=57,iface=MIXER,name='PCM 2 Playback Volume'
numid=58,iface=MIXER,name='PCM 3 Playback Volume'
numid=59,iface=MIXER,name='Line 0 Capture Volume'
numid=60,iface=MIXER,name='Line 1 Capture Volume'
numid=61,iface=MIXER,name='Line 2 Capture Volume'
numid=62,iface=MIXER,name='Line 3 Capture Volume'
numid=63,iface=MIXER,name='Line 0 Capture Meter'
numid=64,iface=MIXER,name='Line 1 Capture Meter'
numid=65,iface=MIXER,name='Line 2 Capture Meter'
numid=66,iface=MIXER,name='Line 3 Capture Meter'
numid=67,iface=MIXER,name='Line 0 Playback Meter'
numid=68,iface=MIXER,name='Line 1 Playback Meter'
numid=69,iface=MIXER,name='Line 2 Playback Meter'
numid=70,iface=MIXER,name='Line 3 Playback Meter'
numid=71,iface=MIXER,name='Line0 Line0 Monitor Playback Mode'
numid=72,iface=MIXER,name='Line1 Line0 Monitor Playback Mode'
numid=73,iface=MIXER,name='Line2 Line0 Monitor Playback Mode'
numid=74,iface=MIXER,name='Line3 Line0 Monitor Playback Mode'
numid=75,iface=MIXER,name='Line 0 Playback Level'
numid=76,iface=MIXER,name='Line 1 Playback Level'
numid=77,iface=MIXER,name='Line 2 Playback Level'
numid=78,iface=MIXER,name='Line 3 Playback Level'
numid=79,iface=MIXER,name='Digital 0 Playback Format'
numid=80,iface=MIXER,name='Digital 1 Playback Format'
numid=81,iface=MIXER,name='Digital 2 Playback Format'
numid=82,iface=MIXER,name='Digital 3 Playback Format'
numid=83,iface=MIXER,name='PCM 0 Playback Meter'
numid=84,iface=MIXER,name='PCM 1 Playback Meter'
numid=85,iface=MIXER,name='PCM 2 Playback Meter'
numid=86,iface=MIXER,name='PCM 3 Playback Meter'
numid=87,iface=MIXER,name='PCM 0 Playback Mode'
numid=88,iface=MIXER,name='PCM 1 Playback Mode'
numid=89,iface=MIXER,name='PCM 2 Playback Mode'
numid=90,iface=MIXER,name='PCM 3 Playback Mode'
numid=91,iface=MIXER,name='PCM 0 Capture Route'
numid=92,iface=MIXER,name='PCM 1 Capture Route'
numid=93,iface=MIXER,name='PCM 2 Capture Route'
numid=94,iface=MIXER,name='PCM 3 Capture Route'
numid=95,iface=MIXER,name='PCM 0 Capture Mode'
numid=96,iface=MIXER,name='PCM 1 Capture Mode'
numid=97,iface=MIXER,name='PCM 2 Capture Mode'
numid=98,iface=MIXER,name='PCM 3 Capture Mode'
numid=99,iface=MIXER,name='PCM 0 Capture Meter'
numid=100,iface=MIXER,name='PCM 1 Capture Meter'
numid=101,iface=MIXER,name='PCM 2 Capture Meter'
numid=102,iface=MIXER,name='PCM 3 Capture Meter'
numid=103,iface=MIXER,name='Clock 0 Capture Source'
numid=104,iface=MIXER,name='Clock 0 Capture Localrate'
numid=105,iface=MIXER,name='Clock 0 Capture Rate'

And example capture source selector
numid=93,iface=MIXER,name='PCM 2 Capture Route'
  ; type=ENUMERATED,access=rw------,values=1,items=8
  ; Item #0 'Line 0'
  ; Item #1 'Line 1'
  ; Item #2 'Line 2'
  ; Item #3 'Line 3'
  ; Item #4 'PCM 0'
  ; Item #5 'PCM 1'
  ; Item #6 'PCM 2'
  ; Item #7 'PCM 3'
  : values=2

Input analog/digital select.
numid=15,iface=MIXER,name='Line 0 Capture Route'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Line 0'
  ; Item #1 'Digital 0'
  : values=0

-- 
Eliot Blennerhassett
AudioScience Inc.
