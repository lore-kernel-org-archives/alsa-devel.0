From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v1 3/4] ASoC: codecs: pcm179x: Add reset gpio
Date: Tue, 27 Feb 2018 23:02:00 +0100
Message-ID: <20180227230200.67d8ae45@windsurf.lan>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
        <20180227212433.2189-4-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227212433.2189-4-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
List-Id: alsa-devel@alsa-project.org

Hello,

On Tue, 27 Feb 2018 22:24:32 +0100, Mylène Josserand wrote:
> Add a reset gpio to be able to reset this line at startup.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

This needs an updated of the DT binding, since it's adding support for
a new reset-gpios property.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
