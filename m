From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Fix mask for REVID
Date: Sat, 5 Apr 2014 16:52:24 +0000
Message-ID: <27D3AE79-5DF0-445A-8C37-52584F225020@cirrus.com>
References: <1396713875.9878.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0099.outbound.protection.outlook.com [157.56.110.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 598D526517C
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 18:52:29 +0200 (CEST)
In-Reply-To: <1396713875.9878.0.camel@phoenix>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



> On Apr 5, 2014, at 11:04, "Axel Lin" <axel.lin@ingics.com> wrote:
> 
> BIT[0:2] of register 01h is REVID, so the mask for REVID should be 0x7.
> Also updates the code to use CS42L52_CHIP_REV_MASK.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks 
