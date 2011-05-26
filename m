From: Caleb Crome <caleb@crome.org>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Thu, 26 May 2011 14:23:03 -0700
Message-ID: <BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4CC812412E
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 23:23:06 +0200 (CEST)
Received: by pvf33 with SMTP id 33so505835pvf.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 14:23:03 -0700 (PDT)
In-Reply-To: <20110511175021.GB22798@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
   You previously indicated that I can instantiate multiple tlv320aic33
drivers.  Can you please give me a clue how to do that?  I've been staring
at this for days, and I still don't really get how it's supposed to be done.


I tried adding the I2C devices, and it does get to the probe functions.
 However, when it comes to adding the mixer controls (SND_SOC_XXXX), it
fails because there are already controls with those names, like "Right PGA
Mixer" etc.  The alsa layer doesn't seem to allow multiple registrations of
the same control.  How do I give each instantiation a unique identifier?
 Since the tlv320aic33 has about 80 controls, I'm going to end up with over
600 controls in alsamixer.

Are there any examples in the world that show multiple codecs in the same
sound card that I can get a clue from?

Again, any help would be most welcome.

Thanks,
  -Caleb



On Wed, May 11, 2011 at 10:50 AM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, May 11, 2011 at 10:31:15AM -0700, Caleb Crome wrote:
>
> > 1)  Simply instantiate multiple TLV320IAC33 codec drivers, as the AIC33
> > driver is already written.
>
> Yes.
>
> >     This seems like it won't work because I'd end up with multiple
> > user-space 'cards', yet I want the card to appear as a single 16-channel
> > sound card.  Also, when you start one PCM interface for one codec, they
>
> No, you shouldn't.  You'll end up with a single card.
>
> > would all start automatically, which I imagine the linux system wouldn't
> > get.  Also, the PCM interface needs to be configured differently for each
> > codec (the TDM offset must be 0, 16, 32, 48, etc. bits).
>
> The TDM stuff should be configured with the existing TDM API (you may
> need to implement this in the CODEC driver).
>
