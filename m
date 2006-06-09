From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: 2.6.17-rc6 sound drivers have section
	mismatch	errors
Date: Fri, 09 Jun 2006 15:08:42 +0100
Message-ID: <448980EA.90208@onelan.co.uk>
References: <44895FE5.6040900@onelan.co.uk>	<s5hirnaechx.wl%tiwai@suse.de>
	<s5h4pyueb00.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4pyueb00.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 09 Jun 2006 14:31:54 +0200,
> I wrote:
>   
>> At Fri, 09 Jun 2006 12:47:49 +0100,
>> Barry Scott wrote:
>>     
>>> I'm trying to build 2.6.17 as suggested on the user list to get Intel 
>>> HDA working.
>>> But, as reported by me on Linux Dev list, there a lot of problems with 
>>> section mismatch
>>> in a number of drivers including the sound drivers. Here are the sound 
>>> related messages:
>>>
>>> WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to 
>>> .init.text:snd_emu8000_new from .text between 'snd_sb16_probe' (at 
>>> offset 0x440) and 'snd_sb16_nonpnp_remove'
>>> WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
>>> .init.text: from .text between 'snd_opl3sa2_pnp_cdetect' (at offset 
>>> 0xe61) and 'snd_opl3sa2_pnp_detect'
>>> WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
>>> .init.text: from .text between 'snd_opl3sa2_pnp_detect' (at offset 
>>> 0xf52) and 'snd_opl3sa2_put_single'
>>>
>>> The Linux Dev folks are looking for someone to look at these problems.
>>>       
>> The patch below should fix.
>>     
>
> Looks like it wasn't enough.  The fixed patch is below.
>
>
> Takashi
>   

Thanks I'm building now with your patch and one for megaraid.
I'll report back once that all completes in a couple of hours.

Barry
