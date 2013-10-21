From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: kirkwood: cleanup the external clock
	probe
Date: Mon, 21 Oct 2013 09:06:57 +0100
Message-ID: <20131021080657.GU25034@n2100.arm.linux.org.uk>
References: <20131021094613.2a07bd79@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 5B0F82655EB
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 10:07:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131021094613.2a07bd79@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 21, 2013 at 09:46:13AM +0200, Jean-Francois Moine wrote:
> This patch checks the return value of the clk_prepare_enable of the
> external clock and removes the test about a same internal and external
> clock which would quite never occur and won't work in most cases
> it would occur.

NAK.  It can occur.
