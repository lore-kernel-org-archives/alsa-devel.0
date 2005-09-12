From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [conf patch] modem config for HDA-Intel
Date: Mon, 12 Sep 2005 20:05:28 +0300
Message-ID: <20050912170528.GD4584@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de>
 <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de>
 <20050907160343.GA3375@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050907160343.GA3375@sashak.softier1.local>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

This is modem related configuration for HDA-Intel (device 6).

Not tested.

Sasha.


"modem" pcm device for HDA-Intel card.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-lib/src/conf/cards/HDA-Intel.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/HDA-Intel.conf,v
retrieving revision 1.4
diff -u -p -r1.4 HDA-Intel.conf
--- alsa-lib/src/conf/cards/HDA-Intel.conf	24 Feb 2005 10:19:23 -0000	1.4
+++ alsa-lib/src/conf/cards/HDA-Intel.conf	12 Sep 2005 14:13:13 -0000
@@ -126,3 +126,15 @@ HDA-Intel.pcm.iec958.0 {
 		}
 	}
 }
+
+<confdir:pcm/modem.conf>
+
+HDA-Intel.pcm.modem.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 6
+}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
