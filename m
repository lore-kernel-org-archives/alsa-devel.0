From: noman pouigt <variksla@gmail.com>
Subject: Re: Buffer size calculation based on period size
Date: Fri, 4 May 2018 13:56:12 -0700
Message-ID: <CAES_P+_0BFY870-rOW97HRWtW7oa9BeEGNg_T98JiZ5yfTbH_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A02266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 22:56:15 +0200 (CEST)
Received: by mail-pf0-f182.google.com with SMTP id v63so18321022pfk.8
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 13:56:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>noman pouigt wrote:
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

>>param_set_min(&params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, config->period_size);

>>So it uses either the supplied value, or if that is too small, the
smallest allowed value.

Probably I was not clear; Why ALSA picked period_size
of 2042 bytes when the minimum period bytes specified
is 4084?

Reason for this question is probably my wrong understanding.
AFAIK:
period_bytes_min specified in hw_params means the minimum
bytes after which audio driver can expect an interrupt.
So, total buffer size should be multiple of period_bytes_min
or multiple of user provided period size if it is greater than
period_bytes_min.

So, if the above understanding is right then buffer size
should have been 4084*2 (number of periods asked by user).

Ultimately the question is how period size is calculated given
min_period_bytes, max_period_bytes, buffer_bytes_max from
pcm_hardware and user supplied period size and period count?

I tried looking into the code but looks like there is lot of macro
magic going on in pcm native layer.

> cat sub0/hw_params
>
> access: RW_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 1
> rate: 16000 (16000/1)
> period_size: 2042
> buffer_size: 4084

>>The actual values of period_size and period_count are returned by
>>pcm_open().
