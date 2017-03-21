From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: codec: wm8960: Refactor
	sysclk freq search
Date: Tue, 21 Mar 2017 12:43:02 +0000
Message-ID: <20170321124302.GW6986@localhost.localdomain>
References: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
 <1490090976-25877-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 33DB22671BA
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 13:42:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1490090976-25877-2-git-send-email-daniel.baluta@nxp.com>
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
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 12:09:35PM +0200, Daniel Baluta wrote:
> Add a separate function for finding (sysclk, lrclk, bclk)
> when the clock is auto or mclk. This makes code easier to
> read and reduces the indentation level in wm8960_configure_clocking.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
