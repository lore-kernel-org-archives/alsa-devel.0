From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 18:04:41 +0100
Message-ID: <20120510170441.GE12727@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<CABb+yY2ivTKqg9q6hB1OLzBHo7zCWO74As048o-jacKkx0wD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3602E10BAD0
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 19:04:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABb+yY2ivTKqg9q6hB1OLzBHo7zCWO74As048o-jacKkx0wD1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 10:30:44PM +0530, Jassi Brar wrote:
> On Thu, May 10, 2012 at 9:36 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > The question is - what would cause ALSA to hammer away at the buffer
> > like that - checking it every 16 or 8 DMA bytes transferred? =A0I'm also
> > seeing around 75% system CPU time, which really isn't good.
> >
> > The above was captured while aplay was running, with no apparant audio
> > corruption.
> >
> > Any ideas?
> >
> I believe it's because the pcm's write tries to keep the data in ring
> buffer filled
> upto brim and keeps polling the dma position till it keeps reporting
> some progress.
> =

> I think if you could avoid that behavior if your driver carefully
> keeps negligible
> progresses to itself and report only considerable ones. Basically, core w=
ould
> stop polling and wait on queue when two pointer calls return same value i=
.e no
> progress.

You _could_ but why should drivers work around silly behaviour in the
ALSA core?
