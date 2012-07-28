From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Create a stereo sound with alsa
Date: Sat, 28 Jul 2012 11:36:08 +0200
Message-ID: <5013B288.7030304@ladisch.de>
References: <CAAiKgkvXysxM4q5kharx+BNS66_bQKAToByws46f53U0SoF59g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7B2E5265020
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2012 11:36:51 +0200 (CEST)
In-Reply-To: <CAAiKgkvXysxM4q5kharx+BNS66_bQKAToByws46f53U0SoF59g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luca Longhi <lucavermei@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Luca Longhi wrote:
> Hi. I've written a code to play two different sine wave (same amplitude and
> f1=440Hz f2=600Hz) one on the left channel and the other on the right
> channel. It seems to be working. I've tried doing the same thing using two
> different sounds file (stereo) but the result is wrong.

>   err=snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);	//16bit per campione=2byte per campione
>     ...
>     char * buffer1;
>     char * buffer2;
>     char * risultato;
>     ...
> 		{v1=buffer1[j1];}
> 		{v2=buffer2[j2];}
> 		risultato[i++]=v1;
> 		risultato[i++]=v2;

The device expects 16-bit samples, but you write 8-bit values.


Regards,
Clemens
