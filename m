From: Irfan shaikh <irfan.shaikh@sasken.com>
Subject: Re: ALSA Underrun / Silence playback
Date: Mon, 5 Dec 2011 15:34:34 +0530
Message-ID: <4EDC9732.1030108@sasken.com>
References: <4EDC674A.4030302@sasken.com> <4EDC9403.3080708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F00B24471
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 11:07:08 +0100 (CET)
In-Reply-To: <4EDC9403.3080708@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Clemens,

             I have used my threshold as boundary value {after calling  
snd_pcm_sw_params_get_boundary() } also and checked the audio performance.
I was still getting UNDERRUN's (-32).

             if (snd_pcm_sw_params_set_stop_threshold 
(alsaParams->pcm_handle, alsaParams->p_swparams, threshold) < 0)
             {
                     printf("Could not gete 
snd_pcm_sw_params_get_boundary");
                     return NULL;
             }

What's weird about this number?

--> I set my alsa buffer size as (512 period size and 16 periods)
       As snd_pcm_sw_params_get_boundary(), returns boundary in frames.
       I was not able to get how the boundry which i get (1572864000) is 
more than the buffer size (512 X 16) which i have set.

Regards
Irfan


On 12/05/2011 03:20 PM, Clemens Ladisch wrote:
> Irfan shaikh wrote:
>> When i do get boundry, i get some weird value 1572864000.
> What's weird about this number?
>
>> Thus i tried to use alsa buffer size for threshold
> Use the boundary value.
>
>
> Regards,
> Clemens
>
