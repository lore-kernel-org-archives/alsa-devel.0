From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Wed, 14 Sep 2011 13:36:04 +0100
Message-ID: <1316003764.3229.15.camel@odin>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id B59AC103AB8
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 14:36:09 +0200 (CEST)
Received: by wyh13 with SMTP id 13so2136526wyh.16
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 05:36:07 -0700 (PDT)
In-Reply-To: <1315936777-27994-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 12:59 -0500, Timur Tabi wrote:
> ASoC codec drivers can use the .set_sysclk function to dynamically specify
> the list of support sample rates, because that list is often based on
> the input clock frequency.  Although the WM8776 includes a .set_sysclk
> function, it was also hard-coding the supported sample rates to a list
> that depends on a specific input clock frequency.
> 
> So change the hard-coded list to a range within the capabilities of the
> WM8776 itself, and let wm8776_set_sysclk() do its job.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
