From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dB gain
Date: Mon, 29 May 2006 20:27:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605292017280.11164@tm8103-a.perex-int.cz>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<447B0A19.2050408@superbug.co.uk> <s5hy7wkddyf.wl%tiwai@suse.de>
	<447B308E.2050502@superbug.co.uk> <s5hirnod7l2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463789724-4756273-1148927270=:11164"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2904159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 20:27:51 +0200 (MEST)
In-Reply-To: <s5hirnod7l2.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463789724-4756273-1148927270=:11164
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 May 2006, Takashi Iwai wrote:

> For example, in order to get a numid, you have to extract three
> levels down.  The version + length, the type + length, again type +
> length, then finally you reach to numid value.  Each extraction
> requires a function call to convert from a byte-stream to an integer
> and a check of the length.  I feel it's a bit too much abstraction.

Note that such complex things reminds me - why we can't transfer all=20
"extra" data in one big binary array and let alsa-lib parse them?
Doing selection at the driver level seems too complex to me. TLV=20
structure seems good. It might also reduce the driver code, because only=20
a pointer to TLV data might be passed to control.c. We can create two=20
ioctls:

1) for "global" not element specific data

=09u32 data_length
=09.... TLV data ....
=09=09u32 tlv_item_length
=09=09u32 tlv_item_type

2) for element specific data

=09u32 data_length
=09u32 numid
=09.... TLV data ....
=09=09u32 tlv_item_length
=09=09u32 tlv_item_type

Also, I would handle all data in the host endian type to save parsing=20
time.

=09=09=09=09=09Jaroslav

-----
InterNet p=F8es WIFI bez limitu dat, =C8esk=E9 Bud=ECjovice a okol=ED
Pokryt=E9 lokality: =A9indlovy Dvory, Mokr=E9, Litv=EDnovice, Pek=E1rensk=
=E1, Srubec
Perex @ InterNet <internet@perex.cz>
---1463789724-4756273-1148927270=:11164
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


---1463789724-4756273-1148927270=:11164
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

---1463789724-4756273-1148927270=:11164--
