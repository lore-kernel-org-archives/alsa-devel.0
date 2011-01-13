From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tegra: s/IS_ERR_OR_NULL/IS_ERR/ for
 clk_get_sys
Date: Thu, 13 Jan 2011 13:39:25 +0000
Message-ID: <1294925965.3453.6.camel@odin>
References: <1294775333-8372-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E6B4510385E
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:39:29 +0100 (CET)
Received: by wwe15 with SMTP id 15so1757800wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:39:29 -0800 (PST)
In-Reply-To: <1294775333-8372-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 12:48 -0700, Stephen Warren wrote:
> A recent discussion on linux-arm-kernel noted that the value returned by
> clk_get_sys is an opaque token, and not strictly a pointer; it is
> meaningful only to the clock API, clients should not dereference the value,
> and the clock API must accept any non-IS_ERR value it returned.
> 
> Hence, only IS_ERR is appropriate to interpret the result, not
> IS_ERR_OR_NULL.
> 
> I checked that clk_get_sys in both ASoC's for-next and Tegra's for-next
> do behave as described; NULL is not returned in the case of error.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
