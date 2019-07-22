From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/4] ALSA: compress: Fix regression on
 compressed capture streams
Date: Mon, 22 Jul 2019 16:05:20 +0530
Message-ID: <20190722103520.GQ12733@vkoul-mobl.Dlink>
References: <20190722092436.651-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4797F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 12:36:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190722092436.651-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 22-07-19, 10:24, Charles Keepax wrote:
> A previous fix to the stop handling on compressed capture streams causes
> some knock on issues. The previous fix updated snd_compr_drain_notify to
> set the state back to PREPARED for capture streams. This causes some
> issues however as the handling for snd_compr_poll differs between the
> two states and some user-space applications were relying on the poll
> failing after the stream had been stopped.
> 
> To correct this regression whilst still fixing the original problem the
> patch was addressing, update the capture handling to skip the PREPARED
> state rather than skipping the SETUP state as it has done until now.

For the whole series:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
