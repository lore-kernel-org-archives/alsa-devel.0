From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Problem with aloop
Date: Fri, 09 May 2008 09:56:09 -0300
Message-ID: <482449E9.3000405@tet.com.br>
References: <d5eabee70805090546t5219e9e3v63df15b5d64fd7dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tet.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E0422443D
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:56:14 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id F03661204C6
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 09:56:12 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id E117D12000E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 09:56:09 -0300 (BRST)
In-Reply-To: <d5eabee70805090546t5219e9e3v63df15b5d64fd7dd@mail.gmail.com>
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

Benjamin van den Hout escreveu:
> Gustavo da Silva Serra wrote:
>
>   
>>    I am developing an application that captures sound and send it
>> through a network, just like a sound server. To test it I am using
>> kaffeine with alsa output plugin. After some time playing continuously,
>> or if I keep moving the position slider backward and forward, I get
>> choppy sound. If I close and reopen the capture stream opened by my
>> sound server, the sound is restored to good quality. Sometimes I have to
>> reopen many times before I get a good sound. When I use kaffeine oss
>> output plugin I don't have this issue. I don't have an audio sound card,
>> so I don't know if this is an *aloop* issue.
>>     
>
>   
>> Here are some details:
>> - RedHat EL 4 kernel 2.6.9.55-ELsmp 64bit
>> - Alsa 1.0.16
>> - Xinelib 1.1.12
>>     
>
> Hi all,
>
> I'm experiencing the same problem as Gustavo. In my case I have a SIP
> client calling to another PC and I'm injecting audio with aplay (or
> amarok, no difference there) into that SIP call. About 8/10 times
> everything goes well, the other two times the audio that comes out at
> the other PC sounds really choppy. Both PC's are on the same local
> network so that is probably not the problem.
>
> What I found out is that if I patch aloop-kernel.c in the 'static
> struct snd_pcm_hardware snd_card_loopback_info' to have ".formats =
>  (SNDRV_PCM_FMTBIT_S8 )," this problem goes away. But then I'm stuck
> with 8 bit audio. It sounds a bit like the aloop device sometimes
> doesn't properly synchronise the 16 bit (or 32bit, tried that as well)
> samples on both PCM devices and things get mis-aligned. I'm quite new
> to ALSA so please don't laugh too hard if I'm missing something here
> :)
>
> Any input is greatly appreciated!
>
> Kind regards,
> Benjamin van den Hout
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3088 (20080509) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>   

Well, I discovered that only xinelib has this problem. Xmms and 
alsaplayer, for example, don't have this issue. I am testing VLC and it 
seems to work fine. I am not surprised, since the xine source code that 
deals with alsa is huge and ugly, it must be very hard to mantain that.
