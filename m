From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 31 May 2016 10:10:11 -0700
Message-ID: <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia> <20160531165358.GH29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A77265EB0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:10:31 +0200 (CEST)
Received: by mail-yw0-f193.google.com with SMTP id j74so19739352ywg.1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 10:10:31 -0700 (PDT)
In-Reply-To: <20160531165358.GH29837@sirena.org.uk>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 31, 2016 at 9:53 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 17, 2016 at 04:43:33PM -0700, Nicolin Chen wrote:
>
> > In this case, would it be more appropriate to create one single DAI
> > with channels_max = 4 over here?
>
> Yes.
>
> > Another question is for its TDM support. This chip outputs 4-channel
> > data on two data output pins (SDOUT1 and SDOUT2) as normal mode; it
> > outputs 4-channel data on one data output pin (SDOUT1) as TDM mode.
> > However, the mode selection for a 4-channel recording should depend
> > on the hardware design: whether the SDOUT2 is connected or not. So
> > I am wondering if there is a common way or existing way to indicate
> > this hardware design. Or just by simply defining a new DT property?
>
> That's a really rare thing to have as an option, most things either do
> TDM or parallel data signals but not both.


Interesting comment.  While I'm sure that's true for the moment,
microphone arrays are changing this quickly.  I fall into the oddball
category that the main chips I use are the TLV320AIC34 and CS53L30,
and both of them can switch between TDM mode or dual I2S mode for 4
channel support.

Since I need to get many channels on board, and SoCs (except for TI)
rarely have enough parallel I2S ports for mic arrays, I opt for TDM
mode often.

If you're using the CS53L30, chances are high that you're building a
mic array.  Then the question is, how many microphones?  up to 4, you
could live with dual I2S if your chip supports it.  Beyond 4, you're
almost certainly talking TDM, unless you have a TI McASP with lots of
inputs, or an XMOS part with multiple I2S interfaces.

Of course, it's highly dependent on what the SoC supports.  I would
say it's just about mandatory for the CS53L30 driver in particular to
be able to switch between TDM or I2S mode based on a DT setting
because of the huge variability of capabilities on the SoC side.   A
TI McBSP could support multiple I2S busses, but a freescale SSI must
use TDM mode.

-Caleb



>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
