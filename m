From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Testers needed: memio-mmap patch (rme32,rme96,nm256)
Date: Thu, 1 Jul 2004 22:13:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040701201326.GA567@tuba.home>
References: <s5hllikor62.wl@alsa2.suse.de> <20040620101135.GA755@tuba.home> <s5hd63fallg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd63fallg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, pilo.c@wanadoo.fr
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 01, 2004 at 03:44:11PM +0200, Takashi Iwai wrote:
> At Sun, 20 Jun 2004 12:11:35 +0200,
> Martin Langer wrote:
> > 
> > Ok, let's try fullduplex now...
> 
> JFYI: it's now on CVS tree.
> fullduplex module option is disabled as default, though.

For enabling fullduplex you will need the following patch, too.

FYI: The situation is that I get only silence in fullduplex_mode after a
short time. But nevertheless in the beginning it is correct.


martin


--- alsa-kernel/pci/rme32.c	Thu Jul  1 19:52:09 2004
+++ ../alsa-rme32b/alsa-kernel/pci/rme32.c	Sun Jun 27 21:55:37 2004
@@ -1990,6 +2002,11 @@
 	rme32->card = card;
 	rme32->pci = pci;
 	snd_card_set_dev(card, &pci->dev);
+
+        if (fullduplex[dev]) {
+                rme32->fullduplex_mode = 1;
+        }
+
 	if ((err = snd_rme32_create(rme32)) < 0) {
 		snd_card_free(card);
 		return err;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
