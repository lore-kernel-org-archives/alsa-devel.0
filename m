From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Fri, 24 Oct 2014 12:10:52 -0200
Message-ID: <CAOMZO5AJ=KehtXWvh10LTCV25gWGn2DgSLprm8bG3trVcsxHrg@mail.gmail.com>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
 <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
 <20141024140440.GG3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E68260573
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 16:10:54 +0200 (CEST)
Received: by mail-la0-f50.google.com with SMTP id s18so2699950lam.23
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 07:10:53 -0700 (PDT)
In-Reply-To: <20141024140440.GG3729@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jonathan Bennett <jbscience87@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2014 at 12:04 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 24, 2014 at 10:20:29AM -0200, Fabio Estevam wrote:
>> On Fri, Oct 24, 2014 at 2:42 AM, Jonathan Bennett <jbscience87@gmail.com> wrote:
>
>> > + ssi_clk = devm_clk_get(&codec_dev->dev, "cko");
>> > + if (IS_ERR(ssi_clk)) {
>> > + pr_err("Could not get \"cko\" clock \n");
>> > + return PTR_ERR(ssi_clk);
>>
>> I am not sure that adding the clock handling here is the correct approach.
>>
>> The dts you use looks like:
>>
>>    codec: wm8731@1a {
>>       compatible = "wlf,wm8731";
>>       reg = <0x1a>;
>>       clocks = <&clks 173>, <&clks 158>, <&clks 201>, <&clks 200>;
>>       clock-names = "pll4", "imx-ssi.1", "cko", "cko2";
>
>> ,which does not match the current bindings for the wm8731. The wm8731
>> driver could be extended to handle the clocks if needed, instead of
>> handling them via machine driver.
>
> The WM8731 doesn't have anything like that number of clock inputs so
> hanging them off the WM8731 seems very confused.

Yes, exactly. If we need to pass a clock to WM8731 it should be MCLK only.

The pll4, ssi clocks are internal mx6 clocks, so the proposed clock
handling should be reworked.
