From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 22:56:10 +0800
Message-ID: <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9CE2666FE
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 16:56:35 +0200 (CEST)
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
 [209.85.223.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 3D88723494
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 22:00:27 +0800 (CST)
Received: by mail-io0-f176.google.com with SMTP id m186so93657785ioa.2
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 07:56:32 -0700 (PDT)
In-Reply-To: <20160919113415.GM8719@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Mon, Sep 19, 2016 at 7:34 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:
>> On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:
>>
>> > That codec is mapped in memory, however, we have a bunch of DAPM
>> > widgets that are mapped in a separate register space, that should
>> > probably be exposed through a syscon (but isn't yet).
>>
>> Why not just represent those as a separate device?
>
> I don't know, this seems to be supplies to muxers, mixers, DACs, the
> amplifier (and the amplifier volume too, even though that's not a
> widget), and it looks really intertwinned, how would you separate
> them?

I asked Mark the same question a while ago. I was looking at the A31s
codec, which is kind of a cross between A31 and A23. Mark recommended
using aux devices. AFAIU the codec would just register the DAC and
ADC widgets, the digital volume control, and whatever digital bits
there are. The analog side would be done in a asoc component driver,
which would register all the analog widgets and controls. You then
tie them together at the card level.

AFAIK the digital parts and analog parts are in different power domains,
probably to keep audio bypass working in standby mode.

As for the A31s, I only got as far as implementing the regmap using
custom read/write callbacks, and part of the register definition.
Unfortunately I saved my work with git stash, which I accidentally
wiped out with git reflog expire...

Regards
ChenYu

>> > To make things worse, the register in the syscon behaves as a mailbox,
>> > where you actually have to set in that register the address you want
>> > to modify and the new value, in a single write. This also seem to
>> > deviate from the usual DAPM access pattern.
>>
>> This is totally fine, just use events for the things that aren't simple
>> register updates - there are a large number of examples in the tree,
>> simple register access is totally optional.
>
> Ah, yes, that seems to be just right. Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
