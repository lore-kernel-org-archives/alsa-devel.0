From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 14:36:05 +0000
Message-ID: <20111121143605.GC22906@opensource.wolfsonmicro.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
	<20111121133836.GA22906@opensource.wolfsonmicro.com>
	<CAPo=G1yZ8mUw=68jFo1S03tdE1yUOkpToCvDBaK02YGaO6nAxg@mail.gmail.com>
	<20111121141948.GB22906@opensource.wolfsonmicro.com>
	<CAPo=G1zg=rgu84rEBigoUnX+LPDdg13LGwzi9XqVMkYYL5fNbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3242D243A2
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:36:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPo=G1zg=rgu84rEBigoUnX+LPDdg13LGwzi9XqVMkYYL5fNbA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2011 at 04:29:54PM +0200, Ujfalusi, Peter wrote:
> On Mon, Nov 21, 2011 at 4:19 PM, Mark Brown

> > Well, that's rather different to what your patch did - I'd expect your
> > patch would also be avoiding setting up all the not connected stuff on
> > Panda. =A0Perhaps what's needed is platform data (which can have a DT
> > representation when that comes) which represents the differences and can
> > include the name to use?

> Ultimately this is the plan, but for 3.2 it would have been too big of a =
change.
> I just happen to had the DMIC support done locally first (will send it so=
on).
> Just reordered the patches, since we feel that 3.2 kernel would
> deserve fix for the
> Panda audio, and obviously the DMIC will go for 3.3.

I'd suggest just jumping straight to platform data now, making it
mandatory and using that to grab the name.  That'll be more ready for
device tree and make life a bit easier for people carrying patches for
further derivatives.  The platform data can then be extended to support
new features and a device tree binding added for it.

Please also fix the word wrapping in whatever mailer you're using.
