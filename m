From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs42xx8: Setup of_match_table
Date: Fri, 26 Jun 2015 13:29:11 -0500
Message-ID: <alpine.DEB.2.10.1506261328210.7254@heelroid>
References: <1435239703.22170.1.camel@ingics.com>
 <1435239853.22170.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A5A265340
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 20:27:20 +0200 (CEST)
In-Reply-To: <1435239853.22170.4.camel@ingics.com>
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

On Thu, 25 Jun 2015, Axel Lin wrote:

> Setup of_match_table and since cs42xx8_of_match is exported and used in
> cs42xx8-i2c.c, it cannot be static.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
For Both. Thanks Axel,

Acked-by: Brian Austin <brian.austin@cirrus.com> 
