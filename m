From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Decouple DAPM from CODECs
Date: Fri, 5 Nov 2010 10:02:27 -0400
Message-ID: <20101105140226.GB15977@opensource.wolfsonmicro.com>
References: <20101105133817.GJ13709@opensource.wolfsonmicro.com>
	<1288965226-23692-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4189103965
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 15:02:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288965226-23692-1-git-send-email-jhnikula@gmail.com>
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
Cc: Cliff Cai <cliff.cai@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Mike Frysinger <vapier.adi@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, Daniel Gloeckner <dg@emlix.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jassi Brar <jassi.brar@samsung.com>, Ryan Mallon <ryan@bluewatersys.com>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 03:53:46PM +0200, Jarkko Nikula wrote:
> From: Liam Girdwood <lrg@slimlogic.co.uk>
> 
> Decoupling Dynamic Audio Power Management (DAPM) from codec devices is
> required when developing ASoC further. Such as for other ASoC components to
> have DAPM widgets or when extending DAPM to handle cross-device paths.

Applied, thanks.
