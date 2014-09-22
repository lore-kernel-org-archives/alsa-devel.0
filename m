From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Mon, 22 Sep 2014 11:08:08 +0200
Message-ID: <CAL8zT=hnCKBHZ2uOK11oeqV8-f8sf44ZmekOK1msUMgnrak3iQ@mail.gmail.com>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
 <20140919175205.GB1736@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B36D26517C
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 11:08:24 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id x69so3520263oia.38
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 02:08:24 -0700 (PDT)
In-Reply-To: <20140919175205.GB1736@Asurada>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

2014-09-19 19:52 GMT+02:00 Nicolin Chen <nicoleotsuka@gmail.com>:
> CCed Mark and Liam.
>
> On Fri, Sep 19, 2014 at 05:18:08PM +0200, Jean-Michel Hautbois wrote:
>> Hi,
>>
>> I am now working on making my audio path working completely.
>> And I get some difficulties to write a DT for my needs.
>> I join a picture which is not the reality but a simplified version of the board.
>>
>> I have a FPGA between my codecs and my i.MX6. This FPGA is responsible
>> of lots of things, and in particular of muxing signals.
>> I can program it in order to get the audio signal I want on the SSI I
>> want (so sgtl5000 can ben on SSI1 or SSI2 or both). This path is not a
>> single codec, but a multiple codec one.
>> So I can have on SSI1 LineIn from sgtl5000 or audio from hdmi (adv7611).
>>
>> I don't know how to write it in DT, regarding audmux for instance, and
>> the sound{} node...
>> And I don't know how to drive all these peripherals (from arecord, I
>> wish I have hw:0,0 is LineIn, hw:0;1 is HDMI, etc.).
>
> This looks like a DPCM (Documentation/sound/alsa/soc/DPCM.txt) to me.
>
> I'm not sure how to write a DT for DPCM either. But it seems that you
> might need a specific machine driver (guessing).
>
> I saw Morimoto-san plans to add DPCM into Simple Card, but not sure
> when they will finish it. Otherwise, you may use Simple Card while
> following their defined DT formats.

Thanks, that's interesting. It looks like a DPCM, but in the other
order (from FE to BE). I probably need a new driver, you are right.
But I still don't know how/what I should declare in the DT...

Thanks,
JM
