From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Decouple DAPM from CODECs
Date: Thu, 4 Nov 2010 23:29:20 -0400
Message-ID: <20101105032919.GA12228@opensource.wolfsonmicro.com>
References: <20101101131322.GC22639@opensource.wolfsonmicro.com>
	<1288874285-16569-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72506103840
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 04:29:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288874285-16569-1-git-send-email-jhnikula@gmail.com>
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

On Thu, Nov 04, 2010 at 02:38:05PM +0200, Jarkko Nikula wrote:
> From: Liam Girdwood <lrg@slimlogic.co.uk>
> 
> Decoupling Dynamic Audio Power Management (DAPM) from codec devices is
> required when developing ASoC further. Such as for other ASoC components to
> have DAPM widgets or when extending DAPM to handle cross-device paths.

This looks good but won't apply without your DAPM locking change.  In a
case like this where the patch is going to be applied on a different
branch to the one the dependency is on it's usually best to let the
merge get sorted out when the branches get merged.
