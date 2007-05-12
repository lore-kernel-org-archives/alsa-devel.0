From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: embedded sound architecture question
Date: Sat, 12 May 2007 18:40:49 +0200
Message-ID: <20070512164049.GJ5690@sygehus.dk>
References: <1178743654.29464.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 80CEB24596
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2007 18:40:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1178743654.29464.1.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim =?iso-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 09, 2007 at 10:47:34PM +0200, Joachim F=F6rster wrote:
[snip]
> So our thoughts were: Integrate the "DMA ring buffer" (which is usually
> somewhere in main memory/RAM) into the AC97 controller. Make ALSA access
> this HW buffer as if it was in main memory.
[snip]
> Mapping this "IO memory" into kernel space should be possible with
> io_remap_page_range(), right?
> I would have to implement the mmap() callback in my driver, to setup the
> given VMA (with the above function), right?
> So, ALSA library/applications will be able to use MMAP mode, which is
> what we want to achieve?

   You can't assume that IO memory can be accessed just as if it was memory
on all architectures. However, in this case it seems that you can make sure
that this is so. I think you should ask on the kernel mailing list what you
should do designing the hardware to make sure it will work.
  =

-- =

Rask Ingemann Lambertsen
