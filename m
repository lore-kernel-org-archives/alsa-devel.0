From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH 1/3] ASoC: max98357a: Make 'sdmode-gpios'
 dts property optional
Date: Mon, 13 Jul 2015 15:04:15 -0700
Message-ID: <20150713220400.GA31568@kwestfie-linux.qualcomm.com>
References: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 211B9262632
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 00:04:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kwestfie@codeaurora.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 12, 2015 at 08:14:19AM -0700, Anatol Pomozov wrote:
> The option is not needed if chip is always on or managed by some other part
> of system like platform card driver.
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---

For all three patches:

Confirmed audio functionality on Storm board (ipq806x).

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
