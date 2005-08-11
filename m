From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Thu, 11 Aug 2005 13:21:56 -0600
Message-ID: <42FBA554.3040604@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com>	<20050807192732.GA3079@procyon.home>	<42F78569.5070604@redfish-solutions.com>	<s5hmzns1iud.wl%tiwai@suse.de>	<42F8F69D.2050302@redfish-solutions.com> <s5hpssk69ge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpssk69ge.wl%tiwai@suse.de>
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

>At Tue, 09 Aug 2005 12:31:57 -0600,
>Philip Prindeville wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    
>>
>>>At Mon, 08 Aug 2005 10:16:41 -0600,
>>>Philip Prindeville wrote:
>>> 
>>>
>>>      
>>>
>>>>Sergey Vlasov wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>On Sun, Aug 07, 2005 at 12:41:38PM -0600, Philip Prindeville wrote:
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>Can we please commit this minor fixes to the tree?  I've been
>>>>>>using them and they seem to work fine.
>>>>>>
>>>>>>Thanks,
>>>>>>
>>>>>>-Philip
>>>>>>
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>*** alsa-kernel/pci/via82xx.c.bak	2005-05-27 04:10:18.000000000 -0600
>>>>>>--- alsa-kernel/pci/via82xx.c	2005-07-25 20:33:51.000000000 -0600
>>>>>>***************
>>>>>>*** 2174,2179 ****
>>>>>>--- 2174,2180 ----
>>>>>>		{ .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
>>>>>>		{ .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */
>>>>>>		{ .vendor = 0x1462, .device = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */
>>>>>>+ 		{ .vendor = 0x1462, .device = 0x7142, .action = VIA_DXS_ENABLE }, /* MSI K8MM-V */
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>Did you try VIA_DXS_SRC instead?  If it works, it gives more
>>>>>capabilities (any sample rate - not discrete values, and separate
>>>>>sample rates for all 4 DXS channels).
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Ok.  I've built a new image that has that set (I've also added an entry
>>>>for the K8MM-ILSR which is an identical motherboard but missing
>>>>video).
>>>>
>>>>How do I add the separate sample rates for the 4 DXS channels, and
>>>>how do I test all of this?
>>>>   
>>>>
>>>>        
>>>>
>>>The best would be to prepare WAV files in different sapmle rates by
>>>converting with sox.
>>>
>>>I believe we can merge NO_VRA and SRC.  We've made them differently
>>>just to be conservative.
>>>
>>>
>>>Takashi
>>> 
>>>
>>>      
>>>
>>Well, I'm a little stumped...  If I use "soundcard detection" on the 
>>"lineout" jack,
>>I can hear audio, but not on the SPDIF port.
>>    
>>
>
>Hmm, this sounds like an off-topic?  Does DXS_SRC work on your device?
>  
>

I tried:

aplay -v -D spdif /usr/share/system-config-soundcard/sound-sample.wav

and that worked ok (I got PCM sound out), but it was at 48kHz.  So I
tried with -D plug:spdif, and that was at the correct pitch...  But I'm
confused.  If I'm setting:

.action = VIA_DXS_SRC

and:

ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_CONTINUOUS;

shouldn't it be able to playback digitally at arbitrary rates?  What do 
I need
to change to get it to playback at 44100Hz for testing?


>  
>
>> However, when I use mplayer to
>>play DVD's with:
>>
>>-ao alsa:device=hw=0.1 -ac hwdts,hwac3,a52,pcm
>>
>>then I get digital sound out the SPDIF just fine.
>>    
>>
>
>Don't do that.  The direct access to "hw" is not recommended at all
>unless you know exactly what you're doing.
>Use rather "spdif" PCM (aka "iec958").
>
>
>Takashi
>  
>


Ok, I'll change this.  But what would the .asoundrc look like to default
everything through "spdif"?

Thanks,

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
