From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Wed, 16 Nov 2011 15:31:35 -0600
Message-ID: <20111116213135.GJ30602@foghorn.codeweavers.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xaMk4Io5JJdpkLEb"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id BA90C103A02
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 22:31:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC42907.80104@ladisch.de>
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
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Nov 16, 2011 at 10:20:07PM +0100, Clemens Ladisch wrote:
> Andrew Eikum wrote:
> > +++ b/include/pcm.h
> > @@ -44,8 +44,20 @@ extern "C" {
> >
> >  /** PCM generic info container */
> >  typedef struct _snd_pcm_info snd_pcm_info_t;
> > -/** PCM hardware configuration space container */
> > +
> > +/** PCM hardware configuration space container
> > + *
> > + *  snd_pcm_hw_params_t is an opaque structure which contains a set of possible
> > + *  PCM hardware configurations. For example, a given instance might include a
> > + *  range of buffer sizes, a range of period sizes, and a set of several sample
> > + *  formats. Some subset of all possible combinations these sets may be valid,
> > + *  but not necessarily any combination will be valid.
> > + *
> > + *  No validation is done by the various snd_pcm_hw_params_set* functions.
> 
> These functions do validate the value that the application is trying to set
> and adjust all other dependent limits.
> 

I didn't find that to be the case in my testing, at least between
periods, period_size, and buffer_size. I've attached a test program
here. It sets periods to 10, period_size to 1024, and buffer_size_max
to be the same as the return from get_buffer_size_min (in my case,
80). The first call to fail is snd_pcm_hw_params(). If what you said
is true, I would expect the set_buffer_size_max() call to fail.

$ gcc -I /usr/include/alsa -lasound -o alsa_period_count alsa_period_count.c
$ ./alsa_period_count
min_buffer_frames: 80
set max buffer size: 80
snd_pcm_hw_params: -12
$

Andrew

--xaMk4Io5JJdpkLEb
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: inline; filename="alsa_period_count.c"

#include <asoundlib.h>

int main(int argc, char **argv)
{
    snd_pcm_t *pcm;
    snd_pcm_hw_params_t *hw_params;
    snd_pcm_uframes_t buffer_frames, period_frames;
    unsigned int periods, min_periods, max_periods;
    int period_dir, periods_dir, min_periods_dir, max_periods_dir;
    int err;

    err = snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if(err < 0){
        printf("snd_pcm_open: %d\n", err);
        return 1;
    }

    hw_params = malloc(snd_pcm_hw_params_sizeof());
    if(!hw_params){
        perror("malloc");
        return 1;
    }

    err = snd_pcm_hw_params_any(pcm, hw_params);
    if(err < 0){
        printf("snd_pcm_hw_params_current: %d\n", err);
        return 1;
    }

    min_periods = 0xdeadbeef;
    min_periods_dir = 0xdeadbeef;
    err = snd_pcm_hw_params_get_periods_min(hw_params, &min_periods, &min_periods_dir);
    if(err < 0){
        printf("snd_pcm_hw_params_get_periods_min: %d\n", err);
        return 1;
    }

    max_periods = 0xdeadbeef;
    max_periods_dir = 0xdeadbeef;
    err = snd_pcm_hw_params_get_periods_max(hw_params, &max_periods, &max_periods_dir);
    if(err < 0){
        printf("snd_pcm_hw_params_get_periods_max: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_set_periods(pcm, hw_params, 10, 0);
    if(err < 0){
        printf("snd_pcm_hw_params_set_periods: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_set_period_size(pcm, hw_params, 1024, 0);
    if(err < 0){
        printf("snd_pcm_hw_params_set_period_size: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_get_buffer_size_max(hw_params, &buffer_frames);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_get_buffer_size_min(hw_params, &buffer_frames);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }
    printf("min_buffer_frames: %u\n", buffer_frames);

    err = snd_pcm_hw_params_set_buffer_size_max(pcm, hw_params, &buffer_frames);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }
    printf("set max buffer size: %u\n", buffer_frames);

    err = snd_pcm_hw_params(pcm, hw_params);
    if(err < 0){
        printf("snd_pcm_hw_params: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_get_buffer_size(hw_params, &buffer_frames);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }

    err = snd_pcm_hw_params_get_period_size(hw_params, &period_frames, &period_dir);
    if(err < 0){
        printf("snd_pcm_hw_params_get_period_size: %d\n", err);
        return 1;
    }

    periods = 0xdeadbeef;
    periods_dir = 0xdeadbeef;
    err = snd_pcm_hw_params_get_periods(hw_params, &periods, &periods_dir);
    if(err < 0){
        printf("snd_pcm_hw_params_get_periods: %d\n", err);
        return 1;
    }

    printf("min_periods: %u, max_periods: %u, buffer_frames: %lu, period_frames: %lu, buf/per: %f, periods: %u, periods_dir: %d\n",
            min_periods, max_periods, buffer_frames, period_frames, buffer_frames / (double)period_frames,  periods, periods_dir);

    free(hw_params);
    snd_pcm_close(pcm);

    return 0;
}

--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--xaMk4Io5JJdpkLEb--
