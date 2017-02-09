From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for
	zx2967 family
Date: Thu, 9 Feb 2017 16:47:42 -0600
Message-ID: <CAL_JsqJHyNgA2FRMcuZ86OFDJ85NAnx_v9F2LrxwwOxJYLOPCA@mail.gmail.com>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
 <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
 <20170209014807.GO3407@dragon> <20170209120625.lhqcistgyjpy3plq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id AD45026680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 23:48:08 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id B4E9920375
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 22:48:05 +0000 (UTC)
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 452572034E
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 22:48:03 +0000 (UTC)
Received: by mail-yw0-f179.google.com with SMTP id w75so11347873ywg.1
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 14:48:03 -0800 (PST)
In-Reply-To: <20170209120625.lhqcistgyjpy3plq@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, chen.chaokai@zte.com.cn, Baoyou Xie <xie.baoyou@zte.com.cn>, wang.qiang01@zte.com.cn, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 9, 2017 at 6:06 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 09, 2017 at 09:48:09AM +0800, Shawn Guo wrote:
>> On Wed, Feb 08, 2017 at 06:52:07PM -0600, Rob Herring wrote:
>
>> > Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to
>> > argue with Mark about it. If that is not the prefix, then it should at
>> > least have "binding" in the subject.
>
>> +1
>
>> The prefix of sound bindings is quite unique from other subsystems.
>> Looking at the prefix of Documentation/devicetree/bindings/sound/
>> commits, I'm always confused whether it's a pure binding commit
>> or just submitted as part of the driver patch.  I feel that we
>> kinda lose the point of having a prefix.
>
> That's really not what's happening reliably - other subsystems also seem
> to have a bunch of things prefixed for the subsystem and the DT specific
> prefixes are all over the shop, people seem to be making them up at
> random.

I'm getting more picky about the subject and splitting bindings to a
separate patch, but generally only when I have other comments. And
I've had to get some maintainers to stop combining commits as they
apply them.

Maybe get_maintainers.pl could spit out the desired prefix and
checkpatch check it. Evidently, running "git log --oneline" is too
hard.

> If DT binding review were something that reliably and
> consistently happened and didn't affect the subsystem I'd perhaps buy it
> but for run of the mill stuff it seems like getting things reviewed in
> the subsystem is more important.

I review everything that gets sent to the DT list unless maintainers
apply it first. I'll still comment afterwards if there's anything
significant (or I missed that it was applied :)).

Rob
