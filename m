From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Tue, 20 Sep 2016 08:41:02 +0800
Message-ID: <CAGb2v67dm6UYJhy0ZLkLhp2J3HOotHWUKroEpv31GMvFnL9PVQ@mail.gmail.com>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
 <20160919191543.GU8719@lukather>
 <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 556AF2665C1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 02:41:26 +0200 (CEST)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
 [209.85.214.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id E8A802976A
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 07:45:18 +0800 (CST)
Received: by mail-it0-f41.google.com with SMTP id x192so23076559itb.0
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 17:41:24 -0700 (PDT)
In-Reply-To: <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2016 at 8:32 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Sep 20, 2016 at 3:15 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Mon, Sep 19, 2016 at 10:56:10PM +0800, Chen-Yu Tsai wrote:
>>> On Mon, Sep 19, 2016 at 7:34 PM, Maxime Ripard
>>> <maxime.ripard@free-electrons.com> wrote:
>>> > On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:
>>> >> On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:
>>> >>
>>> >> > That codec is mapped in memory, however, we have a bunch of DAPM
>>> >> > widgets that are mapped in a separate register space, that should
>>> >> > probably be exposed through a syscon (but isn't yet).
>>> >>
>>> >> Why not just represent those as a separate device?
>>> >
>>> > I don't know, this seems to be supplies to muxers, mixers, DACs, the
>>> > amplifier (and the amplifier volume too, even though that's not a
>>> > widget), and it looks really intertwinned, how would you separate
>>> > them?
>>>
>>> I asked Mark the same question a while ago. I was looking at the A31s
>>> codec, which is kind of a cross between A31 and A23.
>>
>> We're working on the A33, that has yet another setup from the A23..
>
> Looks like the "analog control" bits are similar, if not completely
> the same. As described on page 221, the bits are accessed through a
> mapping mechanism in register 0x01f015c0.
>
> So the solution would likely be the same for A31s/A23/A33: a platform
> device/driver for that particular piece of hardware that registers a
> custom regmap and an ASoC component. This would be under the PRCM
> mfd. The main codec would list this (I think it's by name?) under
> it's aux_components.
>
>>> Mark recommended using aux devices. AFAIU the codec would just
>>> register the DAC and ADC widgets, the digital volume control, and
>>> whatever digital bits there are. The analog side would be done in a
>>> asoc component driver, which would register all the analog widgets
>>> and controls. You then tie them together at the card level.
>>
>> Ok. How would that work? Can you setup routes between widgets defined
>> in different components?
>
> Indeed you can. I think that is what the ASoC card is for, to stitch
> up various components. Not sure if you can directly use widgets from
> aux components in the codec component driver though. I guess it depends
> on the probe/binding sequence.
>
>>> AFAIK the digital parts and analog parts are in different power
>>> domains, probably to keep audio bypass working in standby mode.
>>
>> I don't think we have control over those power domains though, do we?
>
> Technically we can control them from external regulators, though
> probably just for suspend. The main part of the SoC would be under
> the SYS domain, while the analog bits, like the R_ block would be
> under the RTC domain.
>
> There might also be a register controlling them in the PRCM block.
> I suppose that's out of the scope of this discussion.
>
>>
>>> As for the A31s, I only got as far as implementing the regmap using
>>> custom read/write callbacks, and part of the register definition.
>>> Unfortunately I saved my work with git stash, which I accidentally
>>> wiped out with git reflog expire...
>>
>> I guess some lessons are meant to be learned the hard way :)
>
> Yes. I lost some work on the A31/A31s codec driver. Mainly
> the A31s parts, and some bits of renaming for the A31. :(

Turns out I hadn't even added the file to git, so it's still there!

    http://wens.tw/sun6i-a31s-codec-analog.c

Looks like I finished the register definitions, but only copied the
widgets/controls from my A31 driver, and haven't fixed them up yet.

Also, my use of SOC_DAPM_DOUBLE requires some work to the DAPM code
to support updates to two registers, rather than two fields in one
register, which I already implemented. This is, and the driver, are
on my TODO list.

Let me know how you would like to proceed, so we don't end up doing
double the work.

Regards
ChenYu
