From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: HDMI codec, way forward?
Date: Fri, 16 Oct 2015 15:51:40 +0200
Message-ID: <562100EC.4030701@st.com>
References: <5620E482.6050507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D861A26069D
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 15:51:46 +0200 (CEST)
In-Reply-To: <5620E482.6050507@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, =?UTF-8?B?UnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IOKAjg==?= <linux@arm.linux.org.uk>, "lars@metafoo.de" <lars@metafoo.de>, Jean-Francois Moine <moinejf@free.fr>
List-Id: alsa-devel@alsa-project.org

> After reading the ELCE Audio mini conf minutes [1] I gather that HDMI
> audio was not discussed after all.
>
> My conclusion from the Lars-Peter's latest mail [2] related to the
> subject is that the wind is currently blowing slightly in favour of my
> version of the hdmi codec [3], or at least not in favour of Arnaud's
> version [4].
Based on previous discussions and lack of feedback from DRM community,
This make sens for me.

>
> So how should we proceed? Are we still waiting for some feedback from
> DRM/video side?
>
> There was not too many clear suggestions to my latest patch series
> [3], so I do not see too much point in sending yet another version of
> that series.
  For me, some points need to be clarified:
- Do we need the abort callback. Is there a uses cases that makes it 
mandatory (some timeout mechanism already exists to stop audio...)

- Does trigger is needed when CPU-DAI is master on bus?
Otherwise how to inform HDMI that I2S bus is no more clocked? I'm not
sure that mute is sufficient for all hardwares... For instance for my
hardware CTS parameter is hardware computed based on I2S L/R clock.

- IEC controls to support compress mode. This should be handled by codec 
driver in I2S mode, but not in SPDIF mode.

>
> Arnaud, if I'd try to make a patch series that would implement sti
> HDMI audio with my HDMI codec, would you be willing try that out?
hmm...more simple that i do the stuff for sti platform as some pieces of 
code are missing today in kernel (Device tree part).
I will try to find time next week to make a prototype for test and give 
you a feedback.

Additional point: We should also define some new helper functions:

- For N and CTS HDMI parameters: In my RFC i have proposed helper 
function, don't know if that matches with other platforms need...

- For IEC standard controls (could be added in core/pcm_iec958.c)

BR,
Arnaud
