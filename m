From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Full duplex dmix,dsnoop
Date: Thu, 25 Mar 2004 19:37:22 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406334F2.4020101@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090004030808000903070303"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090004030808000903070303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached patch for suggested new pcm device.

It works for: -
arecord -fdat -Dplug:duplex | aplay -Dplug:duplex

bash-2.05b# arecord -fdat -Dplug:duplex | aplay -Dplug:duplex
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

but fails for: -
arecord -fcd -Dplug:duplex | aplay -Dplug:duplex

bash-2.05b# arecord -fcd -Dplug:duplex | aplay -Dplug:duplex
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
arecord: pcm.c:5920: snd_pcm_mmap_commit: Assertion `frames <= 
snd_pcm_mmap_avail(pcm)' failed.
Aborted by signal Aborted...

This last example with -fcd, outputs one period, maybe two then exits 
with the above error.

Can anybody help?

Cheers
James

--------------090004030808000903070303
Content-Type: text/x-patch;
 name="duplex.dmix.dsnoop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="duplex.dmix.dsnoop.patch"

--- alsa.conf.org	2004-02-04 12:28:31.000000000 +0000
+++ alsa.conf	2004-03-25 19:27:34.207640104 +0000
@@ -228,6 +228,12 @@
 	}
 }
 
+pcm.duplex {
+	type asym
+		playback.pcm "dmix"
+		capture.pcm "dsnoop"
+}
+
 pcm.shm {
 	@args [ SOCKET PCM ]
 	@args.SOCKET {

--------------090004030808000903070303--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
