From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC MPC5xxx PSC AC97 audio driver
Date: Fri, 9 Sep 2011 08:28:44 +0200
Message-ID: <20110909082844.3dbf0e72@archvile>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F916103AD6
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 08:28:34 +0200 (CEST)
In-Reply-To: <20110908184441.GD16989@siel.b>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: torbenh <torbenh@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Torben,

On Thu, 8 Sep 2011 20:44:41 +0200
torbenh <torbenh@gmx.de> wrote:

> On Thu, Sep 08, 2011 at 04:32:31PM +0200, David Jander wrote:
> > 
> > Dear Jon,
> > 
> > On Thu, 8 Sep 2011 06:55:56 -0400
> > "jonsmirl@gmail.com" <jonsmirl@gmail.com> wrote:
> > 
> > > On Thu, Sep 8, 2011 at 6:45 AM, David Jander <david.jander@protonic.nl>
> > > wrote:
> > > >
> > > > Dear Jon,
> > > >
> > > > Thanks for replying so quickly.
> > > >
> > > > On Thu, 8 Sep 2011 06:28:02 -0400
> > > > "jonsmirl@gmail.com" <jonsmirl@gmail.com> wrote:
> > > >> On Thu, Sep 8, 2011 at 6:16 AM, David Jander
> > > >> <david.jander@protonic.nl> wrote:
> > > >> >
> > > >> > Dear Jon,
> > > >>
> > > >> Here's the device tree...
> > > >> http://git.digispeaker.com/?p=digispeaker-kernel.git;a=blob;f=arch/powerpc/boot/dts/dspeak01.dts;h=50cc247b4da0eb2bc4deb315b1b5348af87e5979;hb=9166a4a4141ab7c8d7a7b97fa5b726e11a8d0ca4
> > > >
> > > > Thanks... but it uses I2S, not AC97 :-(
> > > > It doesn't have a "fsl,mpc5200-pcm" node either, btw.
> > > > In the case of I2C, this makes some sense, since the Codec is usually
> > > > connected to two different interfaces at the same time (I2S and I2C for
> > > > control), so you have 2 device nodes. AC97 OTOH has just one
> > > > interface. It is connected to a AC97 bus (a PSC in this case). AFAICS
> > > > there are no OF bindings yet for an AC97 bus, so the actual codec
> > > > doesn't figure and thus still needs this ugly fabric driver thing.
> > > 
> > > Try the pcm030 device tree...
> > > 
> > > http://git.digispeaker.com/?p=digispeaker-kernel.git;a=blob;f=arch/powerpc/boot/dts/pcm030.dts;h=30bfdc04c6dfacd88a9c6e325e873d75a633bdf5;hb=HEAD
> > 
> > I had also looked at that one.... still no "fsl,mpc5200-pcm" node. I would
> > not expect one either, given the way the fabric driver works. But what is
> > the reason for this OF compatible string then?
> > 
> > Most important question: Does the mpc5200_dma.c/mpc5200_psc_ac97.c
> > combination in current mainline still work correctly?
> > 
> > I am unable (by inference) to say for sure that mpc5200_hpcd_probe() will
> > always be called before psc_ac97_of_probe(). If it is not, the latter will
> > OOPS.
> > In fact, when I try to mimic the same on a MPC5121e, it does get called in
> > the opposite order! My theory is that this order may have changed in recent
> > versions of kernel/ALSA, and that since that moment this driver has been
> > broken and nobody noticed yet. I need to know, because I intend to enhance
> > mpc5200_psc_ac97.c, to also support MPC512x, but this is not working the
> > way it is written now. If I knew for sure that mpc5200 still works this
> > way, I would need to find a bug in my code. In the other case, I'd just go
> > and fix the driver for MPC5200 also, but I have no hardware to try it out
> > myself.
> 
> i am working on mpc5125 right now.

My respects. Nobody I know dared to touch that alien yet (at least not for
use with linux) ;-)
May I ask how you solved the nasty incompatibilities in the PSC (and
other) drivers? I couldn't come up with an acceptable solution....

> i dont have hardware with an audio codec yet, but will get that soon.
> I already have extended drivers/dma/mpc512x_dma.c to support slave dma
> to the sdhc. (only got it working today, so its still a bit sketchy)

Great. I was planning to add slave DMA myself for audio, but decided to first
try out a simple work_queue to see if I can produce some sound.
Do you mind sharing your DMA patch? I'd really like to have a look at it.

> i am also interested in a proper fabric example.

What do you think about creating device-tree bindings for that? I tend to like
the idea of not needing any special board support code besides the DT, and the
audio fabric driver part is the only obstacle for that.

Best regards,

-- 
David Jander
Protonic Holland.
