From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Fri, 12 Aug 2005 09:18:22 -0600
Message-ID: <42FCBDBE.3000106@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com>	<20050807192732.GA3079@procyon.home>	<42F78569.5070604@redfish-solutions.com>	<s5hmzns1iud.wl%tiwai@suse.de>	<42F8F69D.2050302@redfish-solutions.com>	<s5hpssk69ge.wl%tiwai@suse.de>	<42FBA554.3040604@redfish-solutions.com> <s5h1x4z5ic1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x4z5ic1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 11 Aug 2005 13:21:56 -0600,
>Philip Prindeville wrote:
>  
>
>>I tried:
>>
>>aplay -v -D spdif /usr/share/system-config-soundcard/sound-sample.wav
>>
>>and that worked ok (I got PCM sound out), but it was at 48kHz.
>>    
>>
>
>Check /proc/asound/card0/pcm0p/sub3/hw_info whether it's really 48k.
>  
>

Yup:

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 4096
buffer_size: 16384
tick_time: 1000


though I still don't understand why it would be that device and not 
pcm1p/sub0/
instead...

>  
>
>>  So I
>>tried with -D plug:spdif, and that was at the correct pitch...  But I'm
>>confused.  If I'm setting:
>>
>>.action = VIA_DXS_SRC
>>
>>and:
>>
>>ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_CONTINUOUS;
>>
>>shouldn't it be able to playback digitally at arbitrary rates?
>>    
>>
>
>No.  SPDIF cannot play arbitrary rates.
>  
>

But it can play 44100, right?


>>What do  I need
>>to change to get it to playback at 44100Hz for testing?
>>    
>>
>
>It shoud work as it is.  Otherwise it's a bug.
>
>
>Takashi
>  
>

I don't understand why it's device 0, subdevice 3.... instead of being
device 1, subdevice 0.

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
