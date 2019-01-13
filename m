From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 2/4] ASoC: wm8904: Automatically enable FLL
	when selected
Date: Sun, 13 Jan 2019 13:37:15 +0100
Message-ID: <20190113123715.GA16074@qmqm.qmqm.pl>
References: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
 <5353df1d654eae0bbbf26bc1a1d172e611c385db.1545249666.git.mirq-linux@rere.qmqm.pl>
 <20181221115227.GG16508@imbe.wolfsonmicro.main>
 <20181221115831.GD4996@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D229266885
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2019 13:37:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181221115831.GD4996@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2018 at 11:58:31AM +0000, Mark Brown wrote:
> On Fri, Dec 21, 2018 at 11:52:27AM +0000, Charles Keepax wrote:
> > On Wed, Dec 19, 2018 at 09:11:15PM +0100, Micha=B3 Miros=B3aw wrote:
> =

> > > +		if (!wm8904->fll_fout) {
> > > +			int ret =3D wm8904_set_fll(component, WM8904_FLL_MCLK, WM8904_FLL=
_MCLK,
> > > +						 clk_get_rate(wm8904->mclk), 12288000);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> =

> > What is your thinking on selecting a 12.28MHz clock? Will this
> > not cause issues with say 44.1k playback?
> The driver just shouldn't be making decisions like this at all, either
> generic code or a machine driver should do so.

Sorry, I forgot about the hardcoded frequency. I'll have to rethink this
patch.

Will you take the other three patches as is, or should I resend the series?

Best Regards,
Micha=B3 Miros=B3aw
