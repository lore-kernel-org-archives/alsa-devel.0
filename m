From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Tue, 21 Oct 2014 16:12:03 -0200
Message-ID: <CAOMZO5A=RSodq=JmjrjHTJSg9QaEx42uu7vAbON=Jk5-Gmiv9Q@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
 <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
 <CAB-pspdvzFX-KjYSC3z3xoDMPvq4g3iFhBG76Y=DGy=YBf5dow@mail.gmail.com>
 <54464C32.8020100@compulab.co.il>
 <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id B05D5260607
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 20:12:04 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id gi9so1590071lab.35
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 11:12:04 -0700 (PDT)
In-Reply-To: <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2014 at 4:04 PM, Jonathan Bennett <jbscience87@gmail.com> wrote:

> I realized something just last night. I was grabbing changes from the devel
> branch of github.com/utilite-computer, thinking that those changes were
> based off the vanilla 3.10 kernel. Those changes are actually based on the
> Freescale 3.10 kernel. I pulled a Freescale patch that is obviously missing:
> "ENGR00276249-1 ARM: imx6q: Add missing baud clock for ssi" I also switched

The baud clock patch is present in 3.18-rc1:

commit 935632e9938e3e286b9c62a7e54d35c428533cc9
Author: Shengjiu Wang <shengjiu.wang@freescale.com>
Date:   Tue Sep 9 17:13:26 2014 +0800

    ARM: dts: imx6qdl: add baud clock and clock-names for ssi

    Baud clock is used for bit clock generation in master mode. Ipg clock
    is peripheral clock and peripheral access clock.

    Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
    Signed-off-by: Shawn Guo <shawn.guo@freescale.c


> back to imx-wm8731.c for the driver. With this setup, the driver registers,
> and speaker-test thinks it plays, however there is no actual sound output. I
> call it progress.

Great progress: some things to check :

1. audmux settings

2. Can you try to run 'alsamixer' and make sure that the volume is not
at the lowest level?
