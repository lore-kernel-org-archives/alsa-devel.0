From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 03:16:02 +0800
Message-ID: <20110718191602.GA8576@ubuntu.localdomain>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id E8F8524409
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 05:14:56 +0200 (CEST)
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

On Mon 2011-07-18 17:53:02, Wolfram Sang wrote:
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
Hi, Wolfram:
    Thanks to CC me.
    pls check http://comments.gmane.org/gmane.linux.alsa.devel/83781

    I think Mark is right, sgtl5000 already declared its register_step is 2, soc_cache.c
    should generate a dense cache layout instead of padding it by driver.

    But after check soc_cache.c, ASoC mix up index and register address to index cache,
    and many places need to modify to correct it, so I think we should re-consider
    if register_step != 1 is not a common case.
    
> Regards,
> 
>    Wolfram
>
  Thanks.

> Wolfram Sang (3):
>   ASoC: sgtl5000: refactor registering internal ldo
>   ASoC: sgtl5000: guide user when regulator support is needed
>   ASoC: sgtl5000: fix cache handling
> 
>  sound/soc/codecs/sgtl5000.c |  198 +++++++++++++++----------------------------
>  1 files changed, 67 insertions(+), 131 deletions(-)
> 
> -- 
> 1.7.5.4
> 
