From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: tda998x: adjust the audio hw parameters from
	EDID
Date: Mon, 27 Jan 2014 20:49:15 +0000
Message-ID: <20140127204915.GC15937@n2100.arm.linux.org.uk>
References: <cover.1390813480.git.moinejf@free.fr> <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr> <20140127204441.GZ11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140127204441.GZ11841@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 27, 2014 at 08:44:41PM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 09:48:54AM +0100, Jean-Francois Moine wrote:
> 
> > +		eld_ver = eld[0] >> 3;
> > +		if (eld_ver != 2 && eld_ver != 31)
> > +			return 0;
> > +
> > +		mnl = eld[4] & 0x1f;
> > +		if (mnl > 16)
> > +			return 0;
> > +
> > +		sad_count = eld[5] >> 4;
> > +		sad = eld + 20 + mnl;
> 
> Can this parsing code be factored out - it (or large parts of it) should
> be usable by other HDMI devices shouldn't it?

Yes, preferably as a generic ALSA helper rather than an ASoC helper -
I don't see any need for this to be ASoC specific (I have a pure ALSA
driver which has very similar code in it.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
