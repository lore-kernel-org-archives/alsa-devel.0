From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC while
	changing clock
Date: Thu, 2 Apr 2009 10:39:12 +0300
Message-ID: <bd7b27490904020039y4616f611l53a96ef12edcf486@mail.gmail.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id B651224475
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 09:39:13 +0200 (CEST)
Received: by fxm18 with SMTP id 18so388120fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 00:39:13 -0700 (PDT)
In-Reply-To: <20090401121032.GA21294@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Daniel Gl??ckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 1, 2009 at 3:10 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > +       switch (cmd) {
> > +       case SNDRV_PCM_TRIGGER_START:
> > +       case SNDRV_PCM_TRIGGER_RESUME:
> > +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +               aic3x->running[substream->stream] = 1;
> > +               break;
>
> Hrm, does the chip support asymmetric configurations for playback and
> capture?
>
> My two cents: It supports different sampling rates for ADC and DAC but
I don't believe there is practical use or HW doing this. In this setup
there is separate word clock signal on GPIO1 for ADC.

Unfortunately I'm bit off from the actual issue here but I remember some
TI codec had requirement to keep DAC/ADC off while changing the
configuration...


Jarkko
