From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 20:40:02 -0300
Message-ID: <CAOMZO5DzNqKdOHOb_SXQwzEDfD1B4yQVjYxYaHhFHzWNUSE-ig@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id D175A266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 01:40:04 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id s11so6137766oie.1
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 16:40:04 -0700 (PDT)
In-Reply-To: <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

On Mon, Apr 3, 2017 at 8:22 PM, Caleb Crome <caleb@crome.org> wrote:

> With a vanilla kernel, it works perfectly with the pinctrl patch.
> In this case, I ran a cable from the wandboard over to my computer and
> recorded with audacity, using your wile true script above.
> Here you can see that with 4.11-rc5 plus the pinctrl patch, there is
> no channel swapping:
>
> http://imgur.com/od0LoJP

Which wandboard type do you have? mx6solo,dl or quad?

I am using  imx6dl-wandboard.

I am surprised that the channel swap does not happen on your case.
Maybe you need to run the test for an extended period of time?

On my case I usually get the swap in 1/10 of times. Max uses a Toradex
MX6DL Colibri board and sees the swap in 3-4% of the times.
