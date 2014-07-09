From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: Provide a CLOCK_MONOTONIC_RAW
 timestamp type
Date: Wed, 09 Jul 2014 21:40:02 +0200
Message-ID: <53BD9A92.6090806@ladisch.de>
References: <1404831152-8064-1-git-send-email-broonie@kernel.org>
 <s5h7g3modn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C954426510C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 21:40:52 +0200 (CEST)
In-Reply-To: <s5h7g3modn8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Currently, the timestamp mode is set implicitly in alsa-lib pcm_hw.c:
> - When kernel PCM protocol version is high enough, alsa-lib hw prefers
>   the monotonic always (if available), then set pcm->monotonic = 1.
> - Application can ask whether the current timestamp is monotonic or
>   not via snd_pcm_hw_params_is_monotonic().
> So, only adding the flag above doesn't suffice.  If we need to add a
> new mode, the API has to be extended as well.
>
> But how?  The current API assumes that the monotonic mode was already
> determined before hw_params.  We may add a set of new hw_params get
> and set calls for tstamp mode while keeping the old API.  This would
> be one option.  Another option would be to add a new PCM open flag
> SND_PCM_TSTAMP_MONOTONIC_RAW, and snd_pcm_hw_params_is_monotonic_raw()
> function.  The latter is easier (a simpler addition), while the former
> is more extensible to newer formats in future.

These timestamps cannot be handled by hardware drivers; they are always
read by the ALSA framework, in software.  Furthermore, switching between
MONOTONIC and MONOTONIC_RAW is possible at any time.  Therefore, the
timestamp mode should be made a part of sw_params; just add a field
named tstamp_mode ...


Regards,
Clemens
