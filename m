From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Fri, 4 Apr 2014 16:52:28 -0500
Message-ID: <alpine.DEB.2.02.1404041651030.3451@heelrod>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
 <alpine.DEB.2.02.1404041646460.3451@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0100.outbound.protection.outlook.com [207.46.100.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B1D92655AB
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 02:01:38 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1404041646460.3451@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 4 Apr 2014, Brian Austin wrote:

> Correct me if I'm wrong, but it looks like you added CS42L52_CHIP_REV_MASK 
> and then replaced that define with CS42L52_CHIP_REV_B1?
>
> I think some changes to actually display the correct rev_id based on the 
> return value of the reg_read would be cool but this isn't it IMO. I don't 
> think it will be either.
s/be/build/
