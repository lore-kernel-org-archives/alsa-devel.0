From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 01/10] ASoC: Rename snd_soc_card to
	snd_soc_machine
Date: Fri, 21 Nov 2008 15:02:23 +0000
Message-ID: <20081121150217.GE31866@sirena.org.uk>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hod09ku1p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 87FDD244E5
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 16:02:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hod09ku1p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 21, 2008 at 03:55:30PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > @@ -9,7 +9,7 @@ the audio subsystem with the kernel as a platform device and is represented by
> >  the following struct:-
> >  
> >  /* SoC machine */
> > -struct snd_soc_machine {
> > +struct snd_soc_card {_

> Typo?

Yes, pushed a fixed version just now.
