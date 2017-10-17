From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ASoC: tpa61xx: add back chip name to the
	controls
Date: Tue, 17 Oct 2017 12:59:46 +0200
Message-ID: <1508237986.2146.14.camel@pengutronix.de>
References: <20171017095729.6032-1-l.stach@pengutronix.de>
 <20171017101424.7e2bofvuenvfjlns@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 70AE4266F4E
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 12:59:47 +0200 (CEST)
In-Reply-To: <20171017101424.7e2bofvuenvfjlns@sirena.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Am Dienstag, den 17.10.2017, 11:14 +0100 schrieb Mark Brown:
> On Tue, Oct 17, 2017 at 11:57:29AM +0200, Lucas Stach wrote:
> > Commit cb7e62256e99( ASoC: tpa6130a2: Register component) removed
> > the chip
> > name from the controls, which causes issues as the TPA61xx is not a
> > standalone codec, but a headphone amplifier, which may be connected
> > to the
> > line out of a codec which already exposes a "Headphone Playback
> > Volume"
> > control. In that case we end up with duplicate controls, causing
> > the
> > the probe of the soundcard to be aborted.
> 
> In this case the intention is that the machine driver should add a
> prefix via name_prefix in a struct snd_soc_codec_conf.

Thanks for the pointer.

In my case the machine driver is the simple-card. I'll have a look at
how I can get the prefix hooked up there.

Regards,
Lucas
