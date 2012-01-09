From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Sun, 8 Jan 2012 22:26:31 -0800
Message-ID: <20120109062630.GQ29065@opensource.wolfsonmicro.com>
References: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
	<20120108202332.GE29065@opensource.wolfsonmicro.com>
	<4F0A8091.8050804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A31F9103964
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 07:26:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F0A8091.8050804@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 08, 2012 at 09:52:17PM -0800, Patrick Lai wrote:

> >so it looks like what really ought to happen here is that the existing
> >macro gets renamed to the new macro and a new macro gets defined for
> >double values if one is needed.

> Is there backward compatibility concern? I see soc/codec/uda1380.c
> already using SOC_DOUBLE_S8_TLV.

Obviously all existing users would need to be updated.  Out of tree
users will fail to compile which is fine, it's not going to fail
mysteriously at runtime or anything.
