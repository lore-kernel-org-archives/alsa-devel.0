From: Kailang <kailang@realtek.com>
Subject: Re: hp_pin was NULL value
Date: Tue, 15 Jan 2019 07:43:40 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184210E5@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18420E8B@RTITMBSV02.realtek.com.tw>
 <s5htviigoa5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18420EBD@RTITMBSV02.realtek.com.tw>
 <s5hlg3ux9x9.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210B1@RTITMBSV02.realtek.com.tw>
 <s5hh8eah1fj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 59DB1266ABE
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 08:43:48 +0100 (CET)
In-Reply-To: <s5hh8eah1fj.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


No, it not expected.
It will enter two times after boot ready.
I think it could add a flag in alc225_hp_init(). 
To make sure it only excute one time. How do you think about?

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Tuesday, January 15, 2019 2:37 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: hp_pin was NULL value

On Tue, 15 Jan 2019 03:31:33 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> Could you receive this email?
> 
> BR,
> Kailang
> 
> -----Original Message-----
> From: Kailang
> Sent: Thursday, January 10, 2019 11:14 AM
> To: 'Takashi Iwai' <tiwai@suse.de>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: RE: hp_pin was NULL value
> 
> Hi Takashi,
> 
> I simulate test your prefer function.
> I put alc225_hp_init() in alc225_init().
> If system boot ready, I write 1 to power_save of /sys/module/....
> The print message as below. It called two times until boot ready.
> If System enter to power save, play stream will wake up codec. It also call alc225_hp_init().
> 
> [   21.497524] alc225_init hp_pin=0x21
> [   21.497526] alc225_hp_init-s hp=0x21
> [   22.140076] alc225_hp_init-e hp=0x21
> [   22.183496] snd_hda_codec_realtek hdaudioC0D2: Headset jack set to unplugged mode.
> [   22.184681] snd_hda_codec_realtek hdaudioC0D2: Headset jack set to unplugged mode.
> [   22.186846] alc225_shutup hp_pin=0x21
> [   22.187831] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
> [   22.188055] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
> [   22.205104] alc225_init hp_pin=0x21
> [   22.205108] alc225_hp_init-s hp=0x21
> [   22.852123] alc225_hp_init-e hp=0x21
> [   22.894772] snd_hda_codec_realtek hdaudioC0D2: Headset jack set to unplugged mode.
> ############  Boot ready ############## [  116.832084] alc225_shutup 
> hp_pin=0x21  ==> echo 1 to power_save
> [  120.002582] alc225_init hp_pin=0x21     ==> play system sound
> [  120.002586] alc225_hp_init-s hp=0x21 [  120.644128] 
> alc225_hp_init-e hp=0x21

It wasn't clear to me whether you meant this as a success or a failure...  Did the patch work as expected, no?


thanks,

Takashi

------Please consider the environment before printing this e-mail.
