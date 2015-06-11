From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hdsp: silence a sprinft() overflow
	warning
Date: Thu, 11 Jun 2015 18:14:34 +0300
Message-ID: <20150611151434.GE12192@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id C5CC1266534
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 17:14:53 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Benoit Taine <benoit.taine@lip6.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: alsa-devel@alsa-project.org

card->shortname is a 32 char string so the sprintf() can theoretically
overflow.  snd_rawmidi_new() can accept strings up to 64 bytes long.

I have made the temporay buf[] array 40 bytes long and changed the
sprintf() to snprintf().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index c19e021..c1fe1d3 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1526,7 +1526,7 @@ static struct snd_rawmidi_ops snd_hdsp_midi_input =
 
 static int snd_hdsp_create_midi (struct snd_card *card, struct hdsp *hdsp, int id)
 {
-	char buf[32];
+	char buf[40];
 
 	hdsp->midi[id].id = id;
 	hdsp->midi[id].rmidi = NULL;
@@ -1537,7 +1537,7 @@ static int snd_hdsp_create_midi (struct snd_card *card, struct hdsp *hdsp, int i
 	hdsp->midi[id].pending = 0;
 	spin_lock_init (&hdsp->midi[id].lock);
 
-	sprintf (buf, "%s MIDI %d", card->shortname, id+1);
+	snprintf(buf, sizeof(buf), "%s MIDI %d", card->shortname, id + 1);
 	if (snd_rawmidi_new (card, buf, id, 1, 1, &hdsp->midi[id].rmidi) < 0)
 		return -1;
 
