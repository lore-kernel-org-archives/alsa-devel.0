From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/5] ASoC: dapm: Use
	snd_soc_dapm_add_path() in snd_soc_dapm_new_pcm()
Date: Wed, 07 May 2014 15:35:31 +0200
Message-ID: <536A36A3.1080903@metafoo.de>
References: <1399467948-8770-1-git-send-email-lars@metafoo.de>
 <1399467948-8770-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D45A2652CD
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:35:39 +0200 (CEST)
In-Reply-To: <1399467948-8770-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/07/2014 03:05 PM, Lars-Peter Clausen wrote:
> @@ -3275,13 +3276,10 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>
>   	memset(&routes, 0, sizeof(routes));
>
> -	routes[0].source = source->name;
> -	routes[0].sink = link_name;
> -	routes[1].source = link_name;
> -	routes[1].sink = sink->name;

The patch should probably also remove routes, as it is now unused...
