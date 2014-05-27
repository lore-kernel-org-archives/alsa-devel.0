From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs42l56: Fix new value argument
 in snd_soc_update_bits calls
Date: Tue, 27 May 2014 09:31:29 -0500
Message-ID: <alpine.DEB.2.02.1405270930300.10781@heelrod>
References: <1400821531.915.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 by alsa0.perex.cz (Postfix) with ESMTP id B01DD2655B1
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 16:29:55 +0200 (CEST)
In-Reply-To: <1400821531.915.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


On Fri, 23 May 2014, Axel Lin wrote:

> The new value argument needs proper shift to match the mask bit fields.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> v3: Define CS42L56_MUTE_ALL as 0xff, so all the mask bits will be set.
> v2: Address Brian's comment in v1.
Looks good Axel,
Thanks

Tested-by: Brian Austin <brian.austin@cirrus.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
