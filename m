From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Wed, 1 Apr 2009 18:34:45 +0100
Message-ID: <20090401173445.GF21294@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk> <49D374CD.20401@emlix.com>
	<20090401152421.GC21294@sirena.org.uk> <49D3947F.3010805@emlix.com>
	<20090401164847.GE21294@sirena.org.uk> <49D3A15F.7070105@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 74E37103820
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 19:34:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D3A15F.7070105@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl?ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 01, 2009 at 07:16:15PM +0200, Daniel Gl?ckner wrote:
> On 04/01/2009 06:48 PM, Mark Brown wrote:

> > JOINT_DUPLEX is just a hint to the application about how the card will

> Then there needs to be a way for codecs and machines to force this bit if
> the PCM driver didn't set it.

Ideally, yes, but it's not really important if it's set or not since
it's the constraints that actually matter.  Like I say, it's just a
hint.

> IMHO joint duplex is a hack that works only by chance.
> Constraints that depend on the configuration of the first stream on open of the
> second stream are no longer valid when the first stream is closed.
> It is also not possible to add constraints when the first stream has been opened
> but not yet configured.

There's several existing drivers which do this (the fsl-ssi driver or
the wm8903 spring to mind) - I'm planning to provide a helper for it
shortly since it's quite a common requirement.  There are some races
there but they are fairly narrow and the ALSA APIs don't allow them to
be closed down; error handling should still be done.
