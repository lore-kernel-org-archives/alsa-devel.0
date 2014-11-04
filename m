From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: no dapm match for AMIC
Date: Tue, 4 Nov 2014 10:35:31 -0200
Message-ID: <CAOMZO5Cr7M+ZfAyvEO07HNd0zZmm57iamcHgvk9OODX4noC=aw@mail.gmail.com>
References: <CAOMZO5BUx+mhhELKJw5S8jBMJGHP5wMW5A0kwNAScbOmHMvbUQ@mail.gmail.com>
 <20141104115149.GO3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D1A2605EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:35:32 +0100 (CET)
Received: by mail-lb0-f179.google.com with SMTP id l4so4338851lbv.10
 for <alsa-devel@alsa-project.org>; Tue, 04 Nov 2014 04:35:31 -0800 (PST)
In-Reply-To: <20141104115149.GO3815@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 4, 2014 at 9:51 AM, Mark Brown <broonie@kernel.org> wrote:

> At a guess you've got the route between the microphone and the bias for
> it reversed; it's hard to tell without knowing anything about the
> hardware.

I think you are right. If I invert the route between the mic and bias
then the error disappears:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -107,7 +107,7 @@
                        "Headphone Jack", "HPOUTR",
                        "Ext Spk", "SPKOUTL",
                        "Ext Spk", "SPKOUTR",
-                       "MICBIAS", "AMIC",
+                       "AMIC", "MICBIAS",
                        "IN3R", "MICBIAS",
                        "DMIC", "MICBIAS",
                        "DMICDAT", "DMIC";

Thanks
