From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v2 1/2] ASoC: Remove 'const' from the device_node
 pointers
Date: Mon, 10 Nov 2014 20:12:54 +0100
Message-ID: <20141110201254.65674552@armhf>
References: <cover.1415562021.git.moinejf@free.fr>
	<d5d74f6993e9f2392008a27a2938c58d47dc8062.1415562021.git.moinejf@free.fr>
	<20141110190332.GG3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110190332.GG3815@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Nov 2014 19:03:32 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sun, Nov 09, 2014 at 08:33:45PM +0100, Jean-Francois Moine wrote:
> > From Russell King:
> > of_node_put() modifies the struct device_node contents.  Therefore,
> > of_node_put() definitely not treating the data pointed to as read-o=
nly,
> > and therefore it is completely inappropriate for it to be marked "c=
onst".
>=20
> Did Russell write this patch (in which case it's missing a signoff an=
d
> his e-mail address above) or are you trying to say "Russell King
> said..."?

Sorry, that was "Russell said ...".
Do you want I resubmit the patch?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
