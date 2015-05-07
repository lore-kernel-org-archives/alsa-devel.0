From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: dapm: Break out of widget search
 when source and sink are located
Date: Thu, 07 May 2015 13:24:27 +0200
Message-ID: <554B4B6B.2010700@metafoo.de>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F11B2606E0
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 13:24:26 +0200 (CEST)
In-Reply-To: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/07/2015 12:33 PM, Charles Keepax wrote:
> Currently snd_soc_dapm_add_route will continue to search the widget list
> even after both the source and sink for the route have been located.
> This patch breaks out of the search when both are located giving a
> small improvement in probe time for drivers.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
