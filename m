From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Re: Getting a full device list
Date: Mon, 14 May 2007 12:38:49 +0200
Message-ID: <46483C39.6090300@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>	<4627B015.7030401@gmail.com>	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>	<4644455B.4080706@gmail.com>	<Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>	<46444E00.1040808@gmail.com>	<s5hfy63iea8.wl%tiwai@suse.de>	<46481FA0.8050803@gmail.com>	<s5hhcqfhifg.wl%tiwai@suse.de>	<46482B8A.9080604@gmail.com>
	<s5h646vhgnn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id C13F524738
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 12:38:53 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so927244ugf
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 03:38:53 -0700 (PDT)
In-Reply-To: <s5h646vhgnn.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>> 	defaults.namehint.showall on
>> and
>> 	defaults.namehint.!showall 1
>>
>> for my tests - my results are in the previous email.
> 
> Hm, do you see any change in "aplay -L" output with and without this
> definition?

No, "aplay -L" gives the same list with or without the option. I tried
changing it in /usr/share/alsa/alsa.conf as well, but the change had no effect.

NB: this is with 1.0.14rc4.


nicholas@Nicholas:~$ aplay -L
default:CARD=V8237
    VIA 8237, VIA 8237
    Default Audio Device
front:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    Front speakers
surround40:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    4.0 Surround output to Front and Rear speakers
surround41:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
iec958:CARD=V8237,DEV=0
    VIA 8237, VIA 8237
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=UART
    MPU-401 UART
    Default Audio Device
default:CARD=PAD
    RME Digi96/8 PAD, Digi96 IEC958
    Default Audio Device

nicholas@Nicholas:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
card 0: V8237 [VIA 8237], device 1: VIA 8237 [VIA 8237]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: PAD [RME Digi96/8 PAD], device 0: Digi96 IEC958 [Digi96 IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: PAD [RME Digi96/8 PAD], device 1: Digi96 ADAT [Digi96 ADAT]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
