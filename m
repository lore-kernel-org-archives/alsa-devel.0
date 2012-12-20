From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be
 freed in pause state
Date: Thu, 20 Dec 2012 10:29:56 +0000
Message-ID: <50D2E8A4.8060203@ti.com>
References: <1355974562-21537-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 685752651A7
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 11:29:59 +0100 (CET)
In-Reply-To: <1355974562-21537-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 20/12/12 03:36, Patrick Lai wrote:
> When front-end PCM session is in paused state, back-end
> PCM session will be put in paused state as well if given
> front-end PCM session is the only client of given back-end.
> Then, application closes front-end PCM session, DPCM
> framework will not allow back-end enters HW_FREE state
> so back-end will never get shutdown completely.
>
> Signed-off-by: Patrick Lai <plai@codeaurora.org>

Acked-by: Liam Girdwood <lrg@ti.com>
