From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Provide CODEC clocking
 operations and API calls
Date: Tue, 08 Mar 2011 17:59:09 +0000
Message-ID: <1299607149.3374.10.camel@odin>
References: <1299532039-10637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C6FE103959
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 18:59:13 +0100 (CET)
Received: by wwj40 with SMTP id 40so1126413wwj.20
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 09:59:12 -0800 (PST)
In-Reply-To: <1299532039-10637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-07 at 21:07 +0000, Mark Brown wrote:
> When multi component systems use DAIless amplifiers which require clocking
> configuration it is at best hard to use the current clocking API as this
> requires a DAI even though the device may not even have one. Address this
> by adding set_sysclk() and set_pll() operations and APIs for CODECs.
> 
> In order to avoid issues with devices which could be used either with or
> without DAIs make the DAI variants call through to their CODEC counterparts
> if there is no DAI specific operation. Converting over entirely would create
> problems for multi-DAI devices which offer per-DAI clocking setup.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@ti.com>
