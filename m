From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: DAPM: Add private data
 pointer for DAPM widget
Date: Mon, 22 Aug 2011 23:32:32 +0100
Message-ID: <20110822223232.GB29473@opensource.wolfsonmicro.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-2-git-send-email-peter.ujfalusi@ti.com>
	<20110820070219.GC5011@opensource.wolfsonmicro.com>
	<1508700.DYiRuuCFX2@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E10524337
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:32:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1508700.DYiRuuCFX2@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 04:33:20PM +0300, P=E9ter Ujfalusi wrote:
> On Saturday 20 August 2011 09:02:20 Mark Brown wrote:

> > If we're adding this we should probably go the accessor route like we do
> > with the driver data for the CODECs.

> Something like:

> static inline void *snd_soc_widget_get_pdata(struct snd_soc_dapm_widget *=
w)
> {
>         return w->private_data;
> }

Yeah, something like that.

> Another option at the moment is that I create global variable within the =
omap-
> mcpdm.c, so I can have access to the mcpdm within the dapm event handler.

That'll probably break in future I'd guess.
