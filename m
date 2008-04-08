From: Cameron Barfield <cbarfield.cd@gmail.com>
Subject: Re: Softvol for Independent Volume Control
Date: Tue, 08 Apr 2008 08:52:50 -0700
Message-ID: <47FB94D2.2080601@gmail.com>
References: <47FA8118.7010001@gmail.com> <47FAA169.30700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by alsa0.perex.cz (Postfix) with ESMTP id C169F2437E
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Apr 2008 17:52:54 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 50so1969117wri.2
	for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2008 08:52:53 -0700 (PDT)
In-Reply-To: <47FAA169.30700@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is it possible that the Softvol plug in only supports S16_LE and S32_LE formats?



Cameron Barfield wrote:
> Well, I think I am actually on the right track.
> 
> I'm using a Blackfin BF537 with an AD1980BL (AC97) codec. All seems well 
> with it. I'm running it with MMAP and DMIX appears to work beautifully.
> 
> I'm trying to add the volume controls to the mixer so that my 
> application can adjust the volumes of its audio streams.
> 
> I've been playing around with /etc/asound.conf and so far I have:
> 
> pcm.mychan1 {
>     type            softvol
>     slave.pcm       "default"
>     control.name    "mychan1"
>     control.card    0
> }
> 
> I can play WAV files (48K) no problem using aplay -D mychan1 file.wav. 
> If I play any wav/au files that need rate conversion, I get:
> 
> aplay: set_params:904: Sample format non available
> 
> If I don't specify a device for aplay, I can play pretty much any wav/au 
> file I have. DMIX also still works.
> 
> If I adjust the volume of my new channel, it does adjust independently 
> of Master,0 and PCM,0
> 
> Am I just grossly misunderstanding how asound.conf works?
> 
> 
> 
> Cameron Barfield wrote:
>> Hi --
>>
>> I've got an application that receives multiple network audio streams. 
>> Using DMIX, I am able to play back all the streams through my sound card.
>>
>> The problem is that I would like to be able to independently adjust 
>> the volume of each audio stream. Would Softvol work for this? All the 
>> examples I've found only show Softvol working as a replacement for a 
>> master volume control (and that's all I've been able to get it to do).
>>
>> If Softvol won't work for independent volume controls, is there any 
>> other ALSA plugin or API call that I'm missing? Switching to something 
>> like Pulseaudio would probably not be an option since I'm running in 
>> an embedded environment.
>>
>> Regards,
>> Cameron
>>
>>
> 
