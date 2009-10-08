From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 08 Oct 2009 15:30:29 +0300
Message-ID: <1255005029.30157.164.camel__9645.28718400306$1255005602$gmane$org@eenurkka-desktop>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
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
Cc: ext Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-08 at 13:58 +0200, Valentin Eduardo (Nokia-D/Helsinki)
wrote:
> +/*
> + * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
> + * down in gain. Justify scale so that it is quite correct from -20 dB and
> + * up. This setting shows -30 dB at minimum, -12.95 dB at 49 % (actual
> + * is -10.3 dB) and 4.65 dB at maximum (actual is 4 dB).
> + */

The comment is misleading from all it says. For me it seems that the
scale is quite correct from -59.5 to 4 dB or so. Also the minimum is
-59.5 dB, not -30.

> +static const unsigned int tpa6130_tlv[] = {
> +       TLV_DB_RANGE_HEAD(10),
> +       0, 1, TLV_DB_SCALE_ITEM(-5950, 600, 0),
> +       2, 3, TLV_DB_SCALE_ITEM(-5000, 250, 0),
> +       4, 5, TLV_DB_SCALE_ITEM(-4550, 160, 0),
> +       6, 7, TLV_DB_SCALE_ITEM(-4140, 190, 0),
> +       8, 9, TLV_DB_SCALE_ITEM(-3650, 120, 0),
> +       10, 11, TLV_DB_SCALE_ITEM(-3330, 160, 0),
> +       12, 13, TLV_DB_SCALE_ITEM(-3040, 180, 0),
> +       14, 20, TLV_DB_SCALE_ITEM(-2710, 110, 0),
> +       21, 37, TLV_DB_SCALE_ITEM(-1960, 74, 0),
> +       38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0),
> +};
> +

