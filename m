From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: snd-usb-audio problems with 2.6.18
Date: Sat, 23 Sep 2006 14:54:56 +0200
Message-ID: <20060923125456.GA7757@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A recent 2.6.18 kernel upgrade on one of my machines broke usb audio.

I'm using a TerraTec Aureon 5.1 USB MKII to feed ac3 audio to a =

receiver, but after the upgrade, trying to play any audio (tried aplay, =

mplayer, xine, etc...using both oss and alsa audio) results in the =

kernel log being filled with the message:

"cannot submit datapipe for urb 5, error -28: not enough bandwidth"

Unfortunately the upgrade was from 2.6.14 (yes, it's old but the machine =

has no network connection usually) so there is quite a lot of =

differences to the snd-usb-audio driver in the meantime.

Unless someone has suggestions as to a simple fix, I guess I'll =

start testing kernels in the 2.6.14 <-> 2.6.18 range soon to try to pin =

down a certain changeset...

-- =

David H=E4rdeman

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
