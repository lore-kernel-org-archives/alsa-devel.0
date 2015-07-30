From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs4349: Set .writeable_reg for
	cs4349_regmap
Date: Thu, 30 Jul 2015 16:19:22 -0500
Message-ID: <alpine.DEB.2.10.1507301615170.8028@ChromiumBuilder>
References: <1437268463.11309.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C9D26071A
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:19:55 +0200 (CEST)
In-Reply-To: <1437268463.11309.1.camel@ingics.com>
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



On Sat, 18 Jul 2015, Axel Lin wrote:

> The first valid register index is 1 rather than 0, and the CS4349_CHIPID
> is readonly. So set .writeable_reg to avoid writing to these registers.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs4349.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
For both patches
Thank you!
Acked-by: Tim Howe <tim.howe@cirrus.com>
