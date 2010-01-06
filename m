From: Marc Garnier <marc.garnier@heig-vd.ch>
Subject: Re: capturing data from the microphone
Date: Wed, 6 Jan 2010 08:58:10 +0100
Message-ID: <4B444292.5070702@heig-vd.ch>
References: <4B4227BC.70705@gmail.com> <4B4359A5.5060207@heig-vd.ch>
	<4f3252891001051707n7e740ea5gcc217595ee354278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heig-vd.ch (mailcl1.heig-vd.ch [193.134.216.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B36244D6
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 08:58:12 +0100 (CET)
Received: from [10.192.41.20] (helo=eintfe01.einet.ad.eivd.ch)
	by mailcl1.heig-vd.ch stage1 with esmtp (Exim MailCleaner)
	id 1NSQmP-00012b-Kc for <alsa-devel@alsa-project.org>
	from <Marc.Garnier@heig-vd.ch>; Wed, 06 Jan 2010 08:58:09 +0100
In-Reply-To: <4f3252891001051707n7e740ea5gcc217595ee354278@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, let me go into details. I work on a custom device platform based on 
an Atmel at91sam9261. I wrote an alsa driver composed of 2 files 
(sound/soc/atmel/myplateform_q2686.c and sound/soc/codecs/q2686.c) and I 
also add this line into arch/arm/mach-at91/board-myplateform.c :

at91_add_device_ssc(AT91SAM9261_ID_SSC0, ATMEL_SSC_TX | ATMEL_SSC_RX);

When I boot my device I can see that :
Q2686 SoC Audio Codec 0.2
asoc: Q2686 <-> atmel-ssc0 mapping ok
ALSA device list:
  #0: MYPLATFORM (Q2686)

And everything ok with playback :
# aplay -c 1 tone.wav

But when I want to record a pcm stream I have this error:
# arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
arecord: pcm_read:1629: read error: Input/output error

Any more idea?

Raymond Yau wrote:
> which device are you using ?  ( pulseaudio , dmix or default device defined
> in /usr/share/alsa/cards/*.conf )
>
> post output of
>
> arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
>   
> 2010/1/5 Marc Garnier <marc.garnier@heig-vd.ch>
>
>   
>> Hi,
>>
>> I have the same kind of problem. I try to capture PCM stream thanks to
>> areacord :
>> # arecord -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
>>
>> 30 seconds later I have the folowing message :
>> # arecord: pcm_read:1629: read error: Input/output error
>>
>> I can observe the PCM stream on an oscilloscope but no interrupt are
>> catched by the system  (AIC ss0 counter remains at zero ) :
>> # cat /proc/interrupts
>>           CPU0
>>  1:     275059         AIC  at91_tick, rtc0, ttyS0
>>  7:        179         AIC  ttyS2
>>  9:         11         AIC  mmc0
>>  13:          0         AIC  atmel_spi.1
>>  14:          0         AIC  ssc0
>>  82:          1        GPIO  alerte
>> 107:       9464        GPIO  eth0
>>
>> Any idea?
>>
>>
>>
>>     
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
