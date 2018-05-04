From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer size calculation based on period size
Date: Fri, 4 May 2018 14:57:27 +0200
Message-ID: <ab44972e-eec2-ab80-7dd0-acf1029eca7a@ladisch.de>
References: <CAES_P+_d1Di+P_cs3PU6Kqw=6i1WCNf00SB=KXgzVvei4_zmLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id F1904267235
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 14:56:41 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id CD766558374E
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 14:56:40 +0200 (CEST)
In-Reply-To: <CAES_P+_d1Di+P_cs3PU6Kqw=6i1WCNf00SB=KXgzVvei4_zmLA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

noman pouigt wrote:
> I am using tinycap to capture the audio and
> setting below settings:
> bitwidth =  16
> rate =  16000
> channel =  1
> period_size =  320
> period_count = 2
>
> I am wondering how is below
> period_size and buffer_size calculated?
>
> Shouldn't period_size of 320 bytes and
> period_count of 2 fail?

>From the tinyalsa source code:

    param_set_min(&params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, config->period_size);

So it uses either the supplied value, or if that is too small, the
smallest allowed value.

> cat sub0/hw_params
>
> access: RW_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 1
> rate: 16000 (16000/1)
> period_size: 2042
> buffer_size: 4084

The actual values of period_size and period_count are returned by
pcm_open().


Regards,
Clemens
