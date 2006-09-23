From: "Jaap Struyk" <japie@deserver.nl>
Subject: problems with via82xx alsa part
Date: Sat, 23 Sep 2006 17:08:05 +0000 (UTC)
Message-ID: <ef3pll$kng$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

I'am running into an strange bug with alsa on my via-8233 mainboard.
The alsa oss emu workes fine, apps can use the oss devices without
problems.

aplay -l shows me:
card 0: V8233A [VIA 8233A], device 0: VIA 8233A [VIA 8233A]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

But aplay myfile.wav gives:
ALSA lib pcm_direct.c:985:(snd_pcm_direct_initialize_slave) unable to install hw params
ALSA lib pcm_dmix.c:876:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:550: audio open error: Ongepaste ioctl voor apparaat

I'am using alsa-*-1.0.12 and kernel 2.6.18, I have two similar systems
running, wich are identical copies but on the other machine with a
slightly different chipset alsa is functioning fine so I don't understand
what is the problem.
-- 
Greetings Japie


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
