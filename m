From: "David E. Storey" <dave@tamos.net>
Subject: problems with hdsp
Date: 11 May 2003 18:25:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052691952.419.76.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Folks,

I'm running alsa-driver v0.9.3a under Linux v2.4.21-rc2 with kernel
preemption, low-latency, acpi-20030424, capabilities, soundcore-2.4.20
and rtc-2.4.16 patches. (Jack still has NUMEROUS xruns under virtually
no load whatsoever using the intel8x0 driver... while alsaplayer and
xmms-alsa hardly skip a beat while pounding the CPU with kernel
compiles, but since this isn't the jack mailing list...)

I tried compiling the hdsp driver and it tells me:

(root@scorpius root)# modprobe snd-hdsp
/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved
symbol snd_hwdep_new
/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o failed
/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
snd-hdsp failed

it seems simple to fix, but my knowledge of alsa isn't intimate... yet.
It was compiled via:

./configure --with-pcmcia=kernel --with-cards=intel8x0,hdsp

I've kind-of gotten it to work in the past, but I had to rev down the
firmware, which I'm really hoping I won't have to do soon. (Since the
latest windoze drivers required upgraded firmware and that's been the
only way I can do any kind of multi-track recording... due to jack's
issues, ardour is fairly useless to me for anything other than
mixdowns.)

If this issue has already been hashed out, I apologize. The web archives
of this list start about five days ago.

Also, I've read in numerous places that it's a really BAD idea to "bond"
multiple sound cards together using one's .asoundrc file since they're
not synchronized. Is that still the case if, say, I synced the word
clock among multiple multifaces? Would anything change in the .asoundrc
file?

d!



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
