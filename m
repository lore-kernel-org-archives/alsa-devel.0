From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - alsa-lib 1/1] Patch for two bugs in
 snd_pcm_area_silence().
Date: Thu, 1 Feb 2018 14:59:13 +0900
Message-ID: <a0c95ff7-6f9f-14df-a588-5a8aeaf20756@sakamocchi.jp>
References: <1516505223-16067-1-git-send-email-alsa2@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516505223-16067-1-git-send-email-alsa2@bushytails.net>
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
To: alsa2@bushytails.net, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi furrywolf and Iwa-san,

To review this patch, I wrote a program to test two functions
(snd_pcm_areas_silence() and snd_pcm_area_silence()) in alsa-lib.
https://github.com/takaswie/practices/blob/topic/alsa-lib-test/alsa-lib/test-silence.c

After reviewing, I concluded that this patch is preferable to fix the
addressed bugs. However, this patch is not enough yet and we have rest
of the bugs.

To maintainers, would you please apply this patch to master of alsa-lib
repository?

On Jan 21 2018 12:27, alsa2@bushytails.net wrote:
> From: furrywolf <alsa2@bushytails.net>
> 
> First, after silencing the buffer 64 bits at a time, any remaining samples
> need to be silenced by the following width-specific code.  However, instead
> of silencing the end of the buffer, the code instead re-silences the start
> of the buffer, leaving the end unsilenced.  To fix this, update the pointer
> used by the width-specific code to point to the end of the area just
> silenced, instead of leaving it pointing to the start of the buffer.
> 
> Second, the code for 24 bit samples can only silence a single sample, as
> there's no loop for multiple samples as with other formats.  To fix this,
> add a loop similar to the ones used for every other width.
> 
> The symptoms of these bugs are random data at the end of every supposedly
> silenced buffer with certain format/buffer size combinations, resulting in
> pops and noise.
> 
> Signed-off-by: furrywolf <alsa2@bushytails.net>
> 
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 69d7d66..1753cda 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -2955,6 +2955,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
>   			*dstp++ = silence;
>   		if (samples == 0)
>   			return 0;
> +		dst = (char *)dstp;
>   	}
>   	dst_step = dst_area->step / 8;
>   	switch (width) {

This fixes a bug of 'snd_pcm_area_silence()' in several cases. In this
bug, the caller gets PCM buffers with silent samples up to the number of
frames according to parameters on given 'dst_areas', 'dst_offset',
'channels' and 'format'. In most cases, quite less number of silent
samples are written than given 'frames'.

After applying this change, in this point, the program passed all tests.

> @@ -2996,16 +2997,20 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
>   		}
>   		break;
>   	}
> -	case 24:
> +	case 24: {
> +		while (samples-- > 0) {
>   #ifdef SNDRV_LITTLE_ENDIAN
> -		*(dst + 0) = silence >> 0;
> -		*(dst + 1) = silence >> 8;
> -		*(dst + 2) = silence >> 16;
> +			*(dst + 0) = silence >> 0;
> +			*(dst + 1) = silence >> 8;
> +			*(dst + 2) = silence >> 16;
>   #else
> -		*(dst + 2) = silence >> 0;
> -		*(dst + 1) = silence >> 8;
> -		*(dst + 0) = silence >> 16;
> +			*(dst + 2) = silence >> 0;
> +			*(dst + 1) = silence >> 8;
> +			*(dst + 0) = silence >> 16;
>   #endif
> +			dst += dst_step;
> +		}
> +	}
>   		break;
>   	case 32: {
>   		uint32_t sil = silence;

Before applying this patch, the test program fails for below 24 bit 
sample formats:
  * S24_3LE
  * S24_3BE
  * U24_3LE
  * U24_3BE
  * S20_3LE
  * S20_3BE
  * U20_3LE
  * U20_3BE
  * S18_3LE
  * S18_3BE
  * U18_3LE
  * U18_3BE

After applying this change, calls of the library API for any 'signed'
format of the above formats are successes at the test, however, any
'unsigned' formats aren't. Your change is preferrable but not enough to
fix this bug, unfortunately...

Anyway, I appreciate your attempt to fix this library API. I'll do
further investigation to break down relevant bugs of this library API,
then I'm going to fix it, perhaps work for refactoring with my test
program.


Regards

Takashi Sakamoto
