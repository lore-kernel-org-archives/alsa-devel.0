From: Matthias Koenig <list@phasorlab.de>
Subject: Re: [PATCH] alsa-driver: portman2x4 code cleanup
Date: Wed, 24 Jan 2007 20:43:46 +0100
Message-ID: <87ejpkjjm5.fsf@zebra.localdomain>
References: <n7xr6tksauu.fsf@sor.suse.de> <s5hzm88bbqt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D9412F0
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2007 20:43:48 +0100 (MET)
In-Reply-To: <s5hzm88bbqt.wl%tiwai@suse.de> (Takashi Iwai's message of "Wed,
	24 Jan 2007 18:00:58 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Takashi Iwai <tiwai@suse.de> writes:
>> Signed-off-by: Matthias Koenig <mkoenig@suse.de>
>> ============================================================
>> Summary: portman2x4 code cleanup
>> 
>> - changed code structure to mirror the one of the mts64.c driver 
>>   for better maintenance
>> - added proper handling of platform device
>> - general cleanup (no CamelCase names)
>
> Thanks, the changes look good to me.
>
> Since the patch couldn't be applied cleanly, I fixed it manually.

Hmm, what was the problem? I just used the hg quilt extensions
and took the resulting patch.

> Also, added cpu_relax() in busy loops, and fixed unneeded
> initialization of variables.

Ok, thanks

> The code is now committed to ALSA HG tree.  Please give it a try.

Ah, I just tested and found that the rawmidi open/close callbacks
have to be defined and cannot be NULL. So the driver as it is
will oops if device will be opened.
Fixed this, now tested with amidi input/output on all ports works
fine. Patch is below.

> BTW, if the driver works for you, we can move this to alsa-kernel tree
> so that it's merged to the upstream kernel...

Great, yes I think it can then be moved to alsa-kernel tree.

Matthias

Signed-off-by: Matthias Koenig <mkoenig@suse.de>
===========================================================
Summary: Fix callbacks


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=portman2x4-callbacks.patch

diff -r 34388b137f38 drivers/portman2x4-kernel.c
--- a/drivers/portman2x4-kernel.c	Wed Jan 24 17:57:48 2007 +0100
+++ b/drivers/portman2x4-kernel.c	Wed Jan 24 20:14:19 2007 +0100
@@ -508,6 +508,15 @@ static int portman_device_init(struct po
 /*********************************************************************
  * Rawmidi
  *********************************************************************/
+static int snd_portman_midi_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int snd_portman_midi_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
 
 static void snd_portman_midi_input_trigger(struct snd_rawmidi_substream *substream,
 					   int up)
@@ -539,14 +548,14 @@ static void snd_portman_midi_output_trig
 }
 
 static struct snd_rawmidi_ops snd_portman_midi_output = {
-	.open =		NULL,
-	.close =	NULL,
+	.open =		snd_portman_midi_open,
+	.close =	snd_portman_midi_close,
 	.trigger =	snd_portman_midi_output_trigger,
 };
 
 static struct snd_rawmidi_ops snd_portman_midi_input = {
-	.open =		NULL,
-	.close =	NULL,
+	.open =		snd_portman_midi_open,
+	.close =	snd_portman_midi_close,
 	.trigger =	snd_portman_midi_input_trigger,
 };
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
