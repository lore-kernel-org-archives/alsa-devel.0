From: Andreas =?ISO-8859-1?Q?Kl=F6ckner?= <andreas-kloeckner@gmx.net>
Subject: [bug] cs46xx: sound way too fast and chopped
Date: Sat, 5 Apr 2003 00:28:24 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <14554.1049495304@www58.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
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
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using the CS46xx sound chip in my Thinkpad A21m with a 2.4.20 kernel and
alsa 0.9.2, compiled by gcc (GCC) 3.2.3 20030309 (Debian prerelease).

At unpredictable times, the sound becomes very silent, and it appears as if
it was playing many times faster than it should. Only very short snippets of
sound (<1ms, not intelligible) are played with lots of silence in between.

This happens a lot when the computes is busy doing other things besides
playing sounds (such as intense hard drive activity). It has happened to me once
at least through every movie that I've watched (using mplayer, if that helps)
recently. Seeking in XMMS has also caused that kind of problem before.

lspci -v:

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM: Unknown device 0153
        Flags: bus master, slow devsel, latency 64, IRQ 11
        Memory at f4122000 (32-bit, non-prefetchable) [size=4K]
        Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

lspci -vn:

00:05.0 Class 0401: 1013:6003 (rev 01)
        Subsystem: 1014:0153
        Flags: bus master, slow devsel, latency 64, IRQ 11
        Memory at f4122000 (32-bit, non-prefetchable) [size=4K]
        Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

Best regards and thank you for your help,

Andreas

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
