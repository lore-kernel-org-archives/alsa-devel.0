From: Rene Rebe <rene.rebe@gmx.net>
Subject: Re: powerpc and snd-powermac mixer
Date: Mon, 12 May 2003 15:58:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030512.155840.719889309.rene.rebe@gmx.net>
References: <20030511.124756.468706978.rene.rebe@gmx.net>
	<s5hn0hsuxtu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0hsuxtu.wl@alsa2.suse.de>
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

On: Mon, 12 May 2003 14:57:33 +0200,
    Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 11 May 2003 12:47:56 +0200 (CEST),
> Rene Rebe wrote:
> > =

> > Hi,
> > =

> > the powermac driver has some problems on my (three weeks old) iBook=

> > (800Mhz).
> > =

> > PCM access is useable (and I hear the sound very quietly) - but the=

> > mixer is not doing anything noticeable with the hardware (i.e. no
> > volume change).
>  =

> could you tell me the chip model (shown in /proc/asound/cards)?
> there are many different models supported by this driver.

Hm. The strange thing is that it works now ... But in the effort of
completing our PowerPC port I already updated to the -benh10 kernel
and from alsa-driver-0.9.2 to 0.9.3a ... so some change made it work
...

0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                     PowerMac Snapper (Dev 28) Sub-frame 0

When the mixer doesn't work again I'll contact you ...

Looking forward to meet you at the Linux Tag in Karlsruhe again ;-)

> > The in-kernel oss driver does not even load - only the updated one
> > from the -benh kernel tree is loadable and does indeed work correct=
ly.
> =

> ok, at least there is something to refer...
> =

> =

> thanks,
> =

> Takashi

- Ren=E9
    / ROCK Linux stable release maintainer

--  =

Ren=E9 Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://gsmp.tfh-berlin.de/gsmp http://www.rocklinux.org
http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
