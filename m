From: Rene Rebe <rene.rebe@gmx.net>
Subject: Re: powerpc and snd-powermac mixer
Date: Wed, 14 May 2003 11:40:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030514.114043.511706764.rene.rebe@gmx.net>
References: <s5hn0hsuxtu.wl@alsa2.suse.de>
	<20030512.155840.719889309.rene.rebe@gmx.net>
	<20030514.113127.135501265.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030514.113127.135501265.rene.rebe@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On: Wed, 14 May 2003 11:31:27 +0200 (CEST),
    Rene Rebe <rene.rebe@gmx.net> wrote:
> Hi,
> =

> On: Mon, 12 May 2003 15:58:40 +0200 (CEST),
>     Rene Rebe <rene.rebe@gmx.net> wrote:
> =

> > Hm. The strange thing is that it works now ... But in the effort of=

> > completing our PowerPC port I already updated to the -benh10 kernel=

> > and from alsa-driver-0.9.2 to 0.9.3a ... so some change made it wor=
k
> > ...
> =

> Hm. After a reboot into the same kernel it doesn't work anymore - so
> this seems to be quite random when the mixer is funtional :-(
> =

> I'll try to find a reproduceable way for working sound ...

Loading and unloading the dmasound_pmac driver first helps. After that
procedure the snd-powermac can control the mixer correctly.

One other strange thing: When the dmasound_pmac driver was used for
"initilizing" the mixer is not muted (as in the other ALSA PCI
drivers) and the mixer values are quite random (output in the speakers
...) although the alsamixer shows they are all muted and 0. The mixer
hardware gets the value shown in alsamixer on the first value change.

> > 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
> >                      PowerMac Snapper (Dev 28) Sub-frame 0
> > =

> > When the mixer doesn't work again I'll contact you ...
> > =

> > Looking forward to meet you at the Linux Tag in Karlsruhe again ;-)=


Sincerely,
  Ren=E9 Rebe
    - ROCK Linux stable release maintainer

--  =

Ren=E9 Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.org/people/rene       =

http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
