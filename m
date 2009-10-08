From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 16:07:50 +0300
Message-ID: <200910081607.50375.peter.ujfalusi__31535.370674874$1255009538$gmane$org@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
	<1255005029.30157.164.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255005029.30157.164.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 08 October 2009 15:30:29 Nurkkala Eero.An (EXT-Offcode/Oulu) wr=
ote:
> On Thu, 2009-10-08 at 13:58 +0200, Valentin Eduardo (Nokia-D/Helsinki)
> =

> wrote:
> > +/*
> > + * TPA6130 volume. From -59.5 to 4 dB with increasing step size when
> > going + * down in gain. Justify scale so that it is quite correct from
> > -20 dB and + * up. This setting shows -30 dB at minimum, -12.95 dB at 49
> > % (actual + * is -10.3 dB) and 4.65 dB at maximum (actual is 4 dB).
> > + */
> =

> The comment is misleading from all it says. For me it seems that the
> scale is quite correct from -59.5 to 4 dB or so. Also the minimum is
> -59.5 dB, not -30.

Yes, the scale is really close to the reality, the comment need to be fixed=
. =


-- =

P=E9ter
