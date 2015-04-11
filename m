From: Nilhcraiv <nilhcraiv@gmail.com>
Subject: Re: Playback - Overwrite buffer with silence
Date: Sun, 12 Apr 2015 01:15:24 +0200
Message-ID: <14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
References: <5529421B.7050601@gmail.com>
 <55297E6E.20302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EAFE526043A
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 01:15:28 +0200 (CEST)
Received: by wgsk9 with SMTP id k9so48068327wgs.3
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 16:15:28 -0700 (PDT)
In-Reply-To: <14caab5d6d0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Clemens,

Fisrt of all thanks for your answer.

In my code there are error checking, of course. The code of this email 
thread is only just to simplify the question.

Clemens wrote:
It is impossible for the boundar to be zero.


I am sure, if you compile this code, "boundary" variable is always zero.
But the question is, How I can put silence data in buffer if the received 
data is not available at time? (to avoid under-run) Is the doc wrong?


#define FRAMES 240
#define PERIOD 1*FRAMES
#define BUFFER_SIZE PERIOD*2
#define CHANNELS 1
#define SAMPLE_RATE 48000

snd_pcm_hw_params_t *hwparams;
snd_pcm_sw_params_t *swparams;
int exact_rate,dir;
snd_pcm_uframes_t boundary=0;

snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;
snd_pcm_hw_params_alloca(&hwparams);
snd_pcm_sw_params_alloca(&swparams);


/*PlayBack hw */
snd_pcm_open(&pcm_handle, "default", stream, 0);
snd_pcm_hw_params_any(pcm_handle, hwparams);
snd_pcm_hw_params_set_access(pcm_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
snd_pcm_hw_params_set_format(pcm_handle, hwparams,
SND_PCM_FORMAT_S16_LE);
exact_rate = SAMPLE_RATE;
snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, &exact_rate, 0);
snd_pcm_hw_params_set_channels(pcm_handle, hwparams, CHANNELS);
snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams, BUFFER_SIZE);
snd_pcm_hw_params(pcm_handle, hwparams);

/*Avoid under-run sw*/
snd_pcm_sw_params_current(pcm_handle, swparams);
snd_pcm_sw_params_get_boundary(swparams, &boundary); /*Here,
boundary is allways ZERO*/
snd_pcm_sw_params_set_silence_threshold(pcm_handle, swparams, 0);
/*According to the doc.*/
snd_pcm_sw_params_set_silence_size(pcm_handle, swparams, boundary);
/*According to the doc.*/
snd_pcm_sw_params(pcm_handle,swparams);
/*END Avoid under-run*/

snd_pcm_prepare(pcm_handle);


Thanks!




Nilhcraiv wrote:
> If I obtain the boundary for ring pointers in frames at the start 
> (snd_pcm_sw_params_get_boundary), the boundary is always zero.

It is impossible for the boundar to be zero.

> Here you can see a light version of my code (without error checking):

Error checking would be important.


Regards,
Clemens
