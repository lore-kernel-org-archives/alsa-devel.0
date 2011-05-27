From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix dapm_is_shared_kcontrol so
 everything isn't shared
Date: Fri, 27 May 2011 21:59:33 +0800
Message-ID: <20110527135932.GA4240@opensource.wolfsonmicro.com>
References: <1306425453-20753-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26743103828
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 15:59:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306425453-20753-1-git-send-email-swarren@nvidia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 26, 2011 at 09:57:33AM -0600, Stephen Warren wrote:
> Commit af46800 ("ASoC: Implement mux control sharing") introduced
> function dapm_is_shared_kcontrol.
> 
> When this function returns true, the naming of DAPM controls is derived
> from the kcontrol_new. Otherwise, the name comes from the widget (and
> possibly a widget's naming prefix).

Applied, thanks.
