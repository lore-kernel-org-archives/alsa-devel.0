From: Howard Abrams <abramsh@acm.org>
Subject: Re: This changes in MINIMAL FULL DUPLEX  is not enought!
Date: Sat, 30 Mar 2002 21:36:44 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CA6A06C.2010000@acm.org>
References: <5cdd1dce41e23a9a973146fe99fd5df5@www1.mail.volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Exactly.

These changes were only enough to get the example to compile,
it still doesn't work for me either.

Does ANYONE have a working example of a FULL DUPLEX alsa program?

h.

pavelni@volny.cz wrote:

> These changes in MINIMAL FULL DUPLEX AP is not enought!
> I did this changes before, but was not able to get loop
> from input to output, althought I have programed the same application
> with using OSS before. So I little experiment to solve the problem.  
>   I set length of buffer at 44100 and tryed what happend. First it
> recorded first buffer length. Then it  played the same length. And
> that is all. Then no sound recorded and no sound played. Is it
> somebody able to solve this problem to get final version of MINIMAL
> FULL DUPLEX?                                 Thanks
>                                      Pavel
> 12c10
> < if ((snd_pcm_open ( &playback_handle, argv[1],
> SND_PCM_STREAM_PLAYBACK, 0)) < 0) { ---
> 
>>if ((playback_handle = snd_pcm_open (argv[1],
>>
> SND_PCM_STREAM_PLAYBACK, 0)) < 0) { 17c15
> < if ((snd_pcm_open ( &capture_handle, argv[1],
> SND_PCM_STREAM_CAPTURE, 0)) < 0) { ---
> 
>>if ((capture_handle = snd_pcm_open (argv[1],
>>
> SND_PCM_STREAM_CAPTURE, 0)) < 0) { 27c25
> < snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100,
> 0); ---
> 
>>snd_pcm_hw_params_set_rate_near (playback_handle, hw_params,
>>
> 44100); 35c33
> < snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, 44100,
> 0); ---
> 
>>snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, 44100);
>>
> 45,46c43,44
> < snd_pcm_writei (playback_handle, pbuf, sizeof (pbuf));
> < snd_pcm_readi (capture_handle, cbuf, sizeof (cbuf));
> ---
> 
>>snd_pcm_write (playback_handle, pbuf, sizeof (pbuf));
>>snd_pcm_read (capture_handle, cbuf, sizeof (cbuf));
>>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
