From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 17:39:22 -0700
Message-ID: <CAG5mAdwNj4K3Rk2LVXiN3i3QeS50vU4RUjHXPLg8Af7u1n_Pkg@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <20170403220811.GA21156@Asurada-Nvidia>
 <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
 <20170403235542.GA23047@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DD86B266A7C
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 02:39:44 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id d188so20630772vka.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 17:39:44 -0700 (PDT)
In-Reply-To: <20170403235542.GA23047@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 3, 2017 at 4:55 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Mon, Apr 03, 2017 at 04:31:59PM -0700, Caleb Crome wrote:
>
>> > What's your test case for the alignment?
>>
>> I'm not sure what you are asking.  The test case I'm testing is:
>> connect SSI to AUD4 on wandboard & physically connect TX -> RX.  (as
>> per https://github.com/ccrome/linux-caleb-dev/wiki), then use atest to
>> verify bit-perfection of TX->RX transmission.
>
> So your test case involve both TX and RX. That's why this change
> would impact it. My understanding is: because you can not enable
> TX and RX in the same time from user space but only through two
> separate back-to-back system calls. So when the 2nd system call
> happens (RX for example), the RE bit, supposed to be enabled by
> this 2nd system call, has already been set by the 1st TX system
> call -- there's some random data in the RX FIFO already.
>
>> >> > -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
>> >> > +               regmap_update_bits(regs, CCSR_SSI_SCR,
>> >> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
>> >> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
>> >
>> > However, this patch seems to merely set the RE bit. It shouldn't
>> > affect that test case since the SSIEN bit is still set prior to
>> > the TE bit.
>>
>> Heh, well, this patch causes audio to be utterly broken on
>> multi-channel audio :-/
>
> If possible, could you try to confirm what's the diff between the
> two SCR values of before-regmap and after-regmap in your case?

With this patch (broken audio, includes tx and rx, so 2 updates.
Running atest software)
------------------------
Apr  4 00:35:03 arm kernel: [   33.678451] Before update: 0x00001098
Apr  4 00:35:03 arm kernel: [   33.682339] After update: 0x0000109f
Apr  4 00:35:04 arm kernel: [   33.687196] Before update: 0x0000109f
Apr  4 00:35:04 arm kernel: [   33.690916] After update: 0x0000109f


Before this patch (working audio, running atest software)
------------------------
Apr  4 00:38:24 arm kernel: [   68.261765] Before update: 0x00001098
Apr  4 00:38:24 arm kernel: [   68.265653] After update: 0x0000109d
Apr  4 00:38:24 arm kernel: [   68.270865] Before update: 0x0000109d
Apr  4 00:38:24 arm kernel: [   68.274560] After update: 0x0000109f


Oh what a difference 1 bit makes!

-Caleb
