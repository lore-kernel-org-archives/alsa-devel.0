From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
 slave mode
Date: Tue, 30 Sep 2014 21:38:21 +0200
Message-ID: <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
 <20140930192912.GM4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1A7260442
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 21:38:22 +0200 (CEST)
Received: by mail-wg0-f45.google.com with SMTP id m15so3168824wgh.16
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 12:38:21 -0700 (PDT)
In-Reply-To: <20140930192912.GM4273@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Tue, Sep 30, 2014 at 9:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 29, 2014 at 10:17:57AM -0300, Fabio Estevam wrote:
>> On Mon, Sep 22, 2014 at 10:54 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Are you sure that the configuration that results is valid?  Typically
>> > the requirements for MCLK to other clock ratios are very similar for
>> > master and slave modes, it's just that it tends to be a lot more obvious
>> > when things go wrong in master mode since directly visible clocks tend
>> > to go wrong as opposed to performance problems.  Are the dividers that
>> > we can't get configuration for purely for generating BCLK/LRCLK in
>> > master mode or are they for other things?
>
>> Tested sgtl5000 slave mode with different sampling rates and it plays well.
>
>> Any particular register I should monitor?
>
> Did you just listen or did you measure the performance?
>
>> Sorry, but I guess I did not understand your last question.
>
> I'm really not sure how to simplify it...  clearly we're skipping some
> configuration here, what does it do - is it purely for generating BCLK
> and LRCLK?

Are you talking about clock_in and sigma-delta? So no  the bclk and lrclk but
the clkin of the codec.

Michael

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
