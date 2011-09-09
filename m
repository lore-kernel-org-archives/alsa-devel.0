From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC MPC5xxx PSC AC97 audio driver
Date: Fri, 9 Sep 2011 08:48:54 +0200
Message-ID: <20110909084854.614a47a5@archvile>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile>
	<CAKON4OyUAmdk7eVSakpP6PGw4DCshU9eucRwkLufx2WzKggjhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id A0D56103ACB
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 08:48:44 +0200 (CEST)
In-Reply-To: <CAKON4OyUAmdk7eVSakpP6PGw4DCshU9eucRwkLufx2WzKggjhA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Sep 2011 13:52:06 -0400
"jonsmirl@gmail.com" <jonsmirl@gmail.com> wrote:

> On Thu, Sep 8, 2011 at 10:32 AM, David Jander <david.jander@protonic.nl>
> wrote:
> >
> > Dear Jon,
> >
> > On Thu, 8 Sep 2011 06:55:56 -0400
> > "jonsmirl@gmail.com" <jonsmirl@gmail.com> wrote:
> >
> >> On Thu, Sep 8, 2011 at 6:45 AM, David Jander <david.jander@protonic.nl>
> >> wrote:
> >> >
> >> > Dear Jon,
> >> >
> >> > Thanks for replying so quickly.
> >> >
> >> > On Thu, 8 Sep 2011 06:28:02 -0400
> >> > "jonsmirl@gmail.com" <jonsmirl@gmail.com> wrote:
> >> >> On Thu, Sep 8, 2011 at 6:16 AM, David Jander <david.jander@protonic.nl>
> >> >> wrote:
> >> >> >
> >> >> > Dear Jon,
> >> >>
> >> >> Here's the device tree...
> >> >> http://git.digispeaker.com/?p=digispeaker-kernel.git;a=blob;f=arch/powerpc/boot/dts/dspeak01.dts;h=50cc247b4da0eb2bc4deb315b1b5348af87e5979;hb=9166a4a4141ab7c8d7a7b97fa5b726e11a8d0ca4
> >> >
> >> > Thanks... but it uses I2S, not AC97 :-(
> >> > It doesn't have a "fsl,mpc5200-pcm" node either, btw.
> >> > In the case of I2C, this makes some sense, since the Codec is usually
> >> > connected to two different interfaces at the same time (I2S and I2C for
> >> > control), so you have 2 device nodes. AC97 OTOH has just one interface.
> >> > It is connected to a AC97 bus (a PSC in this case). AFAICS there are no
> >> > OF bindings yet for an AC97 bus, so the actual codec doesn't figure and
> >> > thus still needs this ugly fabric driver thing.
> >>
> >> Try the pcm030 device tree...
> >>
> >> http://git.digispeaker.com/?p=digispeaker-kernel.git;a=blob;f=arch/powerpc/boot/dts/pcm030.dts;h=30bfdc04c6dfacd88a9c6e325e873d75a633bdf5;hb=HEAD
> >
> > I had also looked at that one.... still no "fsl,mpc5200-pcm" node. I would
> > not expect one either, given the way the fabric driver works. But what is
> > the reason for this OF compatible string then?
> >
> > Most important question: Does the mpc5200_dma.c/mpc5200_psc_ac97.c
> > combination in current mainline still work correctly?
> 
> I haven't booted a mpc5200 in over a year so I don't know. Grant
> probably has better info. He'll answer this thread sooner or later.

Ok. Thanks.

I have been investigating the history os soc-core.c. Specially how the probe
function evolved, and one thing I can tell from it, is that the probe order
always has been:

1. machine
2. cpu_dai
3. codec
4. platform

Only in recent versions, there seems to be a possibility to change the order
by using the "probe_order" field in "struct snd_soc_dai_driver". No idea how
the specify it yet...

Nevertheless, the mpc5200 audio driver seems to rely on the platform part
being probed _before_ the cpu_dai part. Does it work by shear luck or am I
missing something?

Best regards,

-- 
David Jander
Protonic Holland.
