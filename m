From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Port C Out selector ,
	Port E Out selector of ad1988 and ad1988_3stack_dac_nids
Date: Sat, 17 Sep 2011 07:12:00 +0800
Message-ID: <CAN8cciYz7a52ZqVS8y72FkhWDFFZixpmFT-Esr8Q5jCmqim7yw@mail.gmail.com>
References: <CAN8cciYcxG0tyrz-_eX35Nfk=3MT4K2f18fV3=8EyUTD==0B9Q@mail.gmail.com>
	<s5hipott3e2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA1CD10383E
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 01:12:02 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2215206fxe.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 16:12:01 -0700 (PDT)
In-Reply-To: <s5hipott3e2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/16 Takashi Iwai <tiwai@suse.de>:
> At Fri, 16 Sep 2011 11:59:54 +0800,
> Raymond Yau wrote:
>>
>> 2011/9/12 Takashi Iwai <tiwai@suse.de>:
>> > At Wed, 31 Aug 2011 11:21:00 +0800,
>> > Raymond Yau wrote:
>> >>
>> >> HDA - Add Headphone Playback Volume control for ad1988/ad1989
>> >>
>> >> - use DAC0 instead of DAC1 for Port-A Headphone
>> >> - assign 0x03 to spec->multiout.hp_nid except model=3D"6stack-dig-fp"
>> >
>> > Thanks, applied now.
>> >
>> >
>> > Takashi
>> >
>>
>> while testing the headphone volume control ,
>>
>> I discover that the "Port C Out selector" and "Port E Out Selector"
>> (i.e. node 0x31 and 0x32 ) by commit in patch_anlog.c
>>
>> fd66e0d0591dd12eb0bea1e9f3aa194bb93cebbd
>>
>>
>>
>> =A0* AD1988
>> =A0*
>> =A0* Output pins and routes
>> =A0*
>> =A0* =A0 =A0 =A0 =A0Pin =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mix =A0 =A0 Sel =A0 =
=A0 DAC
>> =A0* port-A 0x11 (mute/hp) <- 0x22 <- 0x37 <- 03/04/06
>> =A0* port-B 0x14 (mute/hp) <- 0x2b <- 0x30 <- 03/04/06
>> =A0* port-C 0x15 (mute) =A0 =A0<- 0x2c <- 0x31 <- 05/0a
>> =A0* port-D 0x12 (mute/hp) <- 0x29 =A0 =A0 =A0 =A0 <- 04
>> =A0* port-E 0x17 (mute/hp) <- 0x26 <- 0x32 <- 05/0a
>>
>>
>>
>> The connection list of node 0x31 and 0x32 are different from datasheet
>>
>>
>> Table 10. Audio Widget
>>
>> 31 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Audio selector Se=
lects DAC_2 and DAC_4 for PORT-C
>> =A0 =A0 =A0PORT-E Out Selector
>> 32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Audio selector Se=
lects DAC_2 and DAC_4 for PORT-E
>> =A0 =A0 =A0PORT-C In Selector
>>
>>
>>
>> Codec: Analog Devices AD1988
>> Address: 0
>> AFG Function Id: 0x1 (unsol 0)
>> Vendor Id: 0x11d41988
>> Subsystem Id: 0x104381e1
>> Revision Id: 0x100400
>>
>>
>> Node 0x31 [Audio Selector] wcaps 0x300101: Stereo
>> =A0 Connection: 2
>> =A0 =A0 =A00x04* 0x0a
>> Node 0x32 [Audio Selector] wcaps 0x300101: Stereo
>> =A0 Connection: 2
>> =A0 =A0 =A00x05* 0x04
>>
>>
>>
>> is the following patch based on real hardware ?
>>
>>
>> commit 8c7c7b8dd2828b42c1230c6b0235e7d1dcf57e5
>>
>> hda-codec - Fix surrounds on 3stack mode of AD1988
>
> I don't see this commit id in my tree...
>
>
> Takashi
>

http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3Dfd66e0d0591=
dd12eb0bea1e9f3aa194bb93cebbd

Thu, 17 Nov 2005 14:31:34 +0000 (15:31 +0100)
Add AD1988 codec support to hda-codec driver.


http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Df8c7c7b=
8dd2828b42c1230c6b0235e7d1dcf57e5;hp=3Dd32410b1095cf93e8e31f8919de46f496d7b=
3ce0

Thu, 24 Nov 2005 15:17:20 +0000 (16:17 +0100)]
Fixed the swapped surround/CLFE on 3stack mode of AD1988.


hda-emu codecs/ad1988a -m "3stack"
route -a 0x15

Out[0a] -x Sel[31] -- Mix[2c] -> Pin[15]
Out[04] -> Sel[31] -- Mix[2c] -> Pin[15]

route -a 0x17

Out[04] -> Sel[32] -- Mix[26] -> Pin[17]
Out[05] -x Sel[32] -- Mix[26] -> Pin[17]
