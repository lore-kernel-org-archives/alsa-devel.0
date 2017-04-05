From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: codec: wm8960: Relax bit clock
 computation when using PLL
Date: Wed, 5 Apr 2017 10:02:03 +0100
Message-ID: <20170405090203.GA6986@localhost.localdomain>
References: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
 <1491324314-27067-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A0F266FA5
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 11:00:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1491324314-27067-3-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2017 at 07:45:14PM +0300, Daniel Baluta wrote:
> Bitclk is derived from sysclk using bclk_divs.
> Sysclk can be derived in two ways:
> 	(1) directly from MLCK
> 	(2) MCLK via PLL
> 
> Commit 3c01b9ee2ab9d0d ("ASoC: codec: wm8960: Relax bit clock computation")
> relaxed bitclk computation when sysclk is directly derived from MCLK.
> 
> Lets do the same thing when sysclk is derived via PLL.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
