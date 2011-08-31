From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Allow source specification for CODEC
	level sysclk
Date: Wed, 31 Aug 2011 11:54:39 +0100
Message-ID: <4E5E12EF.7020301@ti.com>
References: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 64B211038E2
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:54:47 +0200 (CEST)
In-Reply-To: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 24/08/11 20:09, Mark Brown wrote:
> Similarly to PLLs/FLLs some modern CODECs provide selectable system clock
> sources. When the clock is the clock for a DAI we do not usually need to
> identify which clock is being configured so can use clk_id for the source
> clock but with CODEC wide system clocks we will need to specify both the
> clock being configured and the source.
> 
> Add a source argument to the CODEC driver set_sysclk() operation to
> reflect this. As this operation is not as widely used as the DAI
> set_sysclk() operation the change is not very invasive. We probably
> ought to go and make the same alternation for DAIs at some point.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
