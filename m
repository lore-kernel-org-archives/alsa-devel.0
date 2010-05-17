From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: small power
 handling updates
Date: Mon, 17 May 2010 20:35:59 +0100
Message-ID: <1274124959.3185.8.camel@odin>
References: <1274095306-24838-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 057132474C
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 21:36:01 +0200 (CEST)
Received: by fxm18 with SMTP id 18so236421fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 12:36:01 -0700 (PDT)
In-Reply-To: <1274095306-24838-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-17 at 14:21 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> While testing suspend, it has been noticed, that the driver would
> try to power off the codec more than once.
> Since this case handled in the driver, and results no functional
> defect we can lower the noise in the kernel log.
> 
> Also avoid the root cause of the multiple off calls by filtering
> BIAS_OFF request when the codec was already OFF.
> 
> ---
> Felipe Balbi (1):
>   ASoC: tlv320dac33: Use dev_dbg in dac33_hard_power function
> 
> Peter Ujfalusi (1):
>   ASoC: tlv320dac33: Avoid powering off while in BIAS_OFF
> 
>  sound/soc/codecs/tlv320dac33.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
