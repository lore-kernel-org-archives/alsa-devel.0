From: Andre Batista de Oliveira <abo@netvisao.pt>
Subject: Re: card_id() in initval.h
Date: 28 Dec 2003 13:45:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <x77k0hqco1.fsf@dorian.home.org>
References: <x7k74nuwwq.fsf@dorian.home.org>
	<Pine.LNX.4.58.0312270951580.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312270951580.8959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> On Tue, 23 Dec 2003, Andre Batista de Oliveira wrote:
> > When I try to specify the ID string for the card
> > (snd-sgalaxy=3D1,0,Waverider,0x220,0x530,10,3),
> > the kernel just reboots immediately, even before printing anything!
>=20
> Thanks for the bug report. Could you try this "official" patch?
>=20
> RCS file: /cvsroot/alsa/alsa-kernel/include/initval.h,v
> retrieving revision 1.17
> diff -u -r1.17 initval.h
> --- initval.h	30 Oct 2003 14:21:07 -0000	1.17
> +++ initval.h	27 Dec 2003 09:00:51 -0000

Ok, it works!
I tried it in a 2.6.0 kernel, which has the exact same get_id()
function as the ALSA CVS 1.17 revision of initval.h.

You should also add #include <linux/bootmem.h> to avoid compilation
warning: implicit declaration of function `alloc_bootmem'.

Now I was thinking if there shouldn't be a free_bootmem()
somewhere after the card id string parameter has been copied to the
id field of the struct _snd_card ?!?
Maybe right after strlcpy(card->id, xid, sizeof(card->id)), in the
snd_card_new() function of core/init.c ?!?
Or perhaps it should be the drivers' responsibility to do a
free_bootmem() after calling snd_card_new() ?!?
Then again, this is not a big memory leak to worry about...

--=20
Andr=E9 Batista de Oliveira


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
