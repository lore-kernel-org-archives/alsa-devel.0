From: Mark Hills <mark@xwax.org>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sat, 29 Mar 2014 01:01:45 -0400 (EDT)
Message-ID: <1403282253300.13982@beth>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 387BB261A3A
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 10:37:12 +0100 (CET)
In-Reply-To: <5314EDA1.5040101@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Mar 2014, Daniel Mack wrote:

> Hi Damien,
> 
> Thanks for your patch! See my two comments below.
> 
> On 01/27/2014 04:02 AM, Damien Zammit wrote:
> > On 27/01/14 03:52, Clemens Ladisch wrote:
> >>> >> This patch creates a dual endpoint quirk.
> >>>> >> >The quirk interface needs a second audioformat struct for this to work
> >>>> >> >which I called ".data2".
> >> > Couldn't you just let .data point to an array of two structs?
> > Thanks Clemens, I have created a new patch using this suggestion.
> 
> [...]
> 
> > +	fp2 = kmemdup((const struct audioformat*)(quirk->data + sizeof(const struct audioformat)), sizeof(*fp2), GFP_KERNEL);
> > +	if (!fp2) {
> > +		snd_printk(KERN_ERR "cannot memdup 2\n");
> > +		return -ENOMEM;
> > +	}
> > +	if (fp1->nr_rates > MAX_NR_RATES) {
> > +		kfree(fp1);
> > +		kfree(fp2);
> 
> Please do proper error unwinding here with jump labels rather than
> open-coding the kfree() calls from multiple places.
> 
> Also, I wonder whether a more generic quirk type to set up a dynamic
> number of fixed interfaces wouldn't be nicer. IOW, add a field to struct
> snd_usb_audio_quirk to denote the number of array members in quirk->data
> and call the quirk type QUIRK_AUDIO_FIXED_MULTI_ENDPOINT or something.
> Then, rewrite the logic to iterate over the interfaces in a loop. That
> might also make the code more readable.

I'm a bit late to this, but I think a more generic quirk is necessary.

The problem with the patch is that the new code still calls functions 
hard-wired to the first endpoint on the interface, eg. 
snd_usb_init_pitch(). Also parameters such as altsetting apply to the 
interface, not endpoint.

So whilst it may work in the given case, much of the quirk is ignored.

This is worth fixing though, as there is the same limitation with the 
Focusrite/Novation interfaces, and I suspect others too.

A cleaner implementation is probably an array of endpoints in the quirk, 
something like the patch below (untested)

I found the problem is functions using an endpoint index (eg. 0) whereas 
mainly the function uses the ID (eg. 0x81). What is the relationship 
between the two?

It's to replace calls such as:

  usb_sndctrlpipe(dev, 0)
  get_endpoint(alts, 0)

Or does some kind of spec define that these should be applied to the first 
endpoint and that all will be affected?

Thanks

-- 
Mark


---
 sound/usb/card.h         |  2 ++
 sound/usb/quirks-table.h |  5 ++++-
 sound/usb/quirks.c       | 58 ++++++++++++++++++++++++++++++++++++------------
 sound/usb/stream.c       |  5 +++--
 sound/usb/stream.h       |  1 +
 5 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 9867ab8..3398708 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -20,6 +20,8 @@ struct audioformat {
 	unsigned char attributes;	/* corresponding attributes of cs endpoint */
 	unsigned char endpoint;		/* endpoint */
 	unsigned char ep_attr;		/* endpoint attributes */
+	unsigned char nr_endpoints;     /* number of endpoint table entries */
+	unsigned char *endpoint_table;  /* endpoint table */
 	unsigned char datainterval;	/* log_2 of data packet interval */
 	unsigned char protocol;		/* UAC_VERSION_1/2 */
 	unsigned int maxpacksize;	/* max. packet size */
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f5f0595..ab64e50 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2807,7 +2807,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
-					.endpoint = 0x02,
+					.nr_endpoints = 2,
+					.endpoint_table = (unsigned char[]) {
+						0x02, 0x81
+					},
 					.ep_attr = 0x01,
 					.rates = SNDRV_PCM_RATE_44100 |
 						 SNDRV_PCM_RATE_48000,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0df9ede..01c77e2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -120,12 +120,12 @@ static int create_standard_audio_quirk(struct snd_usb_audio *chip,
 }
 
 /*
- * create a stream for an endpoint/altsetting without proper descriptors
+ * create a stream using the given quirk and endpoint
  */
-static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
+static int create_stream_at_endpoint(struct snd_usb_audio *chip,
 				     struct usb_interface *iface,
-				     struct usb_driver *driver,
-				     const struct snd_usb_audio_quirk *quirk)
+				     unsigned char endpoint,
+				     const struct audioformat *quirk_data)
 {
 	struct audioformat *fp;
 	struct usb_host_interface *alts;
@@ -133,7 +133,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	int stream, err;
 	unsigned *rate_table = NULL;
 
-	fp = kmemdup(quirk->data, sizeof(*fp), GFP_KERNEL);
+	fp = kmemdup(quirk_data, sizeof(*fp), GFP_KERNEL);
 	if (!fp) {
 		snd_printk(KERN_ERR "cannot memdup\n");
 		return -ENOMEM;
@@ -152,20 +152,14 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		fp->rate_table = rate_table;
 	}
 
-	stream = (fp->endpoint & USB_DIR_IN)
+	stream = (endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
+	err = snd_usb_add_audio_stream(chip, stream, endpoint, fp);
 	if (err < 0) {
 		kfree(fp);
 		kfree(rate_table);
 		return err;
 	}
-	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
-	    fp->altset_idx >= iface->num_altsetting) {
-		kfree(fp);
-		kfree(rate_table);
-		return -EINVAL;
-	}
 	alts = &iface->altsetting[fp->altset_idx];
 	altsd = get_iface_desc(alts);
 	fp->protocol = altsd->bInterfaceProtocol;
@@ -174,9 +168,45 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 	if (fp->maxpacksize == 0)
 		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+
+	return 0;
+}
+
+/*
+ * create a stream for an endpoint/altsetting without proper descriptors
+ */
+static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
+				     struct usb_interface *iface,
+				     struct usb_driver *driver,
+				     struct snd_usb_audio_quirk *quirk)
+{
+	struct audioformat *fp = quirk->data;
+	struct usb_host_interface *alts;
+	int n, err;
+
+	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
+	    fp->altset_idx >= iface->num_altsetting) {
+		return -EINVAL;
+	}
+
 	usb_set_interface(chip->dev, fp->iface, 0);
+
+	if (fp->nr_endpoints == 0) {
+		err = create_stream_at_endpoint(chip, iface, fp->endpoint, fp);
+		if (err < 0)
+			return err;
+	}
+	for (n = 0; n < fp->nr_endpoints; n++) {
+		err = create_stream_at_endpoint(chip, iface, fp->endpoint_table[n], fp);
+		if (err < 0)
+			return err;
+	}
+
+	/* FIXME: these functions fixed to the first endpoint */
+	alts = &iface->altsetting[fp->altset_idx];
 	snd_usb_init_pitch(chip, fp->iface, alts, fp);
 	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
+
 	return 0;
 }
 
@@ -471,7 +501,7 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 
 	stream = (fp->endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
+	err = snd_usb_add_audio_stream(chip, stream, fp->endpoint, fp);
 	if (err < 0) {
 		kfree(fp);
 		return err;
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 2fb71be..34947db 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -319,6 +319,7 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
  */
 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
+			     unsigned char endpoint,
 			     struct audioformat *fp)
 {
 	struct snd_usb_stream *as;
@@ -330,7 +331,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		if (as->fmt_type != fp->fmt_type)
 			continue;
 		subs = &as->substream[stream];
-		if (subs->ep_num == fp->endpoint) {
+		if (subs->ep_num == endpoint) {
 			list_add_tail(&fp->list, &subs->fmt_list);
 			subs->num_formats++;
 			subs->formats |= fp->formats;
@@ -708,7 +709,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->chmap = convert_chmap(fp->channels, chconfig, protocol);
 
 		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint %#x\n", dev->devnum, iface_no, altno, fp->endpoint);
-		err = snd_usb_add_audio_stream(chip, stream, fp);
+		err = snd_usb_add_audio_stream(chip, stream, fp->endpoint, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);
 			kfree(fp->chmap);
diff --git a/sound/usb/stream.h b/sound/usb/stream.h
index c97f679..4c1b834 100644
--- a/sound/usb/stream.h
+++ b/sound/usb/stream.h
@@ -6,6 +6,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 
 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
+			     unsigned char endpoint,
 			     struct audioformat *fp);
 
 #endif /* __USBAUDIO_STREAM_H */
-- 
1.8.4
