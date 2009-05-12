From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 09:29:55 +0530
Message-ID: <2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D4324611
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 06:00:16 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so2551890ana.2
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 21:00:15 -0700 (PDT)
In-Reply-To: <dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <getarunks@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, "Aarti Dewan (Corp HR),
	Noida" <Aarti.Dewan@hcl.in>
List-Id: alsa-devel@alsa-project.org

Moreover, I am hearing a sine-tonish kind of sound, always in the beginning.
It lasts only for less than a sec but is very prominent and occurs always.

Has anyone noticed this too?

Regards,
Anuj

On Mon, May 11, 2009 at 6:27 PM, Arun KS <getarunks@gmail.com> wrote:

> On Mon, May 11, 2009 at 4:44 PM, Peter Ujfalusi
> <peter.ujfalusi@nokia.com> wrote:
> > Hello,
> >
> > The following patch should fix (or at least makes it less intrusive) the
> 'tuck'
> > phenomena on observed on the twl4030 Headset outputs when the codec is
> going
> > to standby mode.
> >
> > I have debugged this with the scope and if we are not waiting RAMP_DELAY
> time,
> > the VMID is cut before it reaching 0, which generates the 'tuck'.
> >
> > Note that I have not removed the control for the RAMP_DELAY
> configuration, the
> > code will use that to calculate the needed delay (also the sysfreq is
> needed,
> > which also stored).
> > However I do think that one should not touch the RAMP_DELAY...
> >
> > It would be nice to hear from you guys, if it solves/softens the 'tuck'.
>
> 'Tuck' still present on omap3evm board.
>
> >
> > ---
> > Peter Ujfalusi (1):
> >  ASoC: TWL4030: Wait RAMP_DELAY on headsetl_event: POST_PMD
> >
> >  sound/soc/codecs/twl4030.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Best Regards,
Anuj Aggarwal
