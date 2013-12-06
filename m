From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 3/3] ASoC: fsl: imx-wm8962: Add headphone and microphone
 jack plugin/out detection
Date: Fri, 6 Dec 2013 22:52:40 +0800
Message-ID: <20131206145239.GA30024@MrMyself>
References: <cover.1386322845.git.b42378@freescale.com>
 <82d3285b7efe1f98dbc3d9c0a423b2e5e454481f.1386322845.git.b42378@freescale.com>
 <20131206144256.GI29268@sirena.org.uk>
 <20131206143817.GB29975@MrMyself>
 <20131206150319.GJ29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131206150319.GJ29268@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 03:03:19PM +0000, Mark Brown wrote:
> On Fri, Dec 06, 2013 at 10:38:17PM +0800, Nicolin Chen wrote:
> > On Fri, Dec 06, 2013 at 02:42:56PM +0000, Mark Brown wrote:
> 
> > > What's this uevent trying to do and why is it open coded in the driver?
> 
> > That's a requirement from Android team of Freescale. By checking this
> > event they can determine whether current output is speaker or headphone
> > so as to place an icon on the notification area.
> 
> > Sir, if you think this patch is not common enough or non-community style,
> > I can try to cut it down to an common one or entirely drop it.
> 
> This isn't mainline stuff, this is the Android standard switch class.
> Someone should really contribute something to Android which backs it
> onto the back of ALSA jacks.  The mainline equivalent is extcon which
> does have switch class emulation but it's a bit broken in its generation
> of uevents and is also not yet integrated into the ALSA jack stuff.
> 
> The thing to do is ideally integrate extcon with the ALSA jack code and
> update the Android headset observer to work with extcon (or write a
> separate extcon based observer).

Thank you for the detailed explain. It looks more complicated to me with
current code base. I think I should just extract the mainline-style part
so it'll make things easy if there's gonna be some plausible integrations
afterward.

Thank you indeed,
Nicolin Chen


