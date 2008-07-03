From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Application hangs with different period sizes
Date: Thu, 03 Jul 2008 08:41:29 -0300
Message-ID: <486CBAE9.60203@tet.com.br>
References: <2ee9e08d0807030019i1442729cyd241d72074791077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id A74B1248CF
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 13:41:34 +0200 (CEST)
In-Reply-To: <2ee9e08d0807030019i1442729cyd241d72074791077@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: anuj aggarwal <anuj.aggarwal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Do you check the result of the function that sets the period size? Some 
periods are not supported and you can't assume that they are valid and 
proceed in your application. Use snd_pcm_hw_params_set_period_time_near 
to see what is the nearest possible value for period. 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#gf5e53bcb748185a4da3b8538720a5792>

anuj aggarwal escreveu:
> My audio driver supports buffer sizes from 128 to 32768 and period sizes
> from 8 to 2048. I am trying to set the period size as 1030 (just a random
> number between 8 & 2048, but not multiple of 2^n) and buffer size as
> 16*buffer_size (i.e. 16480). The output is as follows:
>
> Buffer size range from 128 to 32768
> Period size range from 8 to 2048
> Request period size 1030 and got 1030
> Plug PCM: Hardware PCM card 0 'TWL4030' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 44100
>   exact rate   : 44100 (44100/1)
>   msbits       : 16
>   buffer_size  : 16480
>   period_size  : 1030
>   period_time  : 23356
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 1030
>   start_threshold  : 16480
>   stop_threshold   : 16480
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1080033280
>
> The problem with this setup is the application just hangs without playing
> anything. If I use period size as 2048, the app plays the song but clips the
> last part of it. If I use 1024/512, it works fine.
>
> I have tried alsa lib version 1.0.15 & 1.0.16 but the problem persists. Is
> there anything wrong with my app or audio driver?
>
> Please help.
>
> Thanks in advance,
> Anuj Aggarwal
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3238 (20080703) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>
>
>   
