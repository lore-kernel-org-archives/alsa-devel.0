From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: [PATCH v3 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Mon, 28 Nov 2011 15:39:08 +0200
Message-ID: <1395094.13m9Q8WstL@barack>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com> <2729071.3pgFW4tmaY@barack> <20111128114404.GE2934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111128114404.GE2934@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 28 November 2011 11:44:05 Mark Brown wrote:
> Only if the user is using the same machine driver as you.  If the use=
r
> wants a fixed clock rate for the DMIC and sets it on init rather than
> resetting it every time hw_params() is called then this will break.

Ah, true. Will send the update soon.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
