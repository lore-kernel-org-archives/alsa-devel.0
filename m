From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if not mclk_in_use
Date: Fri, 05 Feb 2016 13:23:20 +0000
Message-ID: <yw1x60y3i94n.fsf@unicorn.mansr.com>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
	<20160205131944.GB12311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160205131944.GB12311@sirena.org.uk> (Mark Brown's message of
	"Fri, 5 Feb 2016 13:19:44 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Wed, Feb 03, 2016 at 01:18:20PM +0000, Mans Rullgard wrote:
>> If something else, typically a codec, has enabled mclk, the BUSY
>> bit may be set when hw_params() is called without this being an
>> error.  This check thus causes intermittent failures to configure
>> the sound device when used in such a manner.  Fix this by making
>> the test conditional on !saif->mclk_in_use.
>
> Please remember to CC the maintainers for the driver when sending
> patches. =20

I CCd everybody scripts/get_maintainers.pl suggested.  How am I suppose=
d
to know who the maintainers are if they're not listed in MAINTAINERS?

--=20
M=E5ns Rullg=E5rd
