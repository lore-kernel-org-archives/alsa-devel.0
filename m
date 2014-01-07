From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 5/5] ASoC: mc13783: Add devicetree support
Date: Tue, 7 Jan 2014 11:00:53 +0400
Message-ID: <20140107110053.1e353a58ac661c7c64860fe3@mail.ru>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
 <1388907515-18975-5-git-send-email-shc_work@mail.ru>
 <20140106132841.GV31886@sirena.org.uk>
 <1389015981.978548720@f170.i.mail.ru>
 <20140106151227.GW31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp23.mail.ru (smtp23.mail.ru [94.100.176.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 11751261676
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 08:01:01 +0100 (CET)
In-Reply-To: <20140106151227.GW31886@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On Mon, 6 Jan 2014 15:12:27 +0000
Mark Brown <broonie@kernel.org> wrote:
> > > This is an incompatible binding change; deprecating is fine but it
> > > should still be supported.  Is there not a default set of port
> > > assignments that can be used?
> 
> > "fsl,mc13xxx-uses-codec" is not used anywhere and even if it was used,
> > it would not usable, because we can not get to the codec phandle.
> > So I think this change is safe.
> 
> Why would it prevent anything getting the CODEC phandle and what do you
> mean by that anyway?  A lack of in tree users shouldn't mean anything,
> we need to be compatible with DTs shipped with boards.
> 
> > > > +	pdev->dev.of_node = of_find_node_by_name(pdev->dev.parent->of_node,
> > > > +						 "codec");
> 
> > > You shouldn't be messing with the of_node in the struct device, this is
> > > managed by the driver model and setting one that wasn't added in sync
> > > with everything else can introduce breakage.
> 
> > Hmm, probably you are right, but I cannot imagine other way to set of_node...
> > Have you other ideas?
> 
> The whole problem is that you're trying to set of_node.  Don't do that.

I try to explain my vision of this:

With DT and simple audio codec we should have description like this:
	sound {
		compatible = "simple-audio-card";
		...
		simple-audio-card,cpu {
			sound-dai = <&ssi1>;
			...
		};
		simple-audio-card,codec {
			sound-dai = <&mc13783codec>;
			...
		};
	};
So, we need codec phandle.
The codec is probed by MC13XXX MFD core, and codec pdev not contain
compatible string, but we should associate our codec with DT.
if ASoC core wants to use codec it will try to find it by of_node.
Maybe my opinion is wrong, fixme.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
