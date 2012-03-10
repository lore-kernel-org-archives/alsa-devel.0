From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Port C Out selector ,
 Port E Out selector of ad1988 and ad1988_3stack_dac_nids
Date: Sat, 10 Mar 2012 09:50:58 +0800
Message-ID: <CAN8cciaHNbHhcq9k3C9jxShpY51JFga-AqkmAfrGtEtqei+Dhg@mail.gmail.com>
References: <CAN8cciYcxG0tyrz-_eX35Nfk=3MT4K2f18fV3=8EyUTD==0B9Q@mail.gmail.com>
	<s5hipott3e2.wl%tiwai@suse.de>
	<CAN8cciYz7a52ZqVS8y72FkhWDFFZixpmFT-Esr8Q5jCmqim7yw@mail.gmail.com>
	<CAN8ccib9a+159ECp8JBraXYn9rqLU9QRw7jdngqhe1ryM3qU3Q@mail.gmail.com>
	<s5hvcsnz28c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id EC33F244CA
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 02:50:58 +0100 (CET)
Received: by wibhm17 with SMTP id hm17so1039392wib.2
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 17:50:58 -0800 (PST)
In-Reply-To: <s5hvcsnz28c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/20, Takashi Iwai <tiwai@suse.de>:
> At Tue, 20 Sep 2011 20:46:47 +0800,
> Raymond Yau wrote:
>>
>> 2011/9/17 Raymond Yau <superquad.vortex2@gmail.com>:
>> > 2011/9/16 Takashi Iwai <tiwai@suse.de>:
>> >> At Fri, 16 Sep 2011 11:59:54 +0800,
>> >> Raymond Yau wrote:
>> >>>
>> >>> 2011/9/12 Takashi Iwai <tiwai@suse.de>:
>> >>> > At Wed, 31 Aug 2011 11:21:00 +0800,
>> >>> > Raymond Yau wrote:
>> >>> >>
>> >>>
>> >>> while testing the headphone volume control ,
>> >>>
>> >>> I discover that the "Port C Out selector" and "Port E Out Selector"
>> >>> (i.e. node 0x31 and 0x32 ) by commit in patch_anlog.c
>> >>>
>> >>> fd66e0d0591dd12eb0bea1e9f3aa194bb93cebbd
>> >>>
>> >>>
>> >>>
>> >>>  * AD1988
>> >>>  *
>> >>>  * Output pins and routes
>> >>>  *
>> >>>  *        Pin               Mix     Sel     DAC
>> >>>  * port-A 0x11 (mute/hp) <- 0x22 <- 0x37 <- 03/04/06
>> >>>  * port-B 0x14 (mute/hp) <- 0x2b <- 0x30 <- 03/04/06
>> >>>  * port-C 0x15 (mute)    <- 0x2c <- 0x31 <- 05/0a
>> >>>  * port-D 0x12 (mute/hp) <- 0x29         <- 04
>> >>>  * port-E 0x17 (mute/hp) <- 0x26 <- 0x32 <- 05/0a
>> >>>
>> >>>
>> >>>
>> >>> The connection list of node 0x31 and 0x32 are different from datasheet
>> >>>
>> >>>
>> >>> Table 10. Audio Widget
>> >>>
>> >>> 31                           Audio selector Selects DAC_2 and DAC_4
>> >>> for PORT-C
>> >>>      PORT-E Out Selector
>> >>> 32                           Audio selector Selects DAC_2 and DAC_4
>> >>> for PORT-E
>> >>>      PORT-C In Selector
>> >>>
>> >>>
>> >>>
>> >>> Codec: Analog Devices AD1988
>> >>> Address: 0
>> >>> AFG Function Id: 0x1 (unsol 0)
>> >>> Vendor Id: 0x11d41988
>> >>> Subsystem Id: 0x104381e1
>> >>> Revision Id: 0x100400
>> >>>
>> >>>
>> >>> Node 0x31 [Audio Selector] wcaps 0x300101: Stereo
>> >>>   Connection: 2
>> >>>      0x04* 0x0a
>> >>> Node 0x32 [Audio Selector] wcaps 0x300101: Stereo
>> >>>   Connection: 2
>> >>>      0x05* 0x04
>> >>>
>> >>>
>> >>>
>> >>> is the following patch based on real hardware ?
>> >>>
>> >
>> > http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=fd66e0d0591dd12eb0bea1e9f3aa194bb93cebbd
>> >
>> > Thu, 17 Nov 2005 14:31:34 +0000 (15:31 +0100)
>> > Add AD1988 codec support to hda-codec driver.
>> >
>> >
>> > http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=f8c7c7b8dd2828b42c1230c6b0235e7d1dcf57e5;hp=d32410b1095cf93e8e31f8919de46f496d7b3ce0
>> >
>> > Thu, 24 Nov 2005 15:17:20 +0000 (16:17 +0100)]
>> > Fixed the swapped surround/CLFE on 3stack mode of AD1988.
>> >
>> >
>> > hda-emu codecs/ad1988a -m "3stack"
>> > route -a 0x15
>> >
>> > Out[0a] -x Sel[31] -- Mix[2c] -> Pin[15]
>> > Out[04] -> Sel[31] -- Mix[2c] -> Pin[15]
>> >
>> > route -a 0x17
>> >
>> > Out[04] -> Sel[32] -- Mix[26] -> Pin[17]
>> > Out[05] -x Sel[32] -- Mix[26] -> Pin[17]
>> >
>>
>> In simple word,
>>
>> surround51 does not work with 3stack model since the above route in
>> hda-emu indicate that blue jack and pink jack are connected to DAC1
>> (node 0x4)
>
> Oh, care to create a fix patch? :)
>
>
> thanks,
>
> Takashi
>

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5087

SergeyR replied that the patch work with his Asus M2N

ad1988_3stack_surround51.patch  2011-09-30 12:33


However does the following patch has any side effect for motherboard
with 3 audio jacks ?

seem the blue jack and pink jack are retasked to wrong output channels


8fa7ab48acb636d24669dab291807b487dfb2804

26 Oct 2011

ALSA: hda - Fix surround/CLFE headphone and speaker pins order

When 5.1 or more headphone or speaker pins are provided, the parser still
takes as is without fixing the order of channel mapping, which leads in
the unexpected strange channel order by surround outputs.

This patch fixes the issue by applying the same fix-up not only to
line_out_pins[] but also hp_pins[] and speaker_pins[].
