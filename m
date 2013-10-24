From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Thu, 24 Oct 2013 22:06:28 +0300
Message-ID: <52696FB4.1090704@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>	
 <1380870371.875.14.camel@Wailaba2> <524F51C6.7050203@iki.fi>	
 <1381031338.10109.2.camel@Wailaba2> <5251528B.4010506@iki.fi>
 <1381293134.845.4.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 877472615F7
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 21:06:32 +0200 (CEST)
In-Reply-To: <1381293134.845.4.camel@Wailaba2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Langlois <olivier@trillion01.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hmm, I thought I replied to this but I guess not...

09.10.2013 07:32, Olivier Langlois kirjoitti:
> 
>>
>> Then please test everything again. I.e.
>>   o speaker-test -D hdmi:CARD=Generic,DEV=0 -c8 -r192000 -F S32_LE
>>
> this work fine
> 
>>   o Is there any difference seen
>>     with these, in the beginning/end (i.e. fade-out/in):
>>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x04 -c2 -r48000
>>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x06 -c2 -r48000
>>
> I have the same result as before the last fix. AES0=0x04 works
> AES0=0x06 doesn't. No error is emitted from speaker-test but no sound is
> coming out speakers.

OK, that is actually expected, didn't think the test through :)

>>   o Also, is there a difference in the beginning of these
>>     (maybe garbage sound and/or slightly slower startup?):
>>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=4 -r44100 -f s16_le -c2
>> testi.dts.cut.spdif
>>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2
>> testi.dts.cut.spdif
> 
> no garbage. Maybe slightly slower startup with AES0=0x6.

OK, a bit unexpected but not totally strange.

>>
>>   o Contents of /proc/asound/cardX/eld#0.0
>>
>> Thanks a lot :)
>>
> monitor_present		1
> eld_valid		1
> monitor_name		SC-09TX
> connection_type		HDMI
[...]

Looks OK, thanks for testing. Do you happen to have an EDID handy for
the receiver, just to double-check the data matches? Not sure how it is
available with fglrx driver, maybe in /var/log/Xorg.0.log...
No need to go to extraordinary lengths to get it, though :)

-- 
Anssi Hannula
