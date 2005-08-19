From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Unknown PCI id
Date: Fri, 19 Aug 2005 10:42:19 -0600
Message-ID: <43060BEB.501@redfish-solutions.com>
References: <430508A8.6090705@redfish-solutions.com>	<s5hek8qdysr.wl%tiwai@suse.de>	<4306072A.2060807@redfish-solutions.com> <s5hwtmhdgyy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtmhdgyy.wl%tiwai@suse.de>
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

>At Fri, 19 Aug 2005 10:22:02 -0600,
>Philip Prindeville wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    
>>
>>>At Thu, 18 Aug 2005 16:16:08 -0600,
>>>Philip Prindeville wrote:
>>> 
>>>
>>>      
>>>
>>>>New PCI id to add support to for the via82xx:
>>>>
>>>>% lspci -n -v -s 11.5
>>>>00:11.5 Class 0401: 1106:3059 (rev 60)
>>>>   
>>>>
>>>>        
>>>>
>>>It's the standard PCI id.
>>>
>>> 
>>>
>>>      
>>>
>>>>       Subsystem: 1462:0430
>>>>       Flags: medium devsel, IRQ 185
>>>>       I/O ports at ec00 [size=256]
>>>>       Capabilities: [c0] Power Management version 2
>>>>
>>>>This is the AC97 audio hardware (implemented via a VT1617A) on
>>>>the MSI 7142 (K8MM-V) motherboard.
>>>>   
>>>>
>>>>        
>>>>
>>>You mean ssid for dxs_support or ac97_quirk?
>>>Then please specify which values.
>>> 
>>>
>>>      
>>>
>>I couldn't find where the VIA_DXS_* values are documented, or how
>>to tell what differences they make.  If I set VIA_DXS_SRC, for instance,
>>how do I know that it's working?
>>    
>>
>
>See ALSA-Configuration.txt.
>
>  
>
>>Will it default to VIA_DXS_AUTO or VIA_DXS_ENABLE if there is
>>no matching entry?
>>    
>>
>
>It defaults to VIA_DXS_AUTO, which results in VIA_DXS_48K (fixed
>48kHz) from historical reasons.
>  
>

Well, we've already seen that digital playback at 44.1kHz didn't want to
work on this motherboard, because the Codec won't let itself be set to
any other speed besides 48kHz on the SPDIF.

However, when playing with dxs_support=5 and "aplay -D hw:0,0 ..."
it seems to reproduce at 44.1kHz just fine.

Does that answer the question?

-Philip

>
>Takashi
>  
>



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
