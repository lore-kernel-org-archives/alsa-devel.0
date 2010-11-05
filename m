From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Decouple DAPM from CODECs
Date: Fri, 5 Nov 2010 09:38:17 -0400
Message-ID: <20101105133817.GJ13709@opensource.wolfsonmicro.com>
References: <20101101131322.GC22639@opensource.wolfsonmicro.com>
	<1288874285-16569-1-git-send-email-jhnikula@gmail.com>
	<20101105032919.GA12228@opensource.wolfsonmicro.com>
	<20101105092008.388e67de.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A132103968
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:38:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101105092008.388e67de.jhnikula@gmail.com>
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

On Fri, Nov 05, 2010 at 09:20:08AM +0200, Jarkko Nikula wrote:

> Lets not take honor from Peter Ujfalusi who find the locking issue
> in DAPM :-)

Remember that From: can be added when you send the patch.

> As this patch is huge, a small fixup below to those conflicting
> lines (and only those) of patch file. That makes the patch to apply on
> top of for-2.6.38 branch.

Please resend something I can apply directly.  It's difficult to apply
this fixup since the patch it's fixing up won't apply in the first
place.
