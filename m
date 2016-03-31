From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix double-free in
 snd_usb_add_audio_stream()
Date: Thu, 31 Mar 2016 08:36:30 -0400 (EDT)
Message-ID: <882494379.43642280.1459427790768.JavaMail.zimbra@redhat.com>
References: <1459364602-28997-1-git-send-email-vdronov@redhat.com> <1459364602-28997-2-git-send-email-vdronov@redhat.com> <s5hbn5v7lnw.wl-tiwai@suse.de> <s5h8u0zgen2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <s5h8u0zgen2.wl-tiwai@suse.de>
Sender: linux-sound-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello, Takashi, all,

> > Thanks for the report.  But how about a simpler fix like below?
>
> Maybe the one below is more straightforward (and even simpler).
> Let me know if this works enough for you.

1) I would still suggest moving the code in create_fixed_stream_quirk() (marked
as (*)) after "if (altsd->bNumEndpoints < 1)" check. This way no allocations is
done in snd_usb_add_audio_stream() if we go an error path:

(*)     stream = (fp->endpoint & USB_DIR_IN) 
(*)             ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
(*)     err = snd_usb_add_audio_stream(chip, stream, fp);
(*)     if (err < 0)
(*)             goto error;

2) While your fix is indeed simpler, it fixes double-free bug only in
create_fixed_stream_quirk(). create_uaxx_quirk(), for example, still has this
bug:

        err = snd_usb_add_audio_stream(chip, stream, fp);
        if (err < 0) {                          <<< in the error path there
                kfree(fp);                      <<< is a double-free
                return err;
        }

as any other code where snd_usb_add_audio_stream() is used and *fp is freed in
case of error.

3) Not deleting fp from the fmt_list inside snd_usb_add_audio_stream() in case
of error moves this necessity to a caller, thus breaking the scope. This forces
any caller of snd_usb_add_audio_stream() to fulfill this non-obvious requirement.
But I agree that this is simpler and more straightforward. We need just to fix
all the places where snd_usb_add_audio_stream() is called (3 as of now), please,
have a look on the following patch.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

-- 8< --
From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] ALSA: usb-audio: Fix double-free in error paths after snd_usb_add_audio_stream() call

create_fixed_stream_quirk(), snd_usb_parse_audio_interface() and
create_uaxx_quirk() functions allocate the audioformat object by themselves
and free it upon error before returning. However, once the object is linked
to a stream, it's freed again in snd_usb_audio_pcm_free(), thus it'll be
double-freed, eventually resulting in a memory corruption.

This patch fixes these failures in the error paths by unlinking the audioformat
object before freeing it. Also it moves a piece of code in
create_fixed_stream_quirk() to avoid unnecessary allocations in case of error.

[Note for stable backports:
 this patch requires the commit 902eb7fd1e4a ('ALSA: usb-audio: Minor
 code cleanup in create_fixed_stream_quirk()')]

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1283358
Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Cc: <stable@vger.kernel.org> # see the note above
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 sound/usb/quirks.c | 15 ++++++++++-----
 sound/usb/stream.c |  5 ++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index fb62bce..dda5682 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -150,6 +150,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		usb_audio_err(chip, "cannot memdup\n");
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&fp->list);
 	if (fp->nr_rates > MAX_NR_RATES) {
 		kfree(fp);
 		return -EINVAL;
@@ -164,11 +165,6 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		fp->rate_table = rate_table;
 	}

-	stream = (fp->endpoint & USB_DIR_IN)
-		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
-	if (err < 0)
-		goto error;
 	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
 	    fp->altset_idx >= iface->num_altsetting) {
 		err = -EINVAL;
@@ -181,6 +177,12 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		goto error;
 	}

+	stream = (fp->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	err = snd_usb_add_audio_stream(chip, stream, fp);
+	if (err < 0)
+		goto error;
+
 	fp->protocol = altsd->bInterfaceProtocol;

 	if (fp->datainterval == 0)
@@ -193,6 +195,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	return 0;

  error:
+	list_del(&fp->list); /* unlink for avoiding double-free */
 	kfree(fp);
 	kfree(rate_table);
 	return err;
@@ -469,6 +472,7 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 	fp->datainterval = 0;
 	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	INIT_LIST_HEAD(&fp->list);

 	switch (fp->maxpacksize) {
 	case 0x120:
@@ -492,6 +496,7 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 	err = snd_usb_add_audio_stream(chip, stream, fp);
 	if (err < 0) {
+		list_del(&fp->list); /* unlink for avoiding double-free */
 		kfree(fp);
 		return err;
 	}
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 51258a1..6455003 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -316,7 +316,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 /*
  * add this endpoint to the chip instance.
  * if a stream with the same endpoint already exists, append to it.
- * if not, create a new pcm stream.
+ * if not, create a new pcm stream. the caller must remove fp from
+ * the substream fmt_list in the error path to avoid double-free.
  */
 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
@@ -677,6 +678,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 					* (fp->maxpacksize & 0x7ff);
 		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
 		fp->clock = clock;
+		INIT_LIST_HEAD(&fp->list);

 		/* some quirks for attributes here */

@@ -725,6 +727,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
 		err = snd_usb_add_audio_stream(chip, stream, fp);
 		if (err < 0) {
+			list_del(&fp->list); /* unlink for avoiding double-free */
 			kfree(fp->rate_table);
 			kfree(fp->chmap);
 			kfree(fp);
--
2.5.5
