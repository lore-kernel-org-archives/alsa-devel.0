From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hdsp: silence a sprinft() overflow warning
Date: Sat, 22 Aug 2015 12:24:13 +0300
Message-ID: <20150822092413.GA13454@mwanda>
References: <s5hfv3c4z3b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hfv3c4z3b.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

card->shortname is a 32 char string so the sprintf() can theoretically
overflow.  snd_rawmidi_new() can accept strings up to 64 bytes long.

I have made the temporay buf[] array 40 bytes long and changed the
sprintf() to snprintf().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 468a95c..afb2dea 100644
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
 
