From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs4349: Fix max_register setting
 for cs4349_regmap
Date: Fri, 17 Jul 2015 14:57:33 -0500
Message-ID: <alpine.DEB.2.10.1507171454570.16318@ChromiumBuilder>
References: <1437147514.1229.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C687026172C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 21:57:53 +0200 (CEST)
In-Reply-To: <1437147514.1229.1.camel@ingics.com>
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

On Fri, 17 Jul 2015, Axel Lin wrote:

> The max_register should be the maximum valid register index rather than
> number of registers. Also remove unused defines.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs4349.c | 2 +-
>  sound/soc/codecs/cs4349.h | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
For both patches
Thank you!
Acked-by: Tim Howe <tim.howe@cirrus.com>
