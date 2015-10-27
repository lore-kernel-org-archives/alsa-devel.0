From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Tue, 27 Oct 2015 09:42:04 -0700
Message-ID: <CAG5mAdxAgyC4YNK80bu=JubPV1CfSiazf9QdWjgVFsgvzdGM8A@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <CAOMZO5DPL6H+Ahz_32Zn8AmDU8muGnVQG_owrGXtDQ1MQXcQ5g@mail.gmail.com>
 <CAG5mAdzxHTqYf0MjogUPYKze9WqKaKXpQvqSvvmSBZJORAQz2Q@mail.gmail.com>
 <CAOMZO5D0Xqpv2LDHfgWf87b8YwaZy424q_9wLTh8bYzoqJwq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0642608BB
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 17:42:23 +0100 (CET)
Received: by wicll6 with SMTP id ll6so168989642wic.1
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 09:42:23 -0700 (PDT)
In-Reply-To: <CAOMZO5D0Xqpv2LDHfgWf87b8YwaZy424q_9wLTh8bYzoqJwq3g@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2015 at 9:10 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Oct 27, 2015 at 2:02 PM, Caleb Crome <caleb@crome.org> wrote:
>
>>> Could you please try it without using the external SDMA firmware?
>>
>> I do need *some* SDMA firmware, correct?  The firmware that I'm using
>> ends up in /lib/firmware/imx/sdma/sdma-imx6q.bin and is md5sum
>> 5d4584134cc4cba62e1be2f382cd6f3a.
>
> SSI can operate with the ROM SDMA firmware.
>
> I would like to know if this issue also happens if you don't pass the
> external firmware and use the internal ROM SDMA firmware instead.

Ah, good to know.  Do I just remove reference in the .dtsi file?
Remove the file from the filesystem?  I'll do both to be doubly sure
:-)


>
> Also, could you try bumping the SSI and SDMA clock rates at the maximum?

Any idea how I do that?  I guess it's in the .dtsi file perhaps?  I'll
poke around.

Thanks so much for your help.  We've got several systems where we'd
really like to use the MX6, but this issues is blocking us.

  -caleb


>
> Adding Shengjiu in case he has any thoughts on getting TDM support in
> the SSI driver.
>
> Regards,
>
> Fabio Estevam
