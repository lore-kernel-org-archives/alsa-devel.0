From: Kailang <kailang@realtek.com>
Subject: Re: Enable HP machine to enable capture mute led
	and	output mute led
Date: Tue, 1 Jul 2014 11:50:06 +0800
Message-ID: <B0BC998895E24EDD8F0A8F1953953826@realtek.com.tw>
References: <44B3EABECDE540079327D32092FF47FF@realtek.com.tw>
 <s5hions7x43.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F39261B2A
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 05:50:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Our AE didn't tell me the ID is codec subsystem ID.
HP had some machine PCI subsystem ID and codec subsystem ID not the same.
So, more machine will use one PCI subsystem ID.
Use codec subsystem ID to filter models.

BR,
Kailang

> At Fri, 20 Jun 2014 15:55:58 +0800,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> Maybe you don't receive.
>> I repost again.
>
> Don't worry, it's been applied now.  I've been off for a few days.
>
>
> thanks,
>
> Takashi
>
>>
>> BR,
>> Kailang
>>
>>
>> > Attach again.
>> > It include below infomations.
>> > Thanks.
>> >
>> >> At Wed, 18 Jun 2014 17:13:57 +0800,
>> >> Kailang wrote:
>> >>>
>> >>> Hi Takashi,
>> >>>
>> >>> Attach was HP mute led support patch.
>> >>> It use Line1 vref and Mic1 vref to control mute led for ALC282.
>> >>> Line1 vref to control output mute led.
>> >>> Mic1 vref to control input mute led.
>> >>>
>> >>> It use GPIO3 and Mic1 vref to control mute led for ALC280.
>> >>> GPIO3 to control output mute led.
>> >>> Mic1 vref to control input mute led.
>> >>
>> >> Could you include this kind of information in the patch changelog?
>> >> The changelog text is way too short.
>> >>
>> >>> For the DMI string for output mute led application.
>> >>> I already request from HP to support it in next release.
>> >>>
>> >>> HP_Mute_LED_0_A  => use Mic1 vref to control mute led.
>> >>> Is the string right?
>> >>> I have tested upper string for Mic1 mute led.
>> >>
>> >> Yes, this has been working for some machines, AFAIK.
>> >>
>> >>
>> >> thanks,
>> >>
>> >> Takashi
>> >>
>> >> ------Please consider the environment before printing this e-mail.
>> [2 0001-new-hp-mute-led.patch <application/octet-stream 
>> (quoted-printable)>]
>> 
