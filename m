From: Rene Rebe <rene.rebe@gmx.net>
Subject: powerpc and snd-powermac mixer
Date: Sun, 11 May 2003 12:47:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030511.124756.468706978.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

the powermac driver has some problems on my (three weeks old) iBook
(800Mhz).

PCM access is useable (and I hear the sound very quietly) - but the
mixer is not doing anything noticeable with the hardware (i.e. no
volume change).

The in-kernel oss driver does not even load - only the updated one
from the -benh kernel tree is loadable and does indeed work correctly.

So I guess the als-driver needs some cut'n paste of register tables or
so.

- Ren=E9

--  =

Ren=E9 Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.d=
e/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
