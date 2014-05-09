From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Fri, 09 May 2014 17:17:03 +0200
Message-ID: <536CF16F.8010807@metafoo.de>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-032.synserver.de
 [212.40.185.32])
 by alsa0.perex.cz (Postfix) with ESMTP id E449F261A5A
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 17:17:08 +0200 (CEST)
In-Reply-To: <20140509150034.GH2870@dragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/09/2014 05:00 PM, Shawn Guo wrote:
> Hi Lars,
>
> On Tue, Apr 22, 2014 at 01:23:14PM +0200, Lars-Peter Clausen wrote:
>> After moving the IO layer inside ASoC to the component level we can now easily
>> move the standard control helpers also to the component level. This allows to
>> reuse the same standard helper control implementations for other components.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> I'm running next-20140508 on imx6q-sabresd board and seeing repeated
> 'amixer: Mixer hw:0 load error: Device or resource busy' message with
> Debian wheezy rootfs.  The git bisect points me to this patch.
>
> == message output before this patch ==
>
> [....] Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "wm8962-audio" "" "" "" ""
> Hardware is initialized using a generic method
> [ ok tl: set_control:1328: failed to obtain info for control #117 (No such file or directory)'...done.
>
> == message output after this patch ==
>
> [....] Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "wm8962-audio" "" "" "" ""
> Hardware is initialized using a generic method
> alsactl: set_control:1328: failed to obtain info for control #117 (No such file or directory)'...amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> amixer: Mixer hw:0 load error: Device or resource busy
> done.
>
> Why do we start seeing such error message with your patch?  Is this
> a problem of rootfs or kernel?

The changes in the patch should mostly be transparent. But what changed is 
how error reporting is handled. If there is a error reading/writing a 
register in the kcontrol callbacks that error is passed on to userspace 
whereas previously it was silently ignored.

There is also the possibility that there is a bug somewhere in the patch 
causing this.

Does the board otherwise work fine?

I actually have the board here, if you tell me which devictree/defconfig I 
can use with an upstream kernel I can give things a try.

- Lars
