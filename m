From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 12 Jun 2017 08:50:38 +0200
Message-ID: <d79788a1-8e96-7d99-28b5-0500c3c17c5b@ladisch.de>
References: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E547266DF2
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 08:50:39 +0200 (CEST)
In-Reply-To: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
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
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Subhransu S. Prusty wrote:
> Add new hw_params flag to explicitly tell driver that rewinds will never
> be used. [...]

> +++ b/sound/core/pcm_native.c
> @@ -2521,6 +2523,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>  	if (frames == 0)
>  		return 0;
>
> +	if (runtime->no_rewinds)
> +		return 0;

Doing a rewind when you've promised not to is an error.  So why doesn't
this return an error code?


Regards,
Clemens
