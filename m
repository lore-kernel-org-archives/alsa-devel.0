From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [alsa-devel] [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD multi-channel
 and HBR support
Date: Sun, 06 Oct 2013 15:07:39 +0300
Message-ID: <5251528B.4010506@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>  <1380870371.875.14.camel@Wailaba2> <524F51C6.7050203@iki.fi> <1381031338.10109.2.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381031338.10109.2.camel@Wailaba2>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Langlois <olivier@trillion01.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, linux-kernel@vger.kernel.org, =?UTF-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

06.10.2013 06:48, Olivier Langlois kirjoitti:
> 
>>>>
>>>>   o Contents of /proc/asound/cardX/eld#0. I'd like to see the contents
>>>>     both with radeon and with the proprietary fglrx driver in use
>>>>
>>> With fglrx 13.10 Beta 2:
>>>
>>> lano1106@whippet2 /proc/asound/card0 $ cat codec#0 
>>
>> Note I said eld#0, not codec#0 :)
>>
>> Though I guess the correct filename is actually eld#0.0.
>>
>> [...]
>>
> My mistake.
> 
> Here is the good content:
[...]

Does not look right. And after looking at the code I saw quite a big bug
which caused all of the rev3+ features to not work :)

Please change 0x1002791a to 0x1002aa01 in this part in the end of
sound/pci/hda/hda_local.h:

#define is_amdhdmi_rev3(codec) \
	((codec)->vendor_id == 0x1002791a && ((codec)->revisi

Then please test everything again. I.e.
  o speaker-test -D hdmi:CARD=Generic,DEV=0 -c8 -r192000 -F S32_LE

  o Is there any difference seen
    with these, in the beginning/end (i.e. fade-out/in):
    speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x04 -c2 -r48000
    speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x06 -c2 -r48000

  o Also, is there a difference in the beginning of these
    (maybe garbage sound and/or slightly slower startup?):
    aplay -Dhdmi:CARD=Generic,DEV=0,AES0=4 -r44100 -f s16_le -c2
testi.dts.cut.spdif
    aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2
testi.dts.cut.spdif

  o Contents of /proc/asound/cardX/eld#0.0

Thanks a lot :)

-- 
Anssi Hannula
