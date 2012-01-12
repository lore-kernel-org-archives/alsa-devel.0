From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Route Mic Bias in Visstrim_M10
	board.
Date: Thu, 12 Jan 2012 03:05:23 +0000
Message-ID: <20120112030522.GC22775@opensource.wolfsonmicro.com>
References: <1326284465-8440-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 857D4103840
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 04:05:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326284465-8440-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2012 at 01:21:05PM +0100, Javier Martin wrote:
> Visstrim_M10 board uses an external microphone
> that can be enabled/disabled by the user

Applied, thanks.  One note:

> 
> ---
> Changes since v1:
>  - Change "audio_map" to "aic32x4_dapm_routes".
>  - Use snd_soc_card fields to register controls,
>    routes and widgets.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Your signoff should come before the --- as tools like git am will
discard any text after the --- and the signoff needs to end up in the
changelog.
