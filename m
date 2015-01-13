From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Tue, 13 Jan 2015 21:41:01 +0200
Message-ID: <54B574CD.9020905@ti.com>
References: <20150112122527.GF12302@n2100.arm.linux.org.uk>
 <1421071197.3081.44.camel@pengutronix.de>
 <20150112140456.GI12302@n2100.arm.linux.org.uk>
 <20150112181341.4a53ea24@armhf>
 <20150112175705.GN12302@n2100.arm.linux.org.uk>
 <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
 <20150113165411.5469930d@armhf>
 <20150113160313.GR12302@n2100.arm.linux.org.uk>
 <20150113200252.3dbfab14@armhf>
 <20150113192648.GU12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id E3508260483
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 20:41:07 +0100 (CET)
In-Reply-To: <20150113192648.GU12302@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jean-Francois Moine <moinejf@free.fr>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/13/2015 09:26 PM, Russell King - ARM Linux wrote:
> SCLK: _~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_
>    WS: __~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~________________________________~
> I2S1: llmm............................llmm............................llm
> I2S2: llmm............................llmm............................llm
> I2S3: llmm............................llmm............................llm
> I2S4: llmm............................llmm............................llm
>
> So, what I'm saying is that it is_impossible_  to drive the TDA998x using
> multiple I2S streams which are not produced by the same I2S block.

This is besides the point, but it is possible that one of the multiple =

I2S blocks is the bit-clock and frame-clock master to the i2s bus and =

the others are slaves to it (banging their bits according to SCLK and WS =

of the I2S master). However, in this situation there really is only one =

i2s bus with multiple data pins.

Just my 0.02=80 to this discussion.
