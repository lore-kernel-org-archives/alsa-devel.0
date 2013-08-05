From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
Date: Mon, 5 Aug 2013 10:43:35 +0200
Message-ID: <20130805104335.031b0fed@skate>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FECB7A.6010208@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Sebastian, Russell,

On Sun, 04 Aug 2013 23:45:30 +0200, Sebastian Hesselbarth wrote:
> On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:
> > This is only a RFC at present due to the need to test on Kirkwood and
> > fix at least one bug in ASoC core code.
> >
> > I can't say that this stuff is fully tested, because I don't have any
> > Kirkwood platforms, but I do have one Dove platform, which as I've
> > said in the past doesn't run mainline.  I don't run DT on it, so these
> > patches also don't contain anything DT related.
> 
> Added Thomas Petazzoni to Cc, IIRC he has access to a T5325.

Yes, I have access to a Kirkwood t5325, which I'm currently trying to
move to DT. Note that I also received Armada 370 audio hardware last
week, so I'll be working on this as well in the future, this hardware
has both in/out jack plugs as well as SPDIF ones.

So, yes, please Cc me on Kirkwood audio related developments.

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
