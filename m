From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Alsa-1.0.0rc2 Hammerfall Light - small bug report
Date: Fri, 2 Jan 2004 15:10:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040102141046.GA590@tuba.home>
References: <1070760538.5385.12.camel@Wizard.knechthome.com> <1070763319.31277.0.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1070763319.31277.0.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 06, 2003 at 06:15:19PM -0800, Mark Knecht wrote:
> 
> Note ADAT3 which do not exist on
> this card.
> 
> 
> [mark@localhost mark]$ cat /proc/asound/card0/rme9652 
[...]
> ADAT Sample rate: 44100Hz
> ADAT1: No Lock
> ADAT2: No Lock
> ADAT3: No Lock
> 

This patch will remove the ADAT3 entry for light users. Please try it out,
because I don't have any hammerfall hardware.


martin

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme9652.patch"

Index: alsa-kernel/pci/rme9652/rme9652.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/rme9652.c,v
retrieving revision 1.39
diff -u -r1.39 rme9652.c
--- alsa-kernel/pci/rme9652/rme9652.c	19 Dec 2003 09:27:04 -0000	1.39
+++ alsa-kernel/pci/rme9652/rme9652.c	2 Jan 2004 13:21:26 -0000
@@ -1798,11 +1798,13 @@
 		snd_iprintf(buffer, "ADAT2: No Lock\n");
 	}
 
-	x = status & RME9652_sync_2;
-	if (status & RME9652_lock_2) {
-		snd_iprintf(buffer, "ADAT3: %s\n", x ? "Sync" : "Lock");
-	} else {
-		snd_iprintf(buffer, "ADAT3: No Lock\n");
+	if (rme9652->ss_channels == RME9652_NCHANNELS) {
+		x = status & RME9652_sync_2;
+		if (status & RME9652_lock_2) {
+			snd_iprintf(buffer, "ADAT3: %s\n", x ? "Sync" : "Lock");
+		} else {
+			snd_iprintf(buffer, "ADAT3: No Lock\n");
+		}
 	}
 
 	snd_iprintf(buffer, "\n");

--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
