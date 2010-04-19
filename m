From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 19 Apr 2010 09:15:49 -0600
Message-ID: <p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
References: <1271686144.3208.305.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2384024786
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 17:16:11 +0200 (CEST)
Received: by vws15 with SMTP id 15so2056759vws.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 08:16:09 -0700 (PDT)
In-Reply-To: <1271686144.3208.305.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Timur Tabi <timur@freescale.com>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 19, 2010 at 8:09 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> Currently ASoC is designed around a single CODEC and a single platform
> DMA engine in every sound card instance. This is fine for most embedded
> devices but current smart phone and STB designs are starting to outgrow
> this architecture.
>
> I'm currently working on adding ASoC support for multiple different
> CODECs and Platforms (DMA, Audio Engines) into a single sound card
> instance. This work will allow ASoC to support N CODECs and N platforms
> per sound card instance and also allow better integration of audio
> components from GSM MODEMs, BT, FM transceivers and PCM DSPs.
>
> I've now split each ASoC component (i.e. DMA, CODEC, DAI) into driver
> and device structures. This now means each ASoC component is a regular
> kernel device and can have private device data and platform_data. It
> should also provide better support for open firmware and flattened
> device tree.
>
> I've CC'ed folks on this mail who have either contributed or maintain
> ASoC architecture code. Please have a look at your architecture and test
> if you can. I only have access to OMAP and pxa3xx hardware and as such
> have only tested the changes on these two architectures only. I'd
> appreciated anyone else testing on the other architectures too.
>
> The changes are all purely mechanical to component registration and
> component private data only. However, some architectures (txx9, imx,
> s3c) required some extra effort to use the device model as they had (to
> varying degrees) coupled their DMA and DAI code more tightly. The fsl
> platform also required extra work around the open firmware interface.
> Grant/Timur do we still need soc-of-simple now that all components are
> regular devices ?
>
> The code is in my topic/multi-component branch here :-
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

Hi Liam,

This is definitely a step in the right direction.  All of the OF ASoC
stuff is definitely a hack to work around the lack of separate devices
& drivers in the ASoC subsystem.  I'll take a look through, but some
more information would help a lot.  Can you write a description of the
device model that you're using for the ASoC linkage?  Here are some of
the questions I have:

- What bus type is used for codec and platform (dai) device
registrations?  (okay, 'platform' is really confusing here because of
the dual meaning with Linux driver core.  I'm going to use 'dai' in
this email instead from now on.  It might not be the best term, but it
at least it isn't ambiguous.)
- What does the device hierarchy look like (what is the parent device
for each of the codec and devices)?
- Related to that, how are things like i2c codecs handled?  By rights,
there will be an i2c device registered under the i2c bus device for
the control interface.  How will this relate to the ASoC model?
- None of the drivers appear to include struct device_driver; which
tells me that they don't use the driver core binding model.  How do
drivers get bound to devices?  Why does the ASoC code create an driver
interface instead of using the core code (what does the core code not
provide)?
- What code is responsible for performing the codec and dai driver
registrations?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
