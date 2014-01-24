From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: arizona: Check clocking during
 hw_params rather than startup
Date: Fri, 24 Jan 2014 18:25:06 +0100
Message-ID: <52E2A1F2.6070707@metafoo.de>
References: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-211.synserver.de
 [212.40.185.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 509F3265467
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 18:25:12 +0100 (CET)
In-Reply-To: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 01/24/2014 05:59 PM, Charles Keepax wrote:
> It is a fairly common usage to configure SYSCLK as part of the hw_params
> callback in the machine driver. The current driver applies PCM
> constraints based on the value of SYSCLK during the startup callback
> however because many systems will have not configured SYSCLK yet this
> will often use the SYSCLK value that was used for the last stream.
> 
> The patch checks the clocking constraints as part of the hw_params
> callback, which will be after any clocking changes have been made by
> the machine driver.

The problem with this approach is that if the sysclk is fixed instead to
e.g. falling back to rate conversion you'll get an error instead when
calling hw_params. The typical idiom here is to only apply the rate
constraints in the CODEC driver if the sysclk is non zero. This driver
already seems to do this. The problem that you probably see is that if the
machine driver changes the sysclk value in hw_params the constraints that
are setup are still setup with the previous sysclk in mind. I think instead
of removing the constraints support altogether from the driver a better
solution is to introduce a dynamic_sysclk or similar attribute to the DAI
link and not constrain the supported rates if this attribute is set to true.

- Lars
