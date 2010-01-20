From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: Burst mode BCLK
 divider fixes
Date: Wed, 20 Jan 2010 11:35:52 +0000
Message-ID: <1263987352.3071.0.camel@odin>
References: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 97E7A244D6
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 12:35:57 +0100 (CET)
Received: by ewy23 with SMTP id 23so4354052ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 03:35:57 -0800 (PST)
In-Reply-To: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-01-20 at 09:39 +0200, Peter Ujfalusi wrote:
> Hello,
> 
> The following patches provides fixes for the BCLK clock divider configuration
> in tlv320dac33 codec.
> BCLK divider is used to specify the speed of the serial bus.
> The speed of the bus can be (must be) faster than the actual stream's
> sample rate in order to use the system in burst mode.
> 
> With the introduction of mode7 FIFO mode, the BCLK handling got broken in this
> mode, the first patch fixes this issue.
> The second patch adds support for configuring the burst mode BCLK through
> platform data.
> 
> ---
> Peter Ujfalusi (2):
>   ASoC: tlv320dac33: BCLK divider fix
>   ASoC: tlv320dac33: Burst mode BCLK divider configuration
> 
>  include/sound/tlv320dac33-plat.h |    1 +
>  sound/soc/codecs/tlv320dac33.c   |   22 +++++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
