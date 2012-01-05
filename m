From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-lib PATCH 2/4] Search-and-replace improve
 documentation language
Date: Thu, 5 Jan 2012 14:43:31 +0800
Message-ID: <CAN8cciYsbbMVgsvb3FDDVOob8C8sLNW5KLxb1sx9BRX0LAkZ+w@mail.gmail.com>
References: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>
	<20120104201137.GD9868@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3EF3624366
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 07:43:32 +0100 (CET)
Received: by werb12 with SMTP id b12so144481wer.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2012 22:43:31 -0800 (PST)
In-Reply-To: <20120104201137.GD9868@foghorn.codeweavers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> /**
>- * \brief Check, if hardware supports pause
>+ * \brief Check if hardware supports pause
> * \param params Configuration space
>- * \return Boolean value
>  * \retval 0 Hardware doesn't support pause
>  * \retval 1 Hardware supports pause
>  *
>- * It is not allowed to call this function when given configuration is not exactly one.
>- * Usually, #snd_pcm_hw_params() function chooses one configuration
>- * from the configuration space.
>+ * This function should only be called when the configuration space
>+ * contains a single configuration. Call #snd_pcm_hw_params to choose
>+ * a single configuration from the configuration space.
>  */
> int snd_pcm_hw_params_can_pause(const snd_pcm_hw_params_t *params)


What is the meaning of the configuration space contains a single configuration ?

since the hardware either support pause or does not support pause

it seem that only need to call snd_pcm_hw_params_any() instead of
snd_pcm_hw_params() before calling snd_pcm_hw_params_can_pause()


err= snd_pcm_open(&pcm, device, stream, SND_PCM_NONBLOCK);

err= snd_pcm_hw_params_any(pcm, pars);

if (snd_pcm_hw_params_can_pause(pars))
      printf("pcm device support pause\n");
