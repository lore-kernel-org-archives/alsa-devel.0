From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] ALSA: pcm: implement the anonymous dup
 (inode file descriptor)
Date: Wed, 30 Jan 2019 13:19:47 +0100
Message-ID: <e5718796-736a-2414-a907-eae51dedf061@perex.cz>
References: <20190130084733.979-1-perex@perex.cz>
 <20190130084733.979-2-perex@perex.cz> <s5h4l9qe5qu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D3065267419
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 13:19:53 +0100 (CET)
In-Reply-To: <s5h4l9qe5qu.wl-tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Phil Burk <philburk@google.com>, Leo Yan <leo.yan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org

Dne 30.1.2019 v 12:37 Takashi Iwai napsal(a):
> On Wed, 30 Jan 2019 09:47:32 +0100,
> Jaroslav Kysela wrote:
>>
>> This patch implements new SNDRV_PCM_IOCTL_ANONYMOUS_DUP ioctl which
>> returns the new duplicated anonymous inode file descriptor
>> (anon_inode:snd-pcm) which can be passed to the restricted clients.

> +	if (!try_module_get(pcm->card->module)) {
>> +		err = -EFAULT;
> 
> EFAULT doesn't appear to be the best fitting for this error path.

It's in the sync with snd_pcm_open(). This error path should not be
activated in the regular environment anyway (so it's real FAULT somewhere).
If it have to be changed, let change all locations in a separate patch.

Thanks for the review.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
