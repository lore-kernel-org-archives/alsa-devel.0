From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 01:39:26 -0400
Message-ID: <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FE9265E79
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 07:09:41 +0200 (CEST)
Received: by vcqp16 with SMTP id p16so2178882vcq.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 22:39:27 -0700 (PDT)
In-Reply-To: <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

It depends on the codec connected to the I2S.  We have SSI that works
in mono mode, using a modified driver.  Our codec allows mono playback
by only using the samples on the left channel.

There is the race issue in that playback and record must both match
mono and stereo and ALSA doesn't handle substreams with constraints
that depend on other substreams in a race free manner.

On Mon, Aug 6, 2012 at 7:33 PM, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> On Mon, Aug 6, 2012 at 2:58 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Do you know if mono playback used to work previously in imx-ssi?
>
> I doubt it.  I don't think the I2S standard allows for mono playback,
> so the SSI would need to send the same sample twice, and I don't see
> any support for that feature in the RM.
>
> When I wrote fsl_ssi, I couldn't find any way to get mono playback to work.
>
> BTW, I can't find the original patch in my inbox or the mailing list
> archives.  When was it sent?
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
