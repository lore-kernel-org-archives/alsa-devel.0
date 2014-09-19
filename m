From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Fri, 19 Sep 2014 10:52:06 -0700
Message-ID: <20140919175205.GB1736@Asurada>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id BA8A9265172
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 19:52:10 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id hz1so539207pad.25
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 10:52:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

CCed Mark and Liam.

On Fri, Sep 19, 2014 at 05:18:08PM +0200, Jean-Michel Hautbois wrote:
> Hi,
> 
> I am now working on making my audio path working completely.
> And I get some difficulties to write a DT for my needs.
> I join a picture which is not the reality but a simplified version of the board.
> 
> I have a FPGA between my codecs and my i.MX6. This FPGA is responsible
> of lots of things, and in particular of muxing signals.
> I can program it in order to get the audio signal I want on the SSI I
> want (so sgtl5000 can ben on SSI1 or SSI2 or both). This path is not a
> single codec, but a multiple codec one.
> So I can have on SSI1 LineIn from sgtl5000 or audio from hdmi (adv7611).
> 
> I don't know how to write it in DT, regarding audmux for instance, and
> the sound{} node...
> And I don't know how to drive all these peripherals (from arecord, I
> wish I have hw:0,0 is LineIn, hw:0;1 is HDMI, etc.).

This looks like a DPCM (Documentation/sound/alsa/soc/DPCM.txt) to me.

I'm not sure how to write a DT for DPCM either. But it seems that you
might need a specific machine driver (guessing).

I saw Morimoto-san plans to add DPCM into Simple Card, but not sure
when they will finish it. Otherwise, you may use Simple Card while
following their defined DT formats.

Nicolin
