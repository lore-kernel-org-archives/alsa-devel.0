From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc
 architecture and ALSA?
Date: Fri, 30 Jun 2006 20:21:44 +0200
Message-ID: <20060630182144.27980@gmx.net>
References: <20060628202753.198630@gmx.net>	<s5hfyhopb0s.wl%tiwai@suse.de>
	<20060629211513.64980@gmx.net> <s5hwtaz9fdr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwtaz9fdr.wl%tiwai@suse.de>
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
Datum: Fri, 30 Jun 2006 11:12:00 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architec=
ture and ALSA?
> =

> What is the type of buffer are you using?  If it's a buffer
> pre-allocated via snd_pcm_lib_preallocate*() with SNDRV_DMA_TYPE_DEV,
> there should be no snd_pcm_mmap_data_nopage call.  For other types,
> there can be.  For example, the patch still doesn't solve the problems
> with drivers using sg-buffer.
> =

I added a debug output and it shows a buffer of SNDRV_DMA_TYPE_DEV_SG type.=
 Well, then I'll hack the kernel to use the normal DMA allocation functions=
 for ALSA instead of the non cache coherent ones and will wait until the AL=
SA core has been adapted for dma_mmap_coherent().

Or what would have to be done to get it working for SG buffers?

Thanks!

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
