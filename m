From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l51: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 01:38:35 +0000
Message-ID: <6F07E569-1EFA-4F4C-B15E-50B97D9D2DD7@cirrus.com>
References: <1416513940-28717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0111.outbound.protection.outlook.com [157.56.111.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A8FE260638
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 02:38:39 +0100 (CET)
In-Reply-To: <1416513940-28717-1-git-send-email-lars@metafoo.de>
Content-Language: en-US
Content-ID: <A685A8C39C50464C90C24FCA6611B7CC@ad.cirrus.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


> On Nov 21, 2014, at 05:05, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
For both
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks 
