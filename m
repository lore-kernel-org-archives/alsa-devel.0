From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] fixing a two-rme32-in-one-machine bug
Date: Wed, 6 Oct 2004 21:47:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006194730.GA10606@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

it's reported that a machine with two rme32 cards doesn't work (the second
card doesn't work) .... and I can't test it here :(

But nevertheless here's the trial of a fix.

The snd_xxx_probe function is now similar to other pci cards.....


martin


Summary:
- fixing the dev counter in snd_rme32_probe(). The patch can enable a second
  rme32 card now.

Signed-Off-by: Martin Langer <martin-langer@gmx.de>

-- 

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme32.patch"

--- rme32.c.ORIGINAL	Wed Oct  6 21:03:53 2004
+++ rme32.c	Wed Oct  6 21:05:48 2004
@@ -1970,16 +1970,14 @@
 	snd_card_t *card;
 	int err;
 
-	for (; dev < SNDRV_CARDS; dev++) {
-		if (!enable[dev]) {
-			dev++;
-			return -ENOENT;
-		}
-		break;
-	}
 	if (dev >= SNDRV_CARDS) {
 		return -ENODEV;
 	}
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
 	if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
 				 sizeof(rme32_t))) == NULL)
 		return -ENOMEM;

--HlL+5n6rz5pIUxbD--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
