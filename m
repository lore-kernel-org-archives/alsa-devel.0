From: Cameron Barfield <cbarfield.cd@gmail.com>
Subject: Re: Softvol for Independent Volume Control
Date: Fri, 11 Apr 2008 10:39:00 -0700
Message-ID: <47FFA234.2030308@gmail.com>
References: <47FA8118.7010001@gmail.com> <47FAA169.30700@gmail.com>
	<47FB94D2.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.240])
	by alsa0.perex.cz (Postfix) with ESMTP id D9D41244E2
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 19:39:04 +0200 (CEST)
Received: by ag-out-0708.google.com with SMTP id 22so1148788agd.8
	for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2008 10:39:03 -0700 (PDT)
In-Reply-To: <47FB94D2.2080601@gmail.com>
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

I did manage to get it working, but I'm not sure how. If someone could explain how and why 
having two layers of plug-ins makes this work, I'd love to know.

Here's my asound.conf:

     # This would be channel 1

     pcm.channel1 {

         type plug

         slave.pcm "chan_1"

     }


     # Channel 2

     pcm.channel2 {

         type plug

         slave.pcm "chan_2"

     }


     # Channel 3

     pcm.channel3 {

         type plug

         slave.pcm "chan_3"

     }


     # Channel 4

     pcm.channel4 {

         type plug

         slave.pcm "chan_4"

     }


     # Here are the slave plug-ins for the above devices


     pcm.chan_1 {

         type            softvol

         slave.pcm       "dmix"

         control.name    "chan_1"

         control.card    0

     }


     pcm.chan_2 {

         type            softvol

         slave.pcm       "dmix"

         control.name    "chan_2"

         control.card    0

     }


     pcm.chan_3 {

         type            softvol

         slave.pcm       "dmix"

         control.name    "chan_3"

         control.card    0

     }


     pcm.chan_4 {

         type            softvol

         slave.pcm       "dmix"

         control.name    "chan_4"

         control.card    0

     }

root:/etc> aplay -D channel1 440.au
Playing Sparc Audio '440.au' : Mu-Law, Rate 8000 Hz, Mono
Aborted by signal Interrupt...

So it does work. Each channel also gets its own mixer control in amixer so its volume can 
be adjusted independently of PCM and master.



Cameron Barfield wrote:
> Is it possible that the Softvol plug in only supports S16_LE and S32_LE 
> formats?
> 
> 
> 
> Cameron Barfield wrote:
>> Well, I think I am actually on the right track.
>>
>> I'm using a Blackfin BF537 with an AD1980BL (AC97) codec. All seems 
>> well with it. I'm running it with MMAP and DMIX appears to work 
>> beautifully.
>>
>> I'm trying to add the volume controls to the mixer so that my 
>> application can adjust the volumes of its audio streams.
>>
>> I've been playing around with /etc/asound.conf and so far I have:
>>
>> pcm.mychan1 {
>>     type            softvol
>>     slave.pcm       "default"
>>     control.name    "mychan1"
>>     control.card    0
>> }
>>
>> I can play WAV files (48K) no problem using aplay -D mychan1 file.wav. 
>> If I play any wav/au files that need rate conversion, I get:
>>
>> aplay: set_params:904: Sample format non available
>>
>> If I don't specify a device for aplay, I can play pretty much any 
>> wav/au file I have. DMIX also still works.
>>
>> If I adjust the volume of my new channel, it does adjust independently 
>> of Master,0 and PCM,0
>>
>> Am I just grossly misunderstanding how asound.conf works?
>>
>>
>>
>> Cameron Barfield wrote:
>>> Hi --
>>>
>>> I've got an application that receives multiple network audio streams. 
>>> Using DMIX, I am able to play back all the streams through my sound 
>>> card.
>>>
>>> The problem is that I would like to be able to independently adjust 
>>> the volume of each audio stream. Would Softvol work for this? All the 
>>> examples I've found only show Softvol working as a replacement for a 
>>> master volume control (and that's all I've been able to get it to do).
>>>
>>> If Softvol won't work for independent volume controls, is there any 
>>> other ALSA plugin or API call that I'm missing? Switching to 
>>> something like Pulseaudio would probably not be an option since I'm 
>>> running in an embedded environment.
>>>
>>> Regards,
>>> Cameron
>>>
>>>
>>
> 
