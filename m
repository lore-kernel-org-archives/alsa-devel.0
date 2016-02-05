From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if not mclk_in_use
Date: Fri, 05 Feb 2016 13:43:22 +0000
Message-ID: <yw1xwpqjgtmt.fsf@unicorn.mansr.com>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
	<20160205131944.GB12311@sirena.org.uk>
	<yw1x60y3i94n.fsf@unicorn.mansr.com>
	<20160205133712.GC12311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160205133712.GC12311@sirena.org.uk> (Mark Brown's message of
	"Fri, 5 Feb 2016 13:37:12 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Fri, Feb 05, 2016 at 01:23:20PM +0000, M=E5ns Rullg=E5rd wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > Please remember to CC the maintainers for the driver when sending
>> > patches. =20
>
>> I CCd everybody scripts/get_maintainers.pl suggested.  How am I supp=
osed
>> to know who the maintainers are if they're not listed in MAINTAINERS=
?
>
> By looking at people working on the driver in git and the authors lis=
ted
> in the driver (get_maintainer --git will do most of this for you, tho=
ugh
> you do have to think about false positives).  As previously advised t=
his
> is not something that can be fully automated, you need to think about
> who you are sending things to and why.

Most files have been touched by many people.  I thought the entire poin=
t
of the MAINTAINERS file was to remove the guesswork from choosing where
to send patches.  Apparently sound/ has rules of its own.

--=20
M=E5ns Rullg=E5rd
