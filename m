From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx) => XFire
 too
Date: Thu, 05 Dec 2002 12:48:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF3D01.4040903@gmx.de>
References: <200211170056.11190.puetzk@iastate.edu> <3DDEC512.7030108@cucumelo.org> <3DED2F26.2070805@gmx.de> <200212031745.48194.puetzk@iastate.edu> <3DEDC234.40602@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Kevin Puetz <puetzk@iastate.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  Hi Kevin, hi Benny,

with your changes applied, now both PCM channels have the same phase 
with my XFire. The stereo image makes much more sense that way :-). 
Thanks a lot!

What I've noticed: Switching the 'PCM Out' control from 'pre 3D' to 
'post 3D' inverts the sign of both l&r channels. (behaviour is 
independent of '3D depth', '3D center' and '3D switch' controls). But 
that doesn't cause any problems, at least with stereo output (which is 
the only mode the XFire works for now). With >2 channel output on other 
cs46xx cards this could perhaps cause problems if the phase of the 
rear/LFE/center channels doesn't match the left/right channel phase any 
more. But I can't check this with my card.

@Benny:
Another problem: SPDIF input doesn't work anymore since I applied the 
patch attached in your mail on 11/23/02. There is no 'SPDIF ac3 mode' in 
alsamixer after patching. Is this correct? And I noticed that I can't 
change the SPDIF input volume for left and right channel independently 
anymore. If I move the slider for one channel, the other follows more or 
less. I get a maximum volume difference of 4 (on the range 0..100) 
between left and right SPDIF input channel. Changing the levels 
independently and SPDIF input worked before patching.
I reinstalled the unpatched rc6 driver but even restarting alsa didn't 
make SPDIF input working again (I also deleted my /etc/asound.state 
because the mixer controls have changed). Finally, I found out that I 
had to switch off my PC for several seconds and restart with the 
unpatched rc6 driver. The patched driver changes the state of the 
soundcard in some way that even reinstalling the unpatched one doesn't 
help without cold booting. Does SPDIF input work for other cs46xx based 
cards after applying the mentioned patch? What errors does this patch 
fix? Do I need it?

Anyway, great to have pcm output without phase reversals. Thanks again!
fe


Benny Sjostrand schrieb:

>>
>>
>> it seems that volumes 0-0x7fff ramp up volumes, then 8000-ffff go 
>> back down... but with opposite phases. So...
>>
>>  
>>
> Great discovery!, probably the stream can be inverted several times 
> when it processedthrough
> through the SCB tree. (PCMReader->SrcTaskSCB->MasterMixSCB->CodecOut)
> Almost all SCB's got a volume field.
>
>> and it sounds correct (for CD analog passthru and PCM at least).
>> (note - you'll need to open alsamixer and adjust the DAC volume 
>> before the 'fix' works, I haven't found where it gets programmed on 
>> driver load.
>>  
>>
> I guess that the only thing left is to change the initial volume 
> values set when driver is loaded
> in dsp_spos.c line 260:
>    /* maximize volume */
>     ins->dac_volume_right = 0x8000;
> -    ins->dac_volume_left = 0x8000;
> +   ins->dac_volume_left = 0x7fff;
>     ins->spdif_input_volume_right = 0x8000;
> -    ins->spdif_input_volume_left = 0x8000;
> +   ins->spdif_input_volume_left = 0x7fff;
>
>> Now, I have no idea if this is correct, if I just broke SPDIF (no 
>> reciever), rear speakers (ditto, I don't have any) but it fixes my 
>> case anyway, so that's a start. If anyone can test more of these 
>> cases, that might be good.
>>
>>  
>>
> If it works and solves a problem then it must correct -:)
>
>
> /Benny






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
