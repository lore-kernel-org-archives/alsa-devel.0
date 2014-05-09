From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Fri, 09 May 2014 18:01:43 +0200
Message-ID: <536CFBE7.3070805@metafoo.de>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-032.synserver.de
 [212.40.185.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 58900261A64
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 18:01:47 +0200 (CEST)
In-Reply-To: <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/09/2014 05:34 PM, Fabio Estevam wrote:
> On Fri, May 9, 2014 at 12:17 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> The changes in the patch should mostly be transparent. But what changed is
>> how error reporting is handled. If there is a error reading/writing a
>> register in the kcontrol callbacks that error is passed on to userspace
>> whereas previously it was silently ignored.
>>
>> There is also the possibility that there is a bug somewhere in the patch
>> causing this.
>>
>> Does the board otherwise work fine?
>>
>> I actually have the board here, if you tell me which devictree/defconfig I
>> can use with an upstream kernel I can give things a try.
>
> make imx_v6_v7_defconfig
> make imx6q-sabresd.dtb

I just tried 907fe36a2c, e2c330b9b5 and next/master. I get the same behavior 
with all 3, no errors when loading a state file and audio out on the 
headphones works. I disabled DRM though since it deadlocked the system, 
maybe that makes a difference.

Is it possible that the error is coming from the I2C driver? Can you build 
the I2C driver with #define DEBUG and take a look at the output?

- Lars
