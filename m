From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Wed, 5 Apr 2017 10:43:44 -0300
Message-ID: <CAOMZO5BRh4DHVZKM1Kb6hwnJsH+v17RzxFS7G-QLyMGuuWcRAg@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
 <CAOMZO5DzNqKdOHOb_SXQwzEDfD1B4yQVjYxYaHhFHzWNUSE-ig@mail.gmail.com>
 <CAG5mAdzKuWHMQLiDOzabdp9Xxs1z5sYNdkt17kGge-4wop5nFA@mail.gmail.com>
 <e5c3ee01-e807-e74d-f90f-2c207a74e539@invoxia.com>
 <CAOMZO5Ahe7fYxZH28J7B0wDFmRc1J2aJv6qoktHoKo15s4b9uQ@mail.gmail.com>
 <CAOMZO5A8AExfYR+JuBaLAQsRNUs3Og13PGv9ychD7j4rwMhx2A@mail.gmail.com>
 <9c489e80-2579-3739-1343-2b3587667680@invoxia.com>
 <CAOMZO5CaqpELX0pPS0g7_bi0eEokhtxJtavphssnUi8iJ15XLQ@mail.gmail.com>
 <2c31e502-4171-7426-1c24-c258a4d02c55@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 05848266BA4
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 15:43:45 +0200 (CEST)
Received: by mail-oi0-f46.google.com with SMTP id r203so15395812oib.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 06:43:45 -0700 (PDT)
In-Reply-To: <2c31e502-4171-7426-1c24-c258a4d02c55@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 5, 2017 at 4:54 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:

> Good catch. All of this makes sense.
> The SSI surely detect a glitch at the start of the stream and takes it for a
> sync frame, but not followed by the expected 32x2 bits.
> It also explain why Caleb and I are not able to reproduce, since we connect
> SSI internally using the audmux, leaving no place for such glitch.
>
> If only Max can validate this fix...

Yes, that would be nice.

> But what is strange is that writing TE and EN at once also avoid the
> issue... or it means the issue was really timing dependent.
>
> Do you know which one is started first ?
> - fsl_ssi_trigger(SNDRV_PCM_TRIGGER_START)
> or
> - stgl5000 PCM bus being turned on
>
> We can expect that stgl5000 turns the PCM clocks first, and then SSI is
> turned on. Otherwise anything can happened when the codec starts its
> clocking.

Correct: stgl5000 turns the PCM clocks first.

> Maybe we should look at the Fsync state when idle, and see how it behave
> during the startup. Depending of pull-up /down-down configuration of the
> pads, it may be leaved in a undefined state with undefined transitions when
> stgl5000 turns its output on...
>
> Another way to definitively fix this kind of issue is to use
> SND_SOC_DAIFMT_CBS_CFS
> - the codec generates the N*8*64 kHz or 44.1*64 kHz precise bitclock
> (something which is not flexible for the SSI who is connected to a fix PLL
> output clock)
> - but the SSI generate the Sync, leaving no place for wrong detection.
> Unfortunately, stgl5000 doesn't seem to support this mode.

Correct. I plan to submitting a sgtl5000 patch that allows setting the
lrclk pad strength via device tree.

Will wait for Max to confirm if this solves the swap channel issue on
his board as well.

I would like to thank you and Caleb for the tests.

Glad to see your atest application working as expected with the SSI driver :-)
