From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4349: Remove unneeded NULL test
 for cs4349->reset_gpio
Date: Thu, 30 Jul 2015 16:47:03 -0500
Message-ID: <alpine.DEB.2.10.1507301641040.8075@ChromiumBuilder>
References: <1437530387.24723.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 14AC626070C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:47:32 +0200 (CEST)
In-Reply-To: <1437530387.24723.1.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Tue, 21 Jul 2015, Axel Lin wrote:

> It's safe to call gpiod_set_value_cansleep() with NULL desc.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs4349.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
Great, thanks.
Acked-by: Tim Howe <tim.howe@cirrus.com>
