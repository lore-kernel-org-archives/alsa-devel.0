From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [conf patch] modem's pcm "two device" config [was: Re: Mo' better modem support]
Date: Mon, 12 Sep 2005 03:27:46 +0300
Message-ID: <20050912002746.GA31233@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050907160343.GA3375@sashak.softier1.local>
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

On 19:03 Wed 07 Sep     , Sasha Khapyorsky wrote:
> > > 
> > > If we really need to auto-"Hoof-Off" we may separate it to logically
> > > different pcm devices (like pcm.modem, pcm.phoneline or so) and then add
> > > hook to one of them.
> > 
> > Sounds reasonable.
> 
> I will prepare patch this weekend or so (want to test it first).

There is the patch (actually beginning). This defines two PCMs:
"phoneline" is renamed old-style modem and "modem" is pcm with
auto-"Hook-Off".

Sasha.


This defines two modem related pcm devices: "phoneline" is driver's pcm
reference, with "modem" the line will be "Hook-Off"ed automatically.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-lib/src/conf/alsa.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/alsa.conf,v
retrieving revision 1.19
diff -u -p -r1.19 alsa.conf
--- alsa-lib/src/conf/alsa.conf	27 Jan 2005 15:45:05 -0000	1.19
+++ alsa-lib/src/conf/alsa.conf	11 Sep 2005 23:52:34 -0000
@@ -251,6 +251,7 @@ pcm.surround71 cards.pcm.surround71
 pcm.iec958 cards.pcm.iec958
 pcm.spdif cards.pcm.iec958
 pcm.modem cards.pcm.modem
+pcm.phoneline cards.pcm.phoneline
 
 pcm.default cards.pcm.default
 pcm.dmix cards.pcm.dmix
Index: alsa-lib/src/conf/pcm/modem.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/pcm/modem.conf,v
retrieving revision 1.1
diff -u -p -r1.1 modem.conf
--- alsa-lib/src/conf/pcm/modem.conf	12 Jul 2004 16:21:30 -0000	1.1
+++ alsa-lib/src/conf/pcm/modem.conf	11 Sep 2005 23:52:34 -0000
@@ -1,8 +1,8 @@
 #
-# Modem output
+# "raw" modem - phoneline
 #
 
-pcm.!modem {
+pcm.!phoneline {
 	@args [ CARD DEV ]
 	@args.CARD {
 		type string
@@ -45,3 +45,60 @@ pcm.!modem {
 		]
 	}
 }
+
+#
+#  "autohooked" modem
+#
+
+pcm.!modem {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_MODEM_CARD
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.modem.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_MODEM_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.modem.device
+			}
+		}
+	}
+	type hooks
+	slave {
+		pcm {
+			@func concat
+			strings [
+				"cards.pcm.phoneline:CARD=" $CARD ",DEV=" $DEV
+			]
+		}
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+		{
+			name "Off-hook Switch"
+			preserve true
+			value "on"
+			lock false
+			optional true
+		}
+		]
+	}
+}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
