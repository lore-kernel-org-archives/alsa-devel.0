From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 20:23:21 +1100
Message-ID: <20151026202321.cc3f5496a60a9369542d6be6@mega-nerd.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <562D376E.7000308@ladisch.de>
 <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
 <562DEF9C.8090706@ladisch.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 900A3260522
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:23:24 +0100 (CET)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id 50BA3C06BF
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 20:23:21 +1100 (AEDT)
In-Reply-To: <562DEF9C.8090706@ladisch.de>
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

Clemens Ladisch wrote:

> Erik de Castro Lopo wrote:
> >     RATE: [44100 96000]
> 
> snd_pcm_set_params() should have chosen a single rate.
> Did you dump this after that call?

Yep, the code is:

    snd_pcm_format_t format = SND_PCM_FORMAT_S32_LE;
    snd_pcm_hw_params_t *hw_params;
    snd_output_t *output ;
    unsigned int rate = 48000 ;

    if ((err = snd_pcm_set_params (capture_handle, format, SND_PCM_ACCESS_RW_INTERLEAVED, 2, rate, 0, 25000)) < 0) {   /* 0.5sec */
        printf ("Capture open error: %s\n", snd_strerror (err));exit(1);
    }

    if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
        printf ("Cannot allocate hardware parameter structure (%s)\n", snd_strerror (err));exit(1);
    }

    if ((err = snd_pcm_hw_params_any (capture_handle, hw_params)) < 0) {
        printf ("Cannot initialize hardware parameter structure (%s)\n", snd_strerror (err));exit(1);
    }

    snd_output_stdio_attach (&output, stderr, 0) ;
    snd_pcm_hw_params_dump (hw_params, output) ;
    snd_output_close (output) ;

    snd_pcm_hw_params_free (hw_params);


Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
