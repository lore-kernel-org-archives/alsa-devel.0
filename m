From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 4/4] ASoC: cs42l73: Use case range at
	appropriate place
Date: Wed, 12 Aug 2015 07:17:43 -0500
Message-ID: <alpine.DEB.2.10.1508120716440.27423@heelroid>
References: <1439348866.3594.2.camel@ingics.com>
 <1439349049.3594.6.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 332B5260421
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 14:16:53 +0200 (CEST)
In-Reply-To: <1439349049.3594.6.camel@ingics.com>
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

On Tue, 11 Aug 2015, Axel Lin wrote:

> The readable registers are in continuous ranges: 0x01 ~ 0x03, 0x05 ~ 0x5f.
> Use case range syntax makes the code shorter with better readability when
> we have a large number of continuous switch cases.
> No functional change with this patch.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
That looks so much nicer!
Thanks Axel

Acked-by: Brian Austin <brian.austin@cirrus.com>
