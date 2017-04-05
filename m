From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: codec: wm9860: Refactor PLL out
	freq search
Date: Wed, 5 Apr 2017 10:01:41 +0100
Message-ID: <20170405090141.GZ6986@localhost.localdomain>
References: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
 <1491324314-27067-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B191266FA4
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 11:00:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1491324314-27067-2-git-send-email-daniel.baluta@nxp.com>
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

On Tue, Apr 04, 2017 at 07:45:13PM +0300, Daniel Baluta wrote:
> Add a separate function for deriving (sysclk, lrclk, bclk)
> when the clock is auto or pll.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
