From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Remove Alchemy OSS drivers?
Date: Fri, 20 May 2011 08:12:57 +0100
Message-ID: <20110520071256.GA23902@linux-mips.org>
References: <20110519231911.GB10628@linux-mips.org>
	<s5hoc2x7tsr.wl%tiwai@suse.de>
	<BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 090C9103AAD
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 09:12:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Namhyung Kim <namhyung@gmail.com>, lkml@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 08:51:37AM +0200, Manuel Lauss wrote:

> On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Fri, 20 May 2011 00:19:12 +0100,
> > Ralf Baechle wrote:
> >>
> >> OSS has very little if any useful life in it left for MIPS, at least f=
rom
> >> my perspective. =A0So I propose to remove the Au1550 driver - there is=
 an
> >> ALSA replacement for it available.
> >
> > Even two variants available: one in ASoC driver and one in old ALSA
> > driver.
> =

> The current ASoC code can replace sound/oss/au1550_ac97.c,
> but sound/mips/au1x00.c is for different (earlier) chips.  I wrote an ASoC
> variant of this a long time ago, but I can't test it on real hardware.

My immediate interest is to kill off sounds/oss/ on MIPS because
sound/oss/soundcard.c is fairly ISA centric and does not build for some
some MIPS systems with only half-arsed ISA support, that is no DMA support.

Manuel, I got a DBAu1250 board here and maybe I can find a DBAu1500
Zinfandel board under some dusty hardware pile; would that be suitable for
testing your work?

  Ralf
