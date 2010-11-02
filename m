From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: Add initial WM8958 support
Date: Tue, 2 Nov 2010 09:13:49 -0400
Message-ID: <20101102131348.GB21476@opensource.wolfsonmicro.com>
References: <1288635611-25560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTikzEdgUqVU0N=y7Vy+fnqKyskVp6p0zMpdYmenk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3973510380E
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 14:13:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikzEdgUqVU0N=y7Vy+fnqKyskVp6p0zMpdYmenk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thiago Farina <tfransosi@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 01, 2010 at 11:52:04PM -0200, Thiago Farina wrote:
> On Mon, Nov 1, 2010 at 4:20 PM, Mark Brown

> > +enum wm8994_type {
> > + =A0 =A0 =A0 WM8994 =3D 0,
> > + =A0 =A0 =A0 WM8958 =3D 1,
> > +};

> Don't need to initialize with =3D 0 and with =3D 1. This is done by defau=
lt.

There is no runtime cost to doing this and so where the values are
important I feel the clarity from documenting the actual values is
useful, it saves anyone having to figure out if they are what is
expected.
