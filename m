From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4349: Fix up setting PWR_DWN bit
Date: Thu, 30 Jul 2015 16:49:43 -0500
Message-ID: <alpine.DEB.2.10.1507301648320.8075@ChromiumBuilder>
References: <1437531753.3325.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8536226070C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:50:12 +0200 (CEST)
In-Reply-To: <1437531753.3325.0.camel@ingics.com>
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

> The PWR_DWN is Bit 7, so current code does not set the PWR_DWN bit. Fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs4349.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Another good catch, thank you!
Acked-by: Tim Howe <tim.howe@cirrus.com>
