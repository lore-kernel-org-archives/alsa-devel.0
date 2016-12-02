From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: core: update supported sample rates
Date: Fri, 2 Dec 2016 08:36:22 +0100
Message-ID: <b67d6159-2e33-fba8-b9b4-5c01efd7634d@ladisch.de>
References: <c372493a-cbd1-4750-86c1-10c1fff178b2@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B3643266942
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 08:36:25 +0100 (CET)
In-Reply-To: <c372493a-cbd1-4750-86c1-10c1fff178b2@EX4.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li Xu <li.xu@cirrus.com>, alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, tiwai@suse.com, paul.handrigan@cirrus.com, o-takashi@sakamocchi.jp, jeeja.kp@intel.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Li Xu wrote:
> Add 12KHz, 24KHz, 352.8KHz and 384KHz audio sample rates
>
> +#define SNDRV_PCM_RATE_12000		(1<<3)		/* 12000Hz */
> +#define SNDRV_PCM_RATE_24000		(1<<6)		/* 24000Hz */
> +#define SNDRV_PCM_RATE_352800		(1<<15)		/* 352800Hz */
> +#define SNDRV_PCM_RATE_384000		(1<<16)		/* 384000Hz */

To quote <http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064461.html>:
You don't need such symbols to use a rate.  These symbols are intended
for often-used rates.  As long as only one or two drivers use a rate,
they can just set KNOT and install a constraint.

How many driver would actually use it?


Regards,
Clemens
