From: "Bo Henriksen" <bo.henriksen@nordicid.com>
Subject: RE: DMA problems! Writing ALSA AC97 driver for the LH7A404
Date: Mon, 5 Jul 2004 12:06:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <A6991F0FA073F34C94E97976CAC0323116F8CD@server2.nordicid.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?Q?Javier_=C1lvarez?= <jalvarez@securitasdirect.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: Javier =C1lvarez [mailto:jalvarez@securitasdirect.es]=20
Sent: Monday, July 05, 2004 11:59 AM
To: Bo Henriksen; linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: DMA problems! Writing ALSA AC97 driver for the LH7A404

If  I have got good memory, ALSA drivers are very complex on ARM
architecture due to the handle of the cache memory.

What about the obsolete but well-working OSS model?

Regards.


Well,=20

I need the ALSA model to implement low latency for use with VoIP.
IMHO it shouldn't be more complex than for other architectures. All my =
DMA controller need is the physical address to the noncached/continues =
memory pool where it can store/fetch data.=20

Here is today's conversation with Russel King about this issue.

On Mon, Jul 05, 2004 at 10:03:32AM +0300, Bo Henriksen wrote:
> If I insert "_dev" on the third parameter the function completes with=20
> following output 6 times:
>=20
>             lh7a40x-aac lh7a40x-aac0: coherent DMA mask is unset

In order to allocate DMA memory, we must know the DMA mask, which in =
turn gives us the allowable physical address range for the DMA =
allocation.

If you have no restriction, set the coherent DMA mask to ~0.

--
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

I then set the coherent_dma_mask =3D ~0. Next answer ->

On Mon, Jul 05, 2004 at 11:56:25AM +0300, Bo Henriksen wrote:
> It now crashes again. I have tried to preallocate the buffer using=20
> dma_alloc_coherent and free it with dma_free_coherent. This succeeds=20
> and I am using this in other drivers as well. I guess I am missing=20
> something else?

Yes, ALSA assumes that memory returned from dma_alloc_coherent is kernel =
direct mapped memory.  ALSA is wrong in that assumption.
Hopefully ALSA people can help you further.

--
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core



Please help my :)


Best regards,=20
=20
Bo Henriksen




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
