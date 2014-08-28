From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l32: Simplify implementation of
 cs35l32_codec_set_sysclk
Date: Thu, 28 Aug 2014 10:08:02 -0500
Message-ID: <alpine.DEB.2.02.1408281007020.27378@heelrod>
References: <1409214476.21395.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CCE6265363
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 17:07:27 +0200 (CEST)
In-Reply-To: <1409214476.21395.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Aug 2014, Axel Lin wrote:

> Use single snd_soc_update_bits() call to update the register bits.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs35l32.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
> index 9c6b272..380c212 100644
> --- a/sound/soc/codecs/cs35l32.c
> +++ b/sound/soc/codecs/cs35l32.c
Thanks Axel,

Tested-by: Brian Austin <brian.austin@cirrus.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
