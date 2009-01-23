From: LCID Fire <lcid-fire@gmx.net>
Subject: [PATCH] Replace hardcoded hexa formating
Date: Fri, 23 Jan 2009 23:42:19 +0100
Message-ID: <497A47CB.3050501@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090005020502040906020606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 7993D103926
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 23:42:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090005020502040906020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch replaces the hardcoded hexa formats in usbaudio.c

--------------090005020502040906020606
Content-Type: text/plain;
 name="commit-079e4ef"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commit-079e4ef"

commit 079e4efba0603e7a32bf1d352d98c2b265b91cd6
Author: LCID Fire <lcid-fire@gmx.net>
Date:   Fri Jan 23 23:39:06 2009 +0100

    Rather use printf format instead of hardcoding it.
    A next step would be to predefine certain formats.
    
    Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index bbd70d5..77ac5c9 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -1292,14 +1292,14 @@ static int init_usb_sample_rate(struct usb_device *dev, int iface,
 		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR,
 					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep 0x%x\n",
+			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
 				   dev->devnum, iface, fmt->altsetting, rate, ep);
 			return err;
 		}
 		if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR,
 					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep 0x%x\n",
+			snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
 				   dev->devnum, iface, fmt->altsetting, ep);
 			return 0; /* some devices don't support reading */
 		}
@@ -1468,7 +1468,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	channels = params_channels(hw_params);
 	fmt = find_format(subs, format, rate, channels);
 	if (!fmt) {
-		snd_printd(KERN_DEBUG "cannot set format: format = 0x%x, rate = %d, channels = %d\n",
+		snd_printd(KERN_DEBUG "cannot set format: format = %#x, rate = %d, channels = %d\n",
 			   format, rate, channels);
 		return -EINVAL;
 	}
@@ -2160,7 +2160,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 		fp = list_entry(p, struct audioformat, list);
 		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
-		snd_iprintf(buffer, "    Format: 0x%x\n", fp->format);
+		snd_iprintf(buffer, "    Format: %#x\n", fp->format);
 		snd_iprintf(buffer, "    Channels: %d\n", fp->channels);
 		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
 			    fp->endpoint & USB_ENDPOINT_NUMBER_MASK,
@@ -2180,7 +2180,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 			snd_iprintf(buffer, "\n");
 		}
 		// snd_iprintf(buffer, "    Max Packet Size = %d\n", fp->maxpacksize);
-		// snd_iprintf(buffer, "    EP Attribute = 0x%x\n", fp->attributes);
+		// snd_iprintf(buffer, "    EP Attribute = %#x\n", fp->attributes);
 	}
 }
 
@@ -2619,7 +2619,7 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip, struct audioformat
 		fp->format = SNDRV_PCM_FORMAT_MPEG;
 		break;
 	default:
-		snd_printd(KERN_INFO "%d:%u:%d : unknown format tag 0x%x is detected.  processed as MPEG.\n",
+		snd_printd(KERN_INFO "%d:%u:%d : unknown format tag %#x is detected.  processed as MPEG.\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
 		fp->format = SNDRV_PCM_FORMAT_MPEG;
 		break;
@@ -2817,7 +2817,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			continue;
 		}
 
-		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n", dev->devnum, iface_no, altno, fp->endpoint);
+		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint %#x\n", dev->devnum, iface_no, altno, fp->endpoint);
 		err = add_audio_endpoint(chip, stream, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);

--------------090005020502040906020606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090005020502040906020606--
