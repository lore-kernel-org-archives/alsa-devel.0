From: "Bo Henriksen" <bo.henriksen@nordicid.com>
Subject: RE: snd_pcm_lib_preallocate_pages_for_all
Date: Mon, 5 Jul 2004 11:56:25 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <A6991F0FA073F34C94E97976CAC0323116F8CA@server2.nordicid.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
Ok, I added the coherent_dma_mask =3D 0xffffffffUL in

arch/arm/mach-lh7a40x/arch.c:


static u64 lh7a40x_ac97_dma_mask =3D 0xffffffffUL;

static struct platform_device lh7a40x_ac97_device =3D {
	.name		=3D "lh7a40x-aac",
	.id		=3D 0,
	.dev		=3D {
		.dma_mask =3D &lh7a40x_ac97_dma_mask,
		.coherent_dma_mask =3D 0xffffffffUL,
	},
	.num_resources	=3D ARRAY_SIZE (lh7a40x_ac97_resources),
	.resource	=3D lh7a40x_ac97_resources,
};


It now crashes again. I have tried to preallocate the buffer using
dma_alloc_coherent and free it with dma_free_coherent. This succeeds and
I am using this in other drivers as well. I guess I am missing something
else?

Backtrace:
[<bf025040>] (mark_pages+0x0/0xa8 [snd_page_alloc]) from [<bf0252b8>]
(snd_malloc_d
ev_pages+0x4c/0x54 [snd_page_alloc])
 r4 =3D FFC27000
[<bf02526c>] (snd_malloc_dev_pages+0x0/0x54 [snd_page_alloc]) from
[<bf025438>] (sn
d_dma_alloc_pages+0x64/0xb4 [snd_page_alloc])
 r5 =3D 00000000  r4 =3D C1F00CCC
...
..
.




-
Bo Henriksen


-----Original Message-----
From: Russell King [mailto:rmk+alsa@arm.linux.org.uk]=20
Sent: Monday, July 05, 2004 11:16 AM
To: Bo Henriksen
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] snd_pcm_lib_preallocate_pages_for_all

On Mon, Jul 05, 2004 at 10:03:32AM +0300, Bo Henriksen wrote:
> If I insert "_dev" on the third parameter the function completes with
> following output 6 times:
>=20
>             lh7a40x-aac lh7a40x-aac0: coherent DMA mask is unset

In order to allocate DMA memory, we must know the DMA mask, which
in turn gives us the allowable physical address range for the DMA
allocation.

If you have no restriction, set the coherent DMA mask to ~0.

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
