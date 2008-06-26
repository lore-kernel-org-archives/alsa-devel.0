From: Jerry Geis <geisj@pagestation.com>
Subject: Re: seg fault with 1.0.17rc2
Date: Thu, 26 Jun 2008 12:03:24 -0400
Message-ID: <4863BDCC.8010708@pagestation.com>
References: <4863AA01.7080900@pagestation.com> <s5hwskcp4w5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com (unknown [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B3141037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 18:03:27 +0200 (CEST)
In-Reply-To: <s5hwskcp4w5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Thu, 26 Jun 2008 10:38:57 -0400,
> Jerry Geis wrote:
>   
>> #0  0xb7e892ff in memcpy () from /lib/tls/libc.so.6
>> #1  0xb74e40a9 in snd_pcm_area_copy (dst_area=0xb7125b70, dst_offset=0, 
>> src_area=0x81dc1c0, src_offset=170, samples=0, 
>> format=SND_PCM_FORMAT_S16_LE) at pcm.c:2589
>>     
>
> samples = 0 and...
>
>   
>> #2  0xb74e438d in snd_pcm_areas_copy (dst_areas=0xb7125b7c, 
>> dst_offset=0, src_areas=0x81dc1cc, src_offset=170, channels=1, 
>> frames=122, format=SND_PCM_FORMAT_S16_LE) at pcm.c:2736
>>     
>
> ... here frames = 122.  Something inconsistent around here.
> snd_pcm_areas_copy() must passe samples=frames when channels=1.
> Could you check the values via gdb?
>
>
> Takashi
>
>   
Takashi,

I am not sure what your asking me. The output I provided is gdb what else
can I check? Really anxious to get this USB sound device playing 
consistantly.

Is there a better asound.conf to use?
How can I help?

Jerry
