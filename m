From: Ed Wright <edo.wright@gmail.com>
Subject: intel-hda, 965 chipset, STAC9227 - problem
Date: Thu, 11 Jan 2007 23:24:15 +0900
Message-ID: <45A6488F.4010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

With the following setup, sound does not seem to work:

kernel: 2.6.19
alsa (driver, lib, utils): 1.0.13
motherboard: Intel DG965
chipset: Intel=AE G965 Express Chipset
controller: ICH8
audio: 6-channel (5.1) audio subsystem using the SigmaTel STAC9227
audio codec

lspci output:
0000:00:1b.0 0403: 8086:284b (rev 02)
         Subsystem: 8086:2113
         Flags: bus master, fast devsel, latency 0, IRQ 20
         Memory at 92320000 (64-bit, non-prefetchable) [size=3D16K]
         Capabilities: [50] Power Management version 2
         Capabilities: [60] Message Signalled Interrupts: 64bit+ =

Queue=3D0/0 Enable-
         Capabilities: [70] #10 [0091]


However if I boot from a Knoppix 5.0 CD, the sound does work
(kernel: 2.6.17
alsa: 1.0.11rc4
codec: SigmaTel ID 7618)


I wonder if this is related to the issue referred to in the thread on =

2006-10-26 "[PATCH] hda: add sigmatel dig mic support and refactor	9227" =

- specifically about refactoring 9227. (As of 1.0.14rc1 this seems to be =

still outstanding...)

At any rate if there is a way to get this configuration working, I'd =

greatly appreciate the information. Alternatively, it seems that it =

might work with the generic driver (ala Knoppix), but I have not been =

able to figure out how to force that to load.

Thanks in advance,
Ed

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
