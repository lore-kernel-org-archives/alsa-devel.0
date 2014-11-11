From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/11] ASoC: ac97: Push snd_ac97 pointer to
	the driver	level
Date: Tue, 11 Nov 2014 12:46:10 +0000
Message-ID: <20141111124610.GB23178@opensource.wolfsonmicro.com>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
 <1415655713-29842-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74F51265054
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 13:46:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1415655713-29842-12-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2014 at 10:41:53PM +0100, Lars-Peter Clausen wrote:
> Now that the ASoC core no longer needs a handle to the AC'97 device that is
> associated with a CODEC we can remove it from the snd_soc_codec struct and
> push it into the individual driver state structs like we do for other
> communication buses. Doing so creates a clean separation between the AC'97
> bus support and the ASoC core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

The Wolfson bits look ok to me:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
