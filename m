From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
Date: Mon, 22 Jul 2019 16:55:29 -0600
Message-ID: <20190722225529.GA2917@bogus>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-2-srinivas.kandagatla@linaro.org>
 <20190702140252.GO2793@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACA80F800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 00:55:32 +0200 (CEST)
Received: by mail-io1-f65.google.com with SMTP id h6so77653894iom.7
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 15:55:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190702140252.GO2793@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 02, 2019 at 03:02:52PM +0100, Mark Brown wrote:
> On Tue, Jul 02, 2019 at 09:09:15AM +0100, Srinivas Kandagatla wrote:
> 
> > +- qcom,micbias1-lvl:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: Should be voltage in milli Volts for micbias1 output
> 
> milivolts

And a unit suffix in the property name.

> 
> > +	Supported values are in inbetween 1800mV-2850mV
> 
> in between
