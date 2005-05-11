From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] compiling problem fixed
Date: Wed, 11 May 2005 20:54:59 +0200
Message-ID: <20050511185459.GA2962@tuba>
References: <20050503142916.GA3281@tuba> <s5hoebh292c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoebh292c.wl@alsa2.suse.de>
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 11, 2005 at 03:20:27PM +0200, Takashi Iwai wrote:
> At Tue, 3 May 2005 16:29:16 +0200,
> Martin Langer wrote:
> > 
> > This fixes a 2.4 compiling problem on alpha. GFP_KERNEL was undeclared.
> 
> It's not nice to put to this place.  It always includes the file.

Ah sorry, I see your point. Next time I should scroll down in my 
editor, before I create a patch :)

> Where does this error happen?  In the gameport wrapper inline
> function?  

Yep, it's in the gameport wrapper inline function. So now it's 
placed closer to that wrapper function.

---
Fix undeclared GFP_KERNEL in gameport wrapper inline function. Compile 
error happened with debian kernel 2.4.27 (alpha cpu).

Signed-off-by: Martin Langer <martin-langer@gmx.de>
---

BTW, the miroSOUND PCM12 with the new miro driver is running great, even 
on my alpha machine here :)


martin

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="adriver.patch"

--- include/adriver.h.ORIGINAL	2005-05-03 15:57:09.000000000 +0200
+++ include/adriver.h	2005-05-11 20:18:38.000000000 +0200
@@ -749,6 +749,7 @@
 #include <linux/gameport.h>
 #undef wait_ms
 #ifndef to_gameport_driver
+#include <linux/slab.h>
 /* old gameport interface */
 struct snd_gameport {
 	struct gameport gp;

--RnlQjJ0d97Da+TV1--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
