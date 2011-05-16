From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: Fix wrong data type access in a
	few codec drivers
Date: Mon, 16 May 2011 09:07:34 -0700
Message-ID: <20110516160732.GB6957@opensource.wolfsonmicro.com>
References: <1305303412-31837-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AD0624408
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 18:07:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305303412-31837-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2011 at 07:16:52PM +0300, Jarkko Nikula wrote:
> Commit fafd217 ("ASoC: Store a list of widgets in a DAPM mux/mixer kcontrol")
> changed the control private data type that is passed to snd_soc_cnew when
> creating dapm mixer and mux controls. Commit did not update a few codec
> drivers that are using their own put callbacks and thus are accessing a
> wrong data type.

Applied, thanks.
