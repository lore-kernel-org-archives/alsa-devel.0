From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: Add Playback Volume control
Date: Mon, 28 Jun 2010 09:47:09 +0100
Message-ID: <20100628084709.GA14247@rakim.wolfsonmicro.main>
References: <w3ptyork0j5.wl%kuninori.morimoto.gx@renesas.com>
	<1277463024.3123.16.camel@odin>
	<w3piq54roby.wl%kuninori.morimoto.gx@renesas.com>
	<w3pfx07svmu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09A911038E5
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 10:47:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pfx07svmu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 28, 2010 at 12:07:05PM +0900, Kuninori Morimoto wrote:

> Manual said this register name is "Digital Volume Control".
> In this case, should I use "Digital Playback Volume" ?
> or "Master Playback Volume" ?

Either is fine.

> > +static const DECLARE_TLV_DB_SCALE(out_tlv, -11500, 50, 1);

> Is this -11500 correct ?
> it should be -11550 ?

Should be -11600.  You can check this by using an application like
alsamixer and looking at the dB values displayed in the UI.

> > +static const struct snd_kcontrol_new ak4642_snd_controls[] = {

> > +	SOC_DOUBLE_R_TLV("Playback Volume", L_DVC, R_DVC,
> > +			 0, 0xFF, 1, out_tlv),

> And here, Is 0xFF correct here ?
> Is it 0xFE ?

No, 0xff is still a valid value.
