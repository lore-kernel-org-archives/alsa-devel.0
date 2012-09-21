From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Infinite loop in snd_pcm_hw_htimestamp() for capture
	PCMs?
Date: Fri, 21 Sep 2012 10:53:43 -0500
Message-ID: <20120921155343.GH4615@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n+lFg1Zro7sl44OB"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AC55265D7C
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 17:53:46 +0200 (CEST)
Received: from foghorn.codeweavers.com ([216.251.189.130])
 by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.72) (envelope-from <aeikum@codeweavers.com>)
 id 1TF5Y0-0003FT-Eq
 for alsa-devel@alsa-project.org; Fri, 21 Sep 2012 10:53:44 -0500
Content-Disposition: inline
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


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi folks,

I've found some unexpected behavior in alsa-lib. The attached program
uses 100% CPU in an infinite loop, when I'd expect it to return either
an error or a valid htimestamp. I believe the loop occurs in
<src/pcm/pcm_hw.c:snd_pcm_hw_htimestamp()>. Am I not supposed to call
htimestamp() on this type of PCM? Is the PCM still in an invalid state
when htimestamp() is called?

Card: HDA ATI SB
Chip: Realtek ALC889

Happy for any insight.
Andrew

--n+lFg1Zro7sl44OB
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: inline; filename="capture_inf_loop.c"

/* Causes an infinite loop in alsa-lib's snd_pcm_hw_htimestamp() in the
 * capture direction
 *
 * Build with:
 * $ gcc -o test -Wall capture_inf_loop.c -lasound
 */

#include <alsa/asoundlib.h>

int main(int argc, char **argv)
{
    snd_pcm_t *pcm;
    snd_pcm_uframes_t avail;
    snd_pcm_hw_params_t *hw_params;
    int err;
    struct timespec ts;
    unsigned int rate = 44100;

    err = snd_pcm_open(&pcm, "default", SND_PCM_STREAM_CAPTURE,
            SND_PCM_NONBLOCK);
    if(err < 0){
        fprintf(stderr, "snd_pcm_open: %s\n", snd_strerror(err));
        return 1;
    }

    snd_pcm_hw_params_malloc(&hw_params);

    err = snd_pcm_hw_params_any(pcm, hw_params);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params_any: %s\n", snd_strerror(err));
        return 1;
    }

    err = snd_pcm_hw_params_set_access(pcm, hw_params,
            SND_PCM_ACCESS_RW_INTERLEAVED);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_access: %s\n",
                snd_strerror(err));
        return 1;
    }

    err = snd_pcm_hw_params_set_format(pcm, hw_params,
            SND_PCM_FORMAT_S16_LE);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_access: %s\n",
                snd_strerror(err));
        return 1;
    }

    err = snd_pcm_hw_params_set_rate_near(pcm, hw_params, &rate, NULL);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_rate_near: %s\n",
                snd_strerror(err));
        return 1;
    }

    err = snd_pcm_hw_params_set_channels(pcm, hw_params, 2);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_rate_near: %s\n",
                snd_strerror(err));
        return 1;
    }

    err = snd_pcm_hw_params(pcm, hw_params);
    if(err < 0){
        fprintf(stderr, "snd_pcm_hw_params: %s\n", snd_strerror(err));
        return 1;
    }

    fprintf(stderr, "avail_update\n");
    snd_pcm_avail_update(pcm);

    fprintf(stderr, "entering htimestamp...\n");
    snd_pcm_htimestamp(pcm, &avail, &ts);
    fprintf(stderr, "done with htimestamp\n");

    snd_pcm_close(pcm);

    return 0;
}

--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--n+lFg1Zro7sl44OB--
