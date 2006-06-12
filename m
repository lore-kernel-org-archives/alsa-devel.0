From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc
 architecture and ALSA?
Date: Mon, 12 Jun 2006 16:42:54 +0200
Message-ID: <20060612144254.305930@gmx.net>
References: <20060610082223.321730@gmx.net> <s5hbqsyd4uz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqsyd4uz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, benh@kernel.crashing.org
List-Id: alsa-devel@alsa-project.org


> -------- Original-Nachricht --------
> Datum: Mon, 12 Jun 2006 12:51:16 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Betreff: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
> ALSA?
> =

> > Well, implementing the dma_mmap_coherent() function isn't the
> > problem, because it is already implemented for the ARM
> > architecture.
> =

> Actually, I wrote dma_coherent_mmap patch long time ago but it has
> been left forgotten.  The patch attached below seems applicable to
> 2.6.17 tree, but I'm not sure whether it still works properly.
> It's untested on most of architectures.

Thanks, that helps me a lot!

> > But as far as I understand this would require a rewrite of all the
> > ALSA drivers (or at least a rewrite of the ALSA's DMA helper
> > functions).
> =

> Yes.  The change of ALSA side has been also on my tree.  But it was
> still pending since I'm not satisfied with the design yet.
> If you're interested in it, let me know.  I'll post the patch.

Yes, please! Then I can test, if the dma_mmap_coherent() patch works on
my non cache coherent powerpc machine. Do you think the DMA Layer/ALSA patc=
hes will go upstream in one of the next ALSA/Linux kernel versions?

Thanks!

Gerhard

-- =



Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
