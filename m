From: "Stephen Warren" <SWarren@nvidia.com>
Subject: Bug in acore/memalloc.patch in alsa-driver-1.0.7?
Date: Fri, 19 Nov 2004 09:05:43 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F816@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've started reading all the *.patch files in the alsa-driver-1.0.7
package to see which patches actually change the code on 2.6.9. I found
something odd in acore/memalloc.patch.

Part of the patch is this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 0)
+#define VALID_DMA_MASK(dev)    (dev)->dma_mask
......
+#endif
+
 static void *snd_dma_hack_alloc_coherent(struct device *dev, size_t
size,
                                         dma_addr_t *dma_handle, int
flags)
 {
        void *ret;
        u64 dma_mask, coherent_dma_mask;
=20
-       if (dev =3D=3D NULL || !dev->dma_mask)
+       if (dev =3D=3D NULL || VALID_DMA_MASK(dev))
                return dma_alloc_coherent(dev, size, dma_handle, flags);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


This changes the code from

-       if (dev =3D=3D NULL || !dev->dma_mask)

to:

-       if (dev =3D=3D NULL || (dev)->dma_mask)

Once the macro is expanded for kernels 2.6.0 or later.

This seems to be a bug, since the test is inverted.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
