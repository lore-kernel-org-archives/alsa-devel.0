From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 13:03:57 -0500
Message-ID: <5033CD8D.6070002@linux.intel.com>
References: <s5hr4r0359e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 28536266019
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 20:07:52 +0200 (CEST)
In-Reply-To: <s5hr4r0359e.wl%tiwai@suse.de>
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

On 8/21/2012 5:31 AM, Takashi Iwai wrote:
> The additional alsa-lib API functions look like:
>
>    int **snd_pcm_query_chmaps(snd_pcm_t *pcm);
>    int *snd_pcm_get_chmap(snd_pcm_t *pcm);
>    int snd_pcm_set_chmap(snd_pcm_t *pcm, const int *map);
Hi Takashi,
Maybe my question is slightly off-topic but can this be used by 
applications relying on tinyALSA or tinyCompress? Looks like we will 
need to replicate the same ideas based on TLV?
Thanks,
-Pierre
