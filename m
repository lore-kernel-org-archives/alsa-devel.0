From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: add default case for
	unexpected ID
Date: Tue, 06 May 2014 11:15:52 -0600
Message-ID: <536918C8.6030705@wwwdotorg.org>
References: <1399362966-19908-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E73826179C
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 19:15:57 +0200 (CEST)
In-Reply-To: <1399362966-19908-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 05/06/2014 01:56 AM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> We may read an unexpected value when detemining which codec is attached.
> In that case, either a unsupported codec is attached or something wrong 
> with I2C. The driver will not work properly on both cases. So we return
> an error for that.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
