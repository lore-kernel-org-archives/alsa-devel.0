From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623
 codec
Date: Wed, 21 Feb 2018 21:26:50 +0900
Message-ID: <001801d3ab0f$3fe07490$bfa15db0$@socionext.com>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
 <20180221121354.GG8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180221121354.GG8334@sirena.org.uk>
Content-Language: ja
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Mark Brown' <broonie@kernel.org>, =?iso-2022-jp?B?U3V6dWtpLCBLYXRzdWhpcm8vGyRCTmtMWhsoQiAbJEI+IUduGyhC?= <suzuki.katsuhiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Thank you for your review.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 21, 2018 9:14 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel@alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
> 
> On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:
> 
> > +Optional properties:
> > +- VCCA-supply : regulator phandle for the VCCA supply
> > +- VCCP1-supply: regulator phandle for the VCCP1 supply
> > +- VCCP2-supply: regulator phandle for the VCCP2 supply
> 
> These should be documented as mandatory unless the device genuinely
> operates without power which seems unlikely.

Indeed, this IC does not work correctly if VCC power supply is lost.
It's not optional. I'll fix it and send V2.


Regards,
--
Katsuhiro Suzuki
