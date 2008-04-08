From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: XRUN happens too often.
Date: Tue, 08 Apr 2008 08:20:55 -0700
Message-ID: <47FB8D57.8030904@cox.net>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id F1E5C24347
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Apr 2008 17:20:57 +0200 (CEST)
In-Reply-To: <loom.20080408T113541-885@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rong-Jhe <r93922118@ntu.edu.tw>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rong-Jhe wrote:
>  
>   
>> A sample in 16-bit, two channels is 4 bytes.
>> I allocate a audio data of 9408x4=37632 bytes.
>>
>> audio_data=malloc(buffer_size*4);
>>
>> This audio_data buffer will receive audio data from the network.
>> If this buffer is full, I use snd_pcm_writei( ) to put the buffer into the 
>>     
> pcm.
>   
>> snd_pcm_sframes_t frames;
>> snd_pcm_t *handle;
>>
>> while((frame=snd_pcm_writei(handle, audio_data, buffer_size))<0)
>> {
>>    if(frames==-EPIPE)
>>       snd_pcm_prepare(handle);
>>    else
>>       printf("snd_pcm_writei error %d\n", frames);
>> }
>>
>> The codes states that I put the entire buffer into the pcm at each time. The 
>> pcm use 10 periods to perform this buffer. The program can work normally.
>>
>> If the sampling rate is changed, the program will encounter XRUN frequently.
>>
>> The follows are the parameters that I read from the pcm after setting 
>>     
> sampling 
>   
>> rate to 48000.
>> sampling rate = 48000 bps
>> period time = 21333 us
>> period size = 1024 frames
>> buffer time = 213330 us
>> buffer size = 10240 frames
>> audio_data=malloc(buffer_size*4); //10240x4=40960
>>
>> I also put the entire buffer into the pcm at each time, but snd_pcm_writei( )
>> will return -PIPE frequently.
>>
>> What is the problem?
>>
>>     
> ----------------------------------------------------------
> I use snd_pcm_avail_update( ) to show the number of frames that can write into 
> the pcm before using snd_pcm_writei( ).
> I found that sometimes snd_pcm_avail_update( ) will return more than buffer 
> size.
> EX. buffer size = 10240, sometimes snd_pcm_avail_update( ) 10274 > 10240.
> Dose this cause XRUN?
> How to improve it ?
>
>   
I don't have a direct answer for you, but I have an application that seems
to be able to write data using writei with no problems at rates up to
192 KHz.  You can download it from sourceforge and look at the source.

http://sourceforge.net/projects/discord/ 

I copied and adapted from other examples on the web.  Do a search for 
alsa in
the source code and it should take you to the initialization function 
and the
playing function.
