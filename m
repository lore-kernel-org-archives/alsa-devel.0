From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH for 2.6.40] ASoC: Fix power down for
 widgetless per-card DAPM context case
Date: Thu, 26 May 2011 15:38:42 +0100
Message-ID: <4DDE65F2.1050908@ti.com>
References: <1306416738-8298-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E6357103888
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 16:38:48 +0200 (CEST)
In-Reply-To: <1306416738-8298-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 26/05/11 14:32, Jarkko Nikula wrote:
> Commit 52ba67b ("ASoC: Force all DAPM contexts into the same bias state")
> powers up all the DAPM contexts in a card if any DAPM context becomes
> active. Unfortunately power down newer happens if per-card DAPM context
> doesn't have any widgets.
> 
> Reason for this is that power state of per-card DAPM context without
> widgets is never cleared and thus all the DAPM contexts remain permanently
> active. Test for widgetless calling DAPM context in dapm_power_widgets()
> doesn't work for per-card DAPM context since power change is never
> originating from widgetless per-card DAPM context.
> 
> Fix this by pre-clearing power state flag of non-codec DAPM context at the
> beginning of power sequence.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/soc-dapm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
