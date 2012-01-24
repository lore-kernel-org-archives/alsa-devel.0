From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Hang up at .prepare( )
Date: Tue, 24 Jan 2012 11:42:10 +0000
Message-ID: <20120124114210.GB14888@opensource.wolfsonmicro.com>
References: <CANKRQngqJaAq7ucg3VzCMs+-KFXTSuJG=uq4d0kQ95gEMFfB4w@mail.gmail.com>
	<20120124105528.GA20519@opensource.wolfsonmicro.com>
	<CANKRQnibHChSVEOvsDuKTXcnDkx5KQAMOxfheocTJt+ar0CgPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2ECC424571
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 12:42:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnibHChSVEOvsDuKTXcnDkx5KQAMOxfheocTJt+ar0CgPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 24, 2012 at 08:30:17PM +0900, Tomoya MORINAGA wrote:
> 2012/1/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > What efforts have you made to debug this yourself? =A0Clearly this is n=
ot
> > happening for other people, perhaps it is related to something you have
> > in your drivers - have you addressed the issues raised with them?

> I said previously, "our ASoC drivers" not others.
> Of course, I understand current upstreamed drivers don't have this issue.
> I just asked "If someone faced the same issue when debugging, let me
> know about it."

That's not answering my question - I'm asking you what steps you've
taken to progress, to explain the analysis you've done so far.  For
example, what is the blocked thread blocked on - what is it waiting for
and why has that thing happened?

If you have not addressed the review issues with your driver then take a
look at those, perhaps the problem has already been identified through
code review.
