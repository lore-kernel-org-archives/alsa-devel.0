From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Support for limiting gain
Date: Thu, 6 May 2010 14:21:28 +0300
Message-ID: <201005061421.29408.peter.ujfalusi@nokia.com>
References: <1273131438-2716-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100506094942.GB30491@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 75914246A3
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 13:21:45 +0200 (CEST)
In-Reply-To: <20100506094942.GB30491@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 06 May 2010 12:49:42 ext Mark Brown wrote:
> On Thu, May 06, 2010 at 10:37:18AM +0300, Peter Ujfalusi wrote:
> > Add support for platform dependent gain limiting on the
> > tpa6130a2 (and tpa6140a2) Headset amplifier.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks,

> but we should really provide a generic implementation of this.

Yeah, would be really useful.
What I was wondering about is the cases when you have a codec + amp in a =

system..
If we take for example twl4030 and the tpa6130 connected together:
than we have 4 levels of gain control inside of twl, than one additional le=
vel =

on the tpa side.
What would be nice is to somehow limit the whole chain, but it seams really =

complicated thing because of the big amount of combinations that you can =

actually achieve the same level at the output.

So the gain-chain limitation is really holistic problem IMHO.

But I guess the core could gain support for limiting individual volume cont=
rols.
Some soc-limit-gain("kcontrol name", min, max)
Than it goes through the controls on the card, finds the kcontrol, and fixe=
rs up =

the limits..
So machine drivers can fix up the gain limits on their cards with ease, and=
 no =

additional support from the codec/amp drivers are going to be needed
Hmm, this would be neat!

Sounds  interesting, I might look at this ;)

-- =

P=E9ter
