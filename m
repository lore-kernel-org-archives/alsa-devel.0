From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: remove one extraneous 'const'
Date: Tue, 14 Jun 2016 13:35:29 +0100
Message-ID: <20160614123529.GY20422@localhost.localdomain>
References: <5926900.hCFXH4RQH6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A83D22608EC
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 14:35:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5926900.hCFXH4RQH6@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Nikesh Oswal <Nikesh.Oswal@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2016 at 12:17:52PM +0200, Arnd Bergmann wrote:
> A recent commit made a few arrays 'const', but also added the
> same attribute to a function return type, where it makes no
> sense, and we get a warning when building with W=1:
> 
> sound/soc/codecs/arizona.c:1725:27: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
>  static const char * const arizona_dai_clk_str(int clk_id)
> 
> This removes it again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a3178a3ed798 ("ASoC: arizona: Add a couple of missing consts")
> ---

Oops.. got a bit overzealous there, thanks for fixing.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
