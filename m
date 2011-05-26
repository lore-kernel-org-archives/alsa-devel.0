From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH for 2.6.40] ASoC: Fix power down for
 widgetless per-card DAPM context case
Date: Thu, 26 May 2011 23:08:33 +0800
Message-ID: <20110526150832.GA17148@opensource.wolfsonmicro.com>
References: <1306416738-8298-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 418CC103B08
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:08:43 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 26, 2011 at 04:32:18PM +0300, Jarkko Nikula wrote:
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

Applied, thanks, though this is a bit of a band aid as we're currently
still allowing widgetless CODECs.
