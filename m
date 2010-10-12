From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Pay attention to driver	supplied
	DAI IDs
Date: Tue, 12 Oct 2010 22:33:55 +0100
Message-ID: <20101012213355.GA14320@opensource.wolfsonmicro.com>
References: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTikNLX_0y4Mo3TqsjAecHk8x0ZR-_iz3EL87vkUM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92514103854
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 23:33:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikNLX_0y4Mo3TqsjAecHk8x0ZR-_iz3EL87vkUM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 01:49:52PM -0500, Timur Tabi wrote:
> On Tue, Oct 12, 2010 at 9:57 AM, Mark Brown

> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dai->driver->id)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D dai->driver->=
id;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D i;

> I haven't looked at the code, but doesn't this assume that a DAI ID of
> 0 is invalid?

> I have a suspicion I need to retest my driver to make sure it still works.

This makes no change to the behaviour when the DAI ID is zero.
Previously it would be overwritten with i, with the new code it is still
overwritten with i.  You can specify a DAI ID of zero, but only for the
first DAI.  This is a limitation but avoids having to manually set the
DAI ID in the simple case where they're all numbered sequentially from
zero.
