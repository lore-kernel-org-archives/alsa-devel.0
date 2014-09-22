From: Fabio Estevam <festevam@gmail.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Mon, 22 Sep 2014 00:26:21 -0300
Message-ID: <CAOMZO5Buh9DSD3YSpnkRsczUMj0BAFuOk_uRj1GpLMBgV9N5PQ@mail.gmail.com>
References: <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 6180D265005
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 05:26:22 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id b12so5871722lbj.39
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 20:26:21 -0700 (PDT)
In-Reply-To: <20140918180742.GC6432@Asurada>
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
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 3:07 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> I plan to replace imx-sgtl5000 and imx-wm8962 with it as long as
> people are happy about the new driver. Would you like to help me
> testing it on sgtl5000 side when you have time? Because I only
> have a board with WM8962.

Just tested fsl-asoc-card with sgtl5000 and it worked fine on my imx53-qsb.

These messages are a bit annoying though:

[    1.786201] fsl-asoc-card sound: ASoC: no source widget found for
ASRC-Playback
[    1.796065] fsl-asoc-card sound: ASoC: Failed to add route
ASRC-Playback -> direct -> CPU-Playback
[    1.807571] fsl-asoc-card sound: ASoC: no sink widget found for ASRC-Capture
[    1.817112] fsl-asoc-card sound: ASoC: Failed to add route
CPU-Capture -> direct -> ASRC-Capture
