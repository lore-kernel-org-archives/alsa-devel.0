From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 13:09:19 +0800
Message-ID: <20110719050918.GG3838@S2100-06.ap.freescale.net>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id 70ED724506
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 07:02:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 18, 2011 at 05:53:02PM +0200, Wolfram Sang wrote:
> These are three patches I developed while trying to make the sgtl5000 work on
> an mx28evk with the mxs-support provided by Dong Aisheng. The chip used to
> lock up before, because a wrong value was written to the power control.
> 
> The first patch removes code duplication
> The second one is for user-comfort
> The third one makes the device work
> 
> Aisheng: This should make your hack for the sgtl5000 obsolete. Could you please
> test it and add your Tested-by-tag if it also works for you? (Or Reviewed-by if
> you want to review the code).
> 
> Zeng Zhaoming: Did this code really work for you?
> 
> Regards,
> 
>    Wolfram
> 
> Wolfram Sang (3):
>   ASoC: sgtl5000: refactor registering internal ldo
>   ASoC: sgtl5000: guide user when regulator support is needed
>   ASoC: sgtl5000: fix cache handling
> 
>  sound/soc/codecs/sgtl5000.c |  198 +++++++++++++++----------------------------
>  1 files changed, 67 insertions(+), 131 deletions(-)
> 
On i.mx51 babbage,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
