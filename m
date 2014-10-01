From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
 slave mode
Date: Wed, 1 Oct 2014 15:44:59 -0300
Message-ID: <CAOMZO5A-wd-XcjNdQbz5RGiC6zx+RLGzCBmbUurMvsHqNUTvgw@mail.gmail.com>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
 <20140930192912.GM4273@sirena.org.uk>
 <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
 <20141001182754.GL4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1454E2604CE
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 20:45:00 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id 10so914452lbg.14
 for <alsa-devel@alsa-project.org>; Wed, 01 Oct 2014 11:44:59 -0700 (PDT)
In-Reply-To: <20141001182754.GL4273@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Oct 1, 2014 at 3:27 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 30, 2014 at 09:38:21PM +0200, Michael Trimarchi wrote:
>> On Tue, Sep 30, 2014 at 9:29 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> Any particular register I should monitor?
>
>> > Did you just listen or did you measure the performance?
>
>> >> Sorry, but I guess I did not understand your last question.
>
>> > I'm really not sure how to simplify it...  clearly we're skipping some
>> > configuration here, what does it do - is it purely for generating BCLK
>> > and LRCLK?
>
>> Are you talking about clock_in and sigma-delta? So no  the bclk and lrclk but
>> the clkin of the codec.
>
> I'm sorry but I can't parse what you're saying terribly clearly - please
> bear in mind that I don't know anything about this device, that's one of
> the reasons I'm having to ask questions here.  If the configuration that
> is being skipped is not about generating BCLK and LRCLK then it seems
> like it's going to be wanted in slave mode as well as master.

This patch does not skip any configuration. It just remove the error
case for sgtl5000 in slave mode.

Not sure why the error case was there in the first place, as I think
sgtl5000 slave mode has never been tested before.
