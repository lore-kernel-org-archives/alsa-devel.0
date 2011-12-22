From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/9] ASoC: twl6040: Convert MICBIAS to SUPPLY widget
Date: Thu, 22 Dec 2011 20:02:07 +0200
Message-ID: <4EF3709F.2000003@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com> <1324571902-16918-5-git-send-email-peter.ujfalusi@ti.com> <20111222173223.GB29622@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111222173223.GB29622@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 12/22/2011 07:32 PM, Mark Brown wrote:
> It'd be better to put this before all the renaming and whatever, it's=
 a
> mostly separate change and it'd save having to look at it again.

I was planning to leave it in this place for the v3 series.
When I started to implement the feature based support for the machine
driver I realized that I need to separate the Main Mic, and Sub Mic fro=
m
each other.
I remembered your patch(s) doing the conversion from MICBIAS to SUPPLY,
so I did the same thing with the twl6040 codec.
Since the rename of the machine driver has been taken by Liam, a patch
alone for the codec would break the old machine driver.
I can move it forward in the series, but I don't see the benefit.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
