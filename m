From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Mon, 11 Aug 2014 08:24:54 -0400
Message-ID: <CAKON4OyK08dPEHCpUTWdv_Z8Q0Fyh_4-Uf5orNR9PeBdq=Jiig@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
 <CAKON4Ozth8VHa3OK+HNU7Lp29MqCbvVD7mh3v6KM7ejF0CGDpA@mail.gmail.com>
 <CAKON4Oz0VbZ=j-0YqkN=9C+yXbWycc8TvsdTCNH0UzuvrcXs_w@mail.gmail.com>
 <20140811072751.GB12969@MrMyself>
 <CAKON4OxubPg8+75Fhp8MBjgJGRN0C5dACpHX2OxeOQzbc1XmYw@mail.gmail.com>
 <20140811114928.GA13617@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F8DA265457
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 14:24:54 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id hz20so6479025lab.8
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 05:24:54 -0700 (PDT)
In-Reply-To: <20140811114928.GA13617@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, zengzm.kernel@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2014 at 7:49 AM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:
> On Mon, Aug 11, 2014 at 07:56:12AM -0400, jonsmirl@gmail.com wrote:
>> > It looks like the problem is that Simple Card also configures cpu-dai
>> > via set_sysclk() with direction SND_SOC_CLOCK_IN while it fetches the
>> > sysclk rate not from MCLK source but from 'sound-dai' -- cpu-dai node
>> > itself, when the binding for sound-dai doesn't have clock or frequency
>> > assignment, although this fetching works out for codec-dai side.
>> >
>> > In your case, Simple Card sets both sides of dai with different sysclk
>> > rates, and meanwhile the sysclk rate for cpu-dai is incorrect.
>> >
>> > Is it true?
>>
>> Yes, that is what is going on.  Trying to use sgtl5000 with
>> simple-audio exposed that issue. Without removing that 'else' clause
>> there is no way to tell simple-audio just to leave the cpu-dai alone.
>
> This issue remained in Simple Card shall be fixed. But I don't think
> it's a good idea to _just_ remove that 'else' since its does work for
> codec-dai. Instead, I think you might need to check the set_sysclk()
> of cpu-dai driver as I mentioned in the last mail:

The code in that else case is just getting lucky. It is picking up the
rate from the first input clock defined in the DTS for the device.

For my cpu-dai the first input clock is the apb bus clock which is
running at 80Mhz. In this case the default did the totally wrong
thing. On my CPU you really can set the sysclk to 80Mhz and that way
exceeds the input spec for sgtl5000. I just happen to notice because I
had some debug code telling what clock rates were being set.

For the sgtl5000 the first input clock happens to be the link back to the codec.

So maybe the fix is to only run that else case for for the codec-dai?


>
>  The sysclk direction is only valid when indicating MCLK as sysclk
>  (FSYNC or BCLK shall follow CBS_CFS/CBM_CFM setting).So basically
>  if cpu-dai driver gets sysclk configuration with SND_SOC_CLOCK_IN,
>  shouldn't it just set the internal direction for MCLK's PAD and
>  return the call directly? (I'm guessing there also might be some
>  tiny work for your cpu-dai driver to enhance the validation part.)
>
> Best regards,
> Nicolin



-- 
Jon Smirl
jonsmirl@gmail.com
