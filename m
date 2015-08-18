From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8741: Drop misleading readable_reg
 callback implementation
Date: Tue, 18 Aug 2015 14:09:29 +0100
Message-ID: <20150818130929.GC9493@ck-lbox>
References: <1439546281.5150.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D8A260A5B
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 15:29:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1439546281.5150.2.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 14, 2015 at 05:58:01PM +0800, Axel Lin wrote:
> regmap_readable() returns false if map->format.format_write is set.
> For .reg_bits = 7, .val_bits = 9, setting,
>   map->format.format_write = regmap_format_7_9_write;
> 
> Even current code has implemented map->readable_reg, regmap_readable()
> still returns false anyway. Thus drop the misleading readable_reg callback
> implementation.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Apologies, on the slight delay we have had a bit of an email
fiasco going on at this end, hopefully all resolved now.

Thanks,
Charles
