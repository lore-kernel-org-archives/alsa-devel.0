From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Thu, 20 Apr 2017 10:07:34 +0100
Message-ID: <20170420090734.GA1594@localhost.localdomain>
References: <20170419170449.2965453-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id AFF37266FBF
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 11:06:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170419170449.2965453-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 19, 2017 at 07:04:20PM +0200, Arnd Bergmann wrote:
> The new PLL configuration code triggers a harmless warning:
> 
> sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
> sound/soc/codecs/wm8960.c:735:3: error: 'best_freq_out' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    wm8960_set_pll(codec, freq_in, best_freq_out);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/wm8960.c:699:12: note: 'best_freq_out' was declared here
> 
> I think the warning was introduced by Daniel's bugfix. I've come up
> with a way to simplify the code in a way that is more readable to
> both humans and to gcc, which gets us rid of the warning.
> 
> Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
> Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
