From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/4] ASoC: tegra: Replace instances of
 rtd->codec->card with rtd->card
Date: Mon, 21 Jul 2014 14:23:54 -0600
Message-ID: <53CD76DA.8070102@wwwdotorg.org>
References: <1405627268-23939-1-git-send-email-lars@metafoo.de>
 <1405627268-23939-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFA426545B
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 22:23:59 +0200 (CEST)
In-Reply-To: <1405627268-23939-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/17/2014 02:01 PM, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help to
> eventually remove the card field from the snd_soc_codec struct.

Acked-by: Stephen Warren <swarren@nvidia.com>
