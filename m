From: Roberto Ragusa <r.ragusa@libero.it>
Subject: [PATCH] Recording AUX on ak4531 (e.g. es1370)
Date: Sat, 28 Feb 2004 11:41:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040228114133.140cfa42.r.ragusa@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

after going from kernel 2.4 to 2.6 (and so switching to alsa) I noticed
it wasn't possible to record the aux signal on my es1370 (this is TV
audio in my case).

I had a look at the code and resolved the problem with this small patch,
for kernel 2.6.3.
Surprisingly enough, the fix is just related to a string, but I see
that there are no "Input Route" in sound/* (only "Capture Route"),
so it should be right.

--- ak4531_codec.c_orig 2003-12-18 03:58:15.000000000 +0100
+++ ak4531_codec.c      2004-02-26 12:36:46.000000000 +0100
@@ -285,7 +285,7 @@ AK4531_INPUT_SW("Line Capture Route", 0,
 AK4531_DOUBLE("Aux Switch", 0, AK4531_LAUXA, AK4531_RAUXA, 7, 7, 1, 1),
 AK4531_DOUBLE("Aux Volume", 0, AK4531_LAUXA, AK4531_RAUXA, 0, 0, 0x1f, 1),
 AK4531_DOUBLE("Aux Playback Switch", 0, AK4531_OUT_SW2, AK4531_OUT_SW2, 5, 4, 1, 0),
-AK4531_INPUT_SW("Aux Input Route", 0, AK4531_LIN_SW2, AK4531_RIN_SW2, 4, 3),
+AK4531_INPUT_SW("Aux Capture Route", 0, AK4531_LIN_SW2, AK4531_RIN_SW2, 4, 3),

 AK4531_SINGLE("Mono Switch", 0, AK4531_MONO1, 7, 1, 1),
 AK4531_SINGLE("Mono Volume", 0, AK4531_MONO1, 0, 0x1f, 1),

-- 
   Roberto Ragusa    r.ragusa at libero.it


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
