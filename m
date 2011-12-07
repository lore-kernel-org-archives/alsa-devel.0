From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Wed, 7 Dec 2011 13:23:23 +0000
Message-ID: <20111207132322.GA18837@opensource.wolfsonmicro.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>
	<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
	<CANKRQnhbBNDjQw5MQGexZAEboC0oHB5QS1LfHo6pDeoeDSwByw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A361243AF
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 14:24:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnhbBNDjQw5MQGexZAEboC0oHB5QS1LfHo6pDeoeDSwByw@mail.gmail.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2011 at 01:42:45PM +0900, Tomoya MORINAGA wrote:
> 2011/12/6 Tomoya MORINAGA <tomoya.rohm@gmail.com>:

You're complaining that you didn't a response within 24 hours!  This is
really not reasonable for something which is essentially volunteer
driven project.

> > You said "Use the dai_fmt field in the dai_link to set this."
> > However, both dai_fmt and dai_link are already implemented like below.
> > static struct snd_soc_dai_link ioh_i2s_dai =3D {

> > static struct snd_soc_card ioh_i2s_card =3D {
> > ...
> > =A0 =A0 =A0 =A0.dai_link =A0 =A0 =A0 =3D &ioh_i2s_dai,
> > ...
> > };

> > So, I can't understand your saying.

> Could you give me your answer ?

Your above code has no references to dai_fmt.  Have you looked at the
dai_fmt field in the dai_link structure or at the existing examples of
its use?
