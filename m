From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 14/14] ALSA: pcm: Make snd_pcm_suspend()
	local static
Date: Thu, 17 Jan 2019 14:53:44 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527B2CBD@SHSMSX103.ccr.corp.intel.com>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-15-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527B2688@SHSMSX103.ccr.corp.intel.com>
 <s5hr2dbd8zx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E5526680F
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 15:53:50 +0100 (CET)
In-Reply-To: <s5hr2dbd8zx.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>> >diff --git a/include/sound/pcm.h b/include/sound/pcm.h index
>> >04e97564949c..2c30c1ad1b0d 100644
>> >--- a/include/sound/pcm.h
>> >+++ b/include/sound/pcm.h
>> >@@ -582,13 +582,8 @@ int snd_pcm_stop(struct snd_pcm_substream
>> >*substream, snd_pcm_state_t status);  int snd_pcm_drain_done(struct
>> >snd_pcm_substream *substream);  int snd_pcm_stop_xrun(struct
>> >snd_pcm_substream *substream);  #ifdef CONFIG_PM -int
>> >snd_pcm_suspend(struct snd_pcm_substream *substream);  int
>> >snd_pcm_suspend_all(struct snd_pcm *pcm);  #else -static inline int
>> >snd_pcm_suspend(struct snd_pcm_substream *substream) -{
>> >-	return 0;
>> >-}
>> > static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)  {
>> > 	return 0;
>> >diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c index
>> >818dff1de545..26afb6b0889a 100644
>> >--- a/sound/core/pcm_native.c
>> >+++ b/sound/core/pcm_native.c
>> >@@ -1460,29 +1460,24 @@ static const struct action_ops
>> >snd_pcm_action_suspend = {
>> > 	.post_action = snd_pcm_post_suspend  };
>> >
>> >-/**
>> >+/*
>> >  * snd_pcm_suspend - trigger SUSPEND to all linked streams
>> >  * @substream: the PCM substream
>> >  *
>> >  * After this call, all streams are changed to SUSPENDED state.
>> >  *
>> >- * Return: Zero if successful (or @substream is %NULL), or a
>> >negative error
>> >- * code.
>> >+ * Return: Zero if successful, or a negative error code.
>> >  */
>> >-int snd_pcm_suspend(struct snd_pcm_substream *substream)
>> >+static int snd_pcm_suspend(struct snd_pcm_substream *substream)
>>
>> If some drivers may use snd_pcm_suspend() later for corner cases, is
>> it OK to make it be external again?
>
>Yes.  But it means that you're doing something special and often wrong.  We
>can catch such a case more easily by this action :)

You are right. I checked SOF (it use snd_pcm_suspend()) and believe we 
don't have to call snd_pcm_suspend() directly. :-)

Regards,
Libin

>
>
>thanks,
>
>Takashi
