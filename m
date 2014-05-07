From: Ralf Beck <musical_snake@gmx.de>
Subject: [PATCH] rawmidi.c Set a name for a newly allocated
	rawmidi substream
Date: Wed, 07 May 2014 19:24:13 +0200
Message-ID: <536A6C3D.6080906@gmx.de>
Reply-To: ralfbeck1@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 27479261AE7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 19:24:15 +0200 (CEST)
Received: from [192.168.2.173] ([178.13.30.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LngNT-1XKSOH2wiV-00htZV for
 <alsa-devel@alsa-project.org>; Wed, 07 May 2014 19:24:14 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rationale: Bitwig Studio (and possibly other rawmidi clients) enumerate 
the Midi I/Os by
substream names. With the current rawmidi implementation, the name is an 
empty string
and only the USB mididriver changes it to a meaningful value after 
allocation.

This patch sets a default substream name of the form "somename x-y-z"

--- linux-source-3.13.0/sound/core/rawmidi.c.orig    2014-05-06 
20:25:33.683081389 +0200
+++ linux-source-3.13.0/sound/core/rawmidi.c    2014-05-06 
17:42:35.058097185 +0200
@@ -34,6 +34,7 @@
  #include <sound/control.h>
  #include <sound/minors.h>
  #include <sound/initval.h>
+#include <linux/string.h>

  MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
  MODULE_DESCRIPTION("Midlevel RawMidi code for ALSA.");
@@ -1420,6 +1421,8 @@ static int snd_rawmidi_alloc_substreams(
          substream->number = idx;
          substream->rmidi = rmidi;
          substream->pstr = stream;
+            snprintf(substream->name, sizeof(substream->name),
+                 "%s %d-%d-%d", rmidi->id, rmidi->card->number, 
rmidi->device, idx);
          list_add_tail(&substream->list, &stream->substreams);
          stream->substream_count++;
      }
