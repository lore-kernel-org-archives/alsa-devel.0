From: "Peter Zubaj" <pzad@pobox.sk>
Subject: Re: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Date: Tue, 04 Oct 2005 08:39:36 +0200
Message-ID: <dc7e3d7c111741a991e11a1a39ca9262__36850.3171521754$1128408252$gmane$org@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from paegas.mail-atlas.net (paegas.mail-atlas.net [212.47.13.186])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 284BA1B5
	for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2005 08:40:02 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Jones <davej@redhat.com>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


If ac97_chip=3D1 and ac97 doesn't exists - driver will refuse to load=2E
If ac97_chip=3D2 and ac97 doesn't exists - driver should ignore ac97

But I don't know if this is correct (I am not author of patch and I not=
 tested it)=2E
if message is printed then there is
goto no_ac97; /* FIXME: get rid of ugly gotos=2E=2E */
this will skip ac97 mixer creation (if ac97 is not there this will fail=
 and driver refuses to load)
But I don't know if snd_ac97_bus will fail if there is no ac97 codec (I=
 think - not, and this is not correct), then test should be done on snd=
_ac97_mixer and not on snd_ac97_bus creation=2E

Peter Zubaj

>-----P?vodn? spr?va-----
>Od: Dave Jones [mailto:davej@redhat=2Ecom]
>Odoslan?: 4=2E okt?bra 2005 0:54
>Komu: Peter Zubaj
>K?pia: alsa-devel@alsa-project=2Eorg; James@superbug=2Eco=2Euk; Linux =
Kernel Mailing List; perex@suse=2Ecz
>Predmet: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a=
 error recognising the SB Live Platinum=2E
>
>
>On Mon, Oct 03, 2005 at 08:23:28AM +0200, Peter Zubaj wrote:
>> AFAIK this was fixed in CVS=2E Two cards have same model id (one has=
 AC97, one not)=2E
>>
>> Fix:
>>
>> http://sourceforge=2Enet/mailarchive/forum=2Ephp?thread_id=3D8360485=
&forum_id=3D33141
>>
>
>From the look of that patch, this will just print
>"emu10k1: AC97 is optional on this board Proceeding without ac97 mixer=
s=2E=2E=2E"
>and do nothing about actually making things work for people again,
>or even to suggest what they can do to work around this situation
>when their volume control breaks=2E  At the least this sounds like it
>needs to mention a module parameter to force ac97 support=2E
>
>What actually happens if we set ac97_chip=3D1 on the boards that
>don't have it ? Is it purely a cosmetic thing, showing some
>sliders that do nothing?
>
>Dave
>
>
>
>-------------------------------------------------------
>This SF=2ENet email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussio=
ns,
>and more=2E http://solutions=2Enewsforge=2Ecom/ibmarch=2Etmpl
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists=2Esourceforge=2Enet
>https://lists=2Esourceforge=2Enet/lists/listinfo/alsa-devel



Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
