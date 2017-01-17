From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 03/10] dt-bindings: sound: Add new reset compatible
 for sun4i-i2s
Date: Wed, 18 Jan 2017 08:20:34 +1100
Message-ID: <20170118082034.62a6be25@free-electrons.com>
References: <20170117201016.A5fiHT0P@smtp2p.mail.yandex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170117201016.A5fiHT0P@smtp2p.mail.yandex.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, wens@csie.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, linux-sunxi@googlegroups.com, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@free-electrons.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Wed, 18 Jan 2017 01:10:00 +0800, Icenowy Zheng wrote:

> > Add a new compatible for sun4i-i2s driver to handle some
> > SoCs that have a reset line that must be asserted/deasserted.
> >
> > This new compatible, "allwinner,sun6i-a31-i2s", requires two
> > properties:
> > - resets: phandle to the reset line
> > - reset-names: the name of the reset line ("rst").
> > Except these differences, the compatible is identical to previous one
> > which will not handle a reset line.  
> 
> But I think the IP block is identical, right?
> 
> Should a new compatible be added only for reset-line?

Having a different compatible in this case allows to make some stricter
error checking: the driver can make sure that if the compatible string
is sun6i-a31-i2s there *IS* a reset line specified in the DT. Without a
separate compatible value, such a check is not possible, and the reset
line is just optional. This can lead to people being confused if they
forget to specify the reset line.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
