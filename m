From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Remove dapm_sync call from
 soc_post_component_init
Date: Tue, 18 Jan 2011 19:10:00 +0000
Message-ID: <20110118191000.GC14464@opensource.wolfsonmicro.com>
References: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36FEF2414C
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 20:09:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 03:51:45PM +0200, Peter Ujfalusi wrote:
> snd_soc_dapm_new_widgets will call dapm_power_widgets at
> the end, so there is no need to call snd_soc_dapm_sync
> after snd_soc_dapm_new_widgets.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
