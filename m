From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to
	kirkwood-i2s
Date: Mon, 5 Aug 2013 09:53:34 +0100
Message-ID: <20130805085333.GO23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805104335.031b0fed@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 23574261B24
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 10:53:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130805104335.031b0fed@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 05, 2013 at 10:43:35AM +0200, Thomas Petazzoni wrote:
> Sebastian, Russell,
> 
> On Sun, 04 Aug 2013 23:45:30 +0200, Sebastian Hesselbarth wrote:
> > On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:
> > > This is only a RFC at present due to the need to test on Kirkwood and
> > > fix at least one bug in ASoC core code.
> > >
> > > I can't say that this stuff is fully tested, because I don't have any
> > > Kirkwood platforms, but I do have one Dove platform, which as I've
> > > said in the past doesn't run mainline.  I don't run DT on it, so these
> > > patches also don't contain anything DT related.
> > 
> > Added Thomas Petazzoni to Cc, IIRC he has access to a T5325.
> 
> Yes, I have access to a Kirkwood t5325, which I'm currently trying to
> move to DT. Note that I also received Armada 370 audio hardware last
> week, so I'll be working on this as well in the future, this hardware
> has both in/out jack plugs as well as SPDIF ones.
> 
> So, yes, please Cc me on Kirkwood audio related developments.

Can you pick the patches off the mailing list(s)?  Re-sending them is
just going to be noise for everyone.
