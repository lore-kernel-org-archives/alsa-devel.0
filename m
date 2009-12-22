From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: sh: FSI:: don't check
	platform_get_irq's	return value against zero
Date: Tue, 22 Dec 2009 12:34:40 +0000
Message-ID: <20091222123440.GB19056@opensource.wolfsonmicro.com>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260979809-24811-7-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6972010382D
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:34:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260979809-24811-7-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, David Vrabel <dvrabel@arcom.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 16, 2009 at 05:10:09PM +0100, Uwe Kleine-K=F6nig wrote:
> platform_get_irq returns -ENXIO on failure, so !irq was probably
> always true.  Better use (int)irq <=3D 0.  Note that a return value of
> zero is still handled as error even though this could mean irq0.
> =

> This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
> changed the return value of platform_get_irq from 0 to -ENXIO on error.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.
