From: Carlos Munoz <carlos@kenati.com>
Subject: Re: Fwd: memory allocate for substream->runtime->dma_area
Date: Thu, 16 Mar 2006 16:45:24 -0800
Message-ID: <441A06A4.7030100@kenati.com>
References: <715d90900603141942y6c409027sb5a99be13f5ec462@mail.gmail.com>	 <715d90900603141943h423c0ffdydedec3f1ed50a375@mail.gmail.com>	 <1142394842.24603.77.camel@mindpipe>	 <715d90900603142003jd1b1d00he8daf7331cc72237@mail.gmail.com>	 <1142454177.1671.38.camel@mindpipe>	 <715d90900603151909o6bb834efv401392e5239a0435@mail.gmail.com>	 <715d90900603152107q30b76a85l4b428167d515ee8c@mail.gmail.com> <715d90900603152121t40c2c5ddg4e6bce9df9f6e5a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900603152121t40c2c5ddg4e6bce9df9f6e5a9@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

boku wrote:

>
> Dear all,
>     Could you please tell me what the "frame" and "period" mean in alsa?
> I saw snd_pcm_hardware_t struct has period_min,max, 
> period_bytes_min,max etc but quite confused of their meaning. So is 
> the fifo size.
>     And btw, which data struct has the info of how many bits per 
> channel for the wav bitstream from alsa application aplay etc? Such as 
> 16-bits, 24 or 32-bits.
> Thanks for your great help~
>  
>  
> On 3/16/06, *Lee Revell* <rlrevell@joe-job.com 
> <mailto:rlrevell@joe-job.com> > wrote:
>
>     On Wed, 2006-03-15 at 12:03 +0800, boku wrote:
>> Hi, Lee,
>>      Thanks for quick response. Currently I'm designing the sound
>> driver for an ARM integrator/ap-like platform. But in the platform,
>> the audio controller is designated to move data only from a specific
>> address space. Therefore, doesn't it mean that i need to
>     constrain the
>> runtime->dma_area to the specified address so that the AIC can start
>> to do DMA access?
>> Sorry about the code still not done and thanks in advance.
>
>     Sorry I'm not really an ARM expert, but this has come up in the list
>     archive before.  You should look at some of the other ARM drivers
>     in the
>     tree...
>
>     Lee
>
>
>
Hi Boku,

I'm not an expert but I recently looked into this.

Frame: From the macro  bytes_to_frames() I gather that a frame is a 
sample. For example, if the sample size is 16 bits, the frame is also 16 
bits. That means that for every 2 bytes sent, one frame is sent.

Period: It is driver dependent. It's the dma interrupt interval. It is 
used to calculate latencies. For example, if a driver can only dma 1024 
bytes at a time, the period will be 1024. That means during capture at 
least 1024 bytes will be received before the first byte is passed to the 
alsa middle layer.

I hope this helps,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
