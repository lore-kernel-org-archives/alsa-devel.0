From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc
 architecture and ALSA?
Date: Thu, 29 Jun 2006 23:15:13 +0200
Message-ID: <20060629211513.64980@gmx.net>
References: <20060628202753.198630@gmx.net> <s5hfyhopb0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyhopb0s.wl%tiwai@suse.de>
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
Cc: linuxppc-dev@ozlabs.org, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


-------- Original-Nachricht --------
Datum: Thu, 29 Jun 2006 11:27:15 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architec=
ture and ALSA?

> At Wed, 28 Jun 2006 22:27:53 +0200,
> Gerhard Pircher wrote:
> > =

> > Hi,
> > =

> > It took a little bit longer to integrate the patch, as I didn't figure
> out  first how to implement the __dma_mmap_coherent() function for PPC
> systems with CONFIG_NOT_COHERENT_CACHE defined. :)
> > =

> > Unfortunately my system still crashes within snd_pcm_mmap_data_nopage() =

> > (sound/core/pcm_native.c), as you can see below. I guess it tries to
> remap =

> > a DMA buffer allocated by the not cache coherent DMA memory allocation =

> > function in arch/ppc/kernel/dma-mapping.c.
> =

> Strange, nopage will be never called if you apply my patch and modify
> to use dma_mmap_coherent().
> =

> =

> Takashi
> =

That's indeed strange! I'm sure that the new code is called by the sound dr=
ivers. Should snd_pcm_mmap_data_nopage() not be used at all anymore, or are=
 there any cases that could still trigger a call of snd_pcm_mmap_data_nopag=
e()?

Gerhard

-- =



Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
