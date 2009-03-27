From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2/2] alsa: s6105 IP camera machine	specific
	ASoC code
Date: Fri, 27 Mar 2009 16:39:03 +0000
Message-ID: <20090327163902.GC6752@sirena.org.uk>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>
	<1238074574-24734-2-git-send-email-dg@emlix.com>
	<20090326142640.GE3771@sirena.org.uk> <49CCFFD1.7000705@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B158103881
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:39:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49CCFFD1.7000705@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2009 at 05:33:21PM +0100, Daniel Gl=F6ckner wrote:
> On 03/26/2009 03:26 PM, Mark Brown wrote:

> > Are you sure you're applying the correct configuration to the correct
> > DAI here - S6105_CODEC_CLOCK is a CPU define, not a CODEC define?

> In this case S6105 was referring to the S6105 reference design. It's a ma=
chine
> define at the top of the file.

Hrm, OK.

> >> +static int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec, cha=
r *name,

> > This shouldn't be in a driver!

> I know, but it was made static in soc-dapm.c when it was renamed to
> snd_soc_dapm_set_pin.

In cases like this you should submit a patch adding the API back to the
core rather than adding a generic API as local code in your machine
driver.
