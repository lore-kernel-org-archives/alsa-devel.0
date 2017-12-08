From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v2 2/2] ASoC: rsnd: ssi: remove unnesessary
	period_pos
Date: Thu, 7 Dec 2017 21:43:05 -0800
Message-ID: <5A2A2669.4020506@mentor.com>
References: <1512634956-17760-1-git-send-email-jiada_wang@mentor.com>
 <1512634956-17760-3-git-send-email-jiada_wang@mentor.com>
 <87wp1y7trw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 45739267B7B
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 06:43:07 +0100 (CET)
In-Reply-To: <87wp1y7trw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

On 12/07/2017 01:58 AM, Kuninori Morimoto wrote:
> Hi Jiada
>
>> Further more, if the passed 'byte' amount to
>> rsnd_ssi_pointer_update() is more than byte_per_period.
>> the calculation of next_period_byte isn't correct.
> Is it really happen ??
>
> Basically, I have no objection about this patch,
> but this explanation is very strange for me...
No, I didn't see the issue,
but the implementation of rsnd_ssi_pointer_update(), behaves like
it knows all caller will always pass 'byte' no larger than byte_per_period,
without any check internally.

I am ok to remove this explanation from commit message,
what do you think?

Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
