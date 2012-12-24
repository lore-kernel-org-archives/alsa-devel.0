From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Catch no-match case in
	cs42l52_get_clk
Date: Mon, 24 Dec 2012 20:48:17 +0000
Message-ID: <26CC2042-73C8-43B3-8031-785AE099B8DB@cirrus.com>
References: <1355993596.20315.1.camel@phoenix>,
 <20121224160248.GP30837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED7A261651
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 21:48:45 +0100 (CET)
In-Reply-To: <20121224160248.GP30837@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Axel Lin <axel.lin@ingics.com>, Georgi Vlaev <joe@nucleusys.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org



On Dec 24, 2012, at 10:02, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Dec 20, 2012 at 04:53:16PM +0800, Axel Lin wrote:
>> In the case of no-match, return -EINVAL instead of 0.
>> 
>> Since we assign i to ret in the for loop, ret always less than
>> ARRAY_SIZE(clk_map_table). Thus remove the boundary checking for ret.
> 
> Applied, thanks.

Sorry I did not see this new one. Thanks axel.  FWIW

Acked-by: Brian Austin <brian.austin@cirrus.com>
