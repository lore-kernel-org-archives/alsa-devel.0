From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ac3 in/out
Date: Wed, 22 Mar 2006 10:41:22 +0100
Message-ID: <1143020483.11724.46.camel@localhost>
References: <1142936836.4759.3.camel@localhost>
	 <1142965025.4532.132.camel@mindpipe>  <s5hbqvzzlss.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j0s/YA4flMQ+ocUrQN+5"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbqvzzlss.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-j0s/YA4flMQ+ocUrQN+5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-21 at 19:37 +0100, Takashi Iwai wrote:

> The SPDIF status bits are generic and rather depending on the data
> than the device you output.  That is, more or less, the SPDIF I/O is
> abstracted.

Are you talking about alsa or spdif itself?

> Regarding AC3, I'm not against to create a new easy-to-use API
> function.  One reason is that AC3 over SPDIF needs conversions of
> packets and also requires the sync work, in addition to the SPDIF
> status bits mentioned in the above.  Such a job can be certainly
> hidden in the system instead of application itself.

Yes, but apparently some hardware is capable of doing the conversion
(the chip apple uses for example: pcm3052, download data sheet for
pcm3052a if you're interested, it's the same chip)

On the other hand, some other chips seem to rely on software to
multiplex the channel status bits into the bitstream which is currently
done by userspace as far as I can tell.

> If we create a new one, we should better think of other compressed
> formats, too...

They're essentially the same to the spdif output though -- just a
non-pcm bitstream.

johannes

--=-j0s/YA4flMQ+ocUrQN+5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCEbwKVg1VMiehFYAQIFXQ//YJZ2lF1NITLYxAvd9cD9JJllQjyYrVui
pYgJ5xF0trET16JV2Ny65Lwi0D9ll+gZ2nwGExdmw8Gein6T5H/Gi+sds7jvR+iB
Dv0zT3GbCGxSUewAr2v96jP/8caE2AEuWv8J9z1qRrVIMFCT1rKoAzbSQKSGR9td
P0X/zIgKGJEeEtF8EMssVdFfM+q6zkphd1MpdXjfQGbFClu+tGqkCBqZYLOAwFLF
eHCXdW5wWh8x7hjc3we3UpCCt7mbMYkEN0EjLri54M+e2FKrEEkjlHOWHVS56mnD
m1VFfXGMvWjSbk4ONqxEQziXngRTgoCVa5l8nZMmStAlvesWmTFjS4KgsWGgl/nt
aVdrvf33C84XWJzGwJpmu3qTQrePgNl1LpIPo61Aam7ObacskT5Ssvh2tL24GEgV
qQKdCrKaiV9rSIfnUCxOyBfwzV3hwlfMTcHxTU/HjLkcRTJhtV8e4nuP4Zj5+Sg8
pUl/10ruGjXhCBYDAlBZLxAxGfXiPxdkNwYQcIBKN13YvVyVwBl38LxeAr90ESmW
mQNT8s3sQGs0XF99Sa9kdMvRv0vVKbZ4/voC9RxE01+beLKVfASggX3BuHMtCdO2
yY445HKOYMiMDNzTK5pDTWwpygW0lGvZVWrT95w8t8P/b2rRuDIIoQM54LvHI7Lu
kxJq9LbG0Zc=
=ET+f
-----END PGP SIGNATURE-----

--=-j0s/YA4flMQ+ocUrQN+5--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
