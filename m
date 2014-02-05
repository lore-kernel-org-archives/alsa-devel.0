From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Wed, 5 Feb 2014 15:48:56 +0000
Message-ID: <CF17B966.8B92%brian.austin@cirrus.com>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 80557264FFB
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 16:49:07 +0100 (CET)
In-Reply-To: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Content-Language: en-US
Content-ID: <6DDF7FAE9166294DABB557D3F2283F9B@ad.cirrus.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2/4/14, 1:55 PM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

>SNDRV_PCM_RATE_KNOT means that the device can support rates that can not
>be
>expressed using the rate bits. The driver will provide a list of those
>rates
>specified through constraints. Any rate bits that are set in the rates
>mask will
>be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT wont
>have any
>effect, but might be confusing to the casual reader, so remove them.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>---
Acked-by: Brian Austin <brian.austin@cirrus.com>
