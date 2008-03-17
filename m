From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: query about snd_pcm_hw_refine
Date: Mon, 17 Mar 2008 15:15:55 -0700
Message-ID: <61445c750803171515n38748127l6becaca008f46bb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by alsa0.perex.cz (Postfix) with ESMTP id A76D91038A2
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 23:15:58 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j40so3206222rnf.12
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 15:15:57 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I get following error when trying to run  aplay with my plugin:

#aplay -D myplug test.wav

Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, St
ereo
aplay: set_params:882: Broken configuration for this PCM: no configurations
available.

After looking at the code, I figured out that its snd_pcm_hw_refine which is
causing problem.
It looks like following in pcm_params.c in alsa lib 1.0.13,


int snd_pcm_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
    int res;

#ifdef REFINE_DEBUG
    snd_output_t *log;
    snd_output_stdio_attach(&log, stderr, 0);

#endif
    printf("#####%s \n", __FUNCTION__);
    assert(pcm && params);
#ifdef REFINE_DEBUG
    snd_output_printf(log, "REFINE called:\n");
    snd_pcm_hw_params_dump(params, log);
#endif
    printf("#####%s calling hw_refine\n", __FUNCTION__);
    res = pcm->ops->hw_refine(pcm->op_arg, params);
    printf("#####% return val of hw_refine = %d\n", res);
#ifdef REFINE_DEBUG
    snd_output_printf(log, "refine done - result = %i\n", res);
    snd_pcm_hw_params_dump(params, log);
    snd_output_close(log);
#endif
    return res;
}

I have modified the alsa.conf for my plugin by adding following in it at the
end,

pcm.myplug {
        type myplug
        card 0
}

What could be the problem?
-pharaoh.
