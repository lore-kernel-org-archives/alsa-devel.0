From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Mon, 11 Aug 2014 07:56:12 -0400
Message-ID: <CAKON4OxubPg8+75Fhp8MBjgJGRN0C5dACpHX2OxeOQzbc1XmYw@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
 <CAKON4Ozth8VHa3OK+HNU7Lp29MqCbvVD7mh3v6KM7ejF0CGDpA@mail.gmail.com>
 <CAKON4Oz0VbZ=j-0YqkN=9C+yXbWycc8TvsdTCNH0UzuvrcXs_w@mail.gmail.com>
 <20140811072751.GB12969@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 216EF26518A
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 13:56:13 +0200 (CEST)
Received: by mail-lb0-f176.google.com with SMTP id u10so5669210lbd.7
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 04:56:12 -0700 (PDT)
In-Reply-To: <20140811072751.GB12969@MrMyself>
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

On Mon, Aug 11, 2014 at 3:28 AM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:
> On Sun, Aug 10, 2014 at 10:10:51PM -0400, jonsmirl@gmail.com wrote:
>> As I debug further I am getting a better understanding of the problem.
>> This is my simple-audio binding.
>>
>> sound {
>> compatible = "simple-audio-card";
>> simple-audio-card,format = "i2s";
>>
>> simple-audio-card,cpu {
>> sound-dai = <&iis0>;
>> };
>>
>> simple-audio-card,codec {
>> clocks = <&iis0>;
>> sound-dai = <&sgtl5000>;
>> };
>> };
>>
>> I'm having trouble with the simple-audio-card,cpu node, not the
>> simple-audio-card,codec node.  As simple-audio is currently
>> implemented when simple-audio-card,cpu is processed it will pick up my
>> 80Mhz apb clock and set it as sysclk.
>
> It looks like the problem is that Simple Card also configures cpu-dai
> via set_sysclk() with direction SND_SOC_CLOCK_IN while it fetches the
> sysclk rate not from MCLK source but from 'sound-dai' -- cpu-dai node
> itself, when the binding for sound-dai doesn't have clock or frequency
> assignment, although this fetching works out for codec-dai side.
>
> In your case, Simple Card sets both sides of dai with different sysclk
> rates, and meanwhile the sysclk rate for cpu-dai is incorrect.
>
> Is it true?

Yes, that is what is going on.  Trying to use sgtl5000 with
simple-audio exposed that issue. Without removing that 'else' clause
there is no way to tell simple-audio just to leave the cpu-dai alone.

>
>> After spending all day trying to fix that else clause, I'm coming to
>> the conclusion that the else clause simply shouldn't be there at all.
>> I just hit this because I had code checking for bogus values in
>> setsysclk.
>
> Well, even if there's a problem at this point for Simple Card, I'm
> still curious for the reason why setting cpu-dai with an incorrect
> rate but direction SND_SOC_CLOCK_IN would result some breaks here.
>
> The sysclk direction is only valid when indicating MCLK as sysclk
> (FSYNC or BCLK shall follow CBS_CFS/CBM_CFM setting).So basically
> if cpu-dai driver gets sysclk configuration with SND_SOC_CLOCK_IN,
> shouldn't it just set the internal direction for MCLK's PAD and
> return the call directly? (I'm guessing there also might be some
> tiny work for your cpu-dai driver to enhance the validation part.)
>
> Best regards,
> Nicolin



-- 
Jon Smirl
jonsmirl@gmail.com
