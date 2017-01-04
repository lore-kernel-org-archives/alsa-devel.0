From: Juho Jokelainen <juho_jokelainen@hotmail.com>
Subject: Better support for Focusrite saffire pro 6 usb 1
Date: Wed, 4 Jan 2017 09:17:48 +0000
Message-ID: <VI1PR1001MB10235B43C460301D5231175C82610@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC2S5.hotmail.com (col004-omc2s5.hotmail.com
 [65.55.34.79]) by alsa0.perex.cz (Postfix) with ESMTP id 48224266950
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 10:17:52 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

After getting said device, I was bummed it didn't work well in linux (or windows for that matter).

Fortunately I fould an earlier post about it.

http://alsa-devel.alsa-project.narkive.com/pr5aHEeM/rfc-patch-0-2-add-support-for-audio-cards-with-multiple-endpoints-on-the-one-interface


For whatever reason, that patch has not made it into kernel. I can vouch that this patch

(with a few line change to support kernel changes in the last 3 years) does work and my

device now supports both audio input and output.


Unfortunately I have no experience in kernel development nor do I really understand the

alsa system. Since the code has been kept out of kernel, I suspect there is something

fishy about it. If in any way possible I would still like to see code that effectively does the

same thing as this patch upstreamed.


The slightly modified patch (for kernel 4.8):


---
 sound/usb/pcm.c          | 44 ++++++++++++++++++++++++++++++++++++--------
 sound/usb/quirks-table.h | 24 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 44d178e..19e319d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -483,7 +483,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
        struct usb_host_interface *alts;
        struct usb_interface_descriptor *altsd;
        struct usb_interface *iface;
-       int err;
+       int err, need_init, i;

        iface = usb_ifnum_to_if(dev, fmt->iface);
        if (WARN_ON(!iface))
@@ -498,12 +498,26 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)

        /* close the old interface */
        if (subs->interface >= 0 && subs->interface != fmt->iface) {
-               err = usb_set_interface(subs->dev, subs->interface, 0);
-               if (err < 0) {
-                       dev_err(&dev->dev,
-                               "%d:%d: return to setting 0 failed (%d)\n",
-                               fmt->iface, fmt->altsetting, err);
-                       return -EIO;
+
+               need_init = iface->cur_altsetting != alts;
+
+               if (need_init) {
+                       err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+                       if (err < 0) {
+                               dev_err(&dev->dev,
+                                       "%d:%d: usb_set_interface failed (%d)\n",
+                                       fmt->iface, fmt->altsetting, err);
+                               return -EIO;
+                       }
+                       dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
+                               fmt->iface, fmt->altsetting);
+               }
+
+               for (i = 0; i < alts->desc.bNumEndpoints; ++i) {
+                       if (alts->endpoint[i].desc.bEndpointAddress == fmt->endpoint)
+                               alts->endpoint[i].enabled = 1;
+                       else if (need_init)
+                               alts->endpoint[i].enabled = 0;
                }
                subs->interface = -1;
                subs->altset_idx = 0;
@@ -1241,12 +1255,26 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 {
        struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
        struct snd_usb_substream *subs = &as->substream[direction];
+       struct usb_interface *iface;
+       struct usb_host_interface *cur_alts;
+       int i, ep_active = 0;

        stop_endpoints(subs, true);

        if (subs->interface >= 0 &&
            !snd_usb_lock_shutdown(subs->stream->chip)) {
-               usb_set_interface(subs->dev, subs->interface, 0);
+               iface = usb_ifnum_to_if(subs->dev, subs->interface);
+               cur_alts = iface->cur_altsetting;
+               for (i = 0; i < cur_alts->desc.bNumEndpoints; ++i) {
+                       if (cur_alts->endpoint[i].desc.bEndpointAddress == subs->ep_num)
+                               cur_alts->endpoint[i].enabled = 0;
+
+                       ep_active += cur_alts->endpoint[i].enabled;
+               }
+
+               if (!ep_active)
+                       usb_set_interface(subs->dev, subs->interface, 0);
+
                subs->interface = -1;
                snd_usb_unlock_shutdown(subs->stream->chip);
        }
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c60a776..2670498 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2701,6 +2701,30 @@ YAMAHA_DEVICE(0x7010, "UB99"),
                                        .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                                        .endpoint = 0x01,
                                        .ep_attr = USB_ENDPOINT_XFER_ISOC,
+                                       .maxpacksize = 0x024c,
+                                       .rates = SNDRV_PCM_RATE_44100 |
+                                                SNDRV_PCM_RATE_48000,
+                                       .rate_min = 44100,
+                                       .rate_max = 48000,
+                                       .nr_rates = 2,
+                                       .rate_table = (unsigned int[]) {
+                                               44100, 48000
+                                       }
+                               }
+                       },
+                       {
+                               .ifnum = 0,
+                               .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+                               .data = &(const struct audioformat) {
+                                       .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+                                       .channels = 2,
+                                       .iface = 0,
+                                       .altsetting = 1,
+                                       .altset_idx = 1,
+                                       .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+                                       .endpoint = 0x82,
+                                       .ep_attr = USB_ENDPOINT_XFER_ISOC,
+                                       .maxpacksize = 0x0126,
                                        .rates = SNDRV_PCM_RATE_44100 |
                                                 SNDRV_PCM_RATE_48000,
                                        .rate_min = 44100,
--
2.10.2



my asoundrc for testing purposes:


pcm.frontroute {
    type route
    slave.pcm "dmix:USB"
    ttable.0.0 1
    ttable.1.1 1
}
pcm.frontusb {
    type plug
    slave.pcm "frontroute"
    hint {
        show on
        description "USB front channels"
    }
}

pcm.rearroute {
    type route
    slave.pcm "dmix:USB"
    ttable.0.2 1
    ttable.1.3 1
}
pcm.rearusb {
    type plug
    slave.pcm "rearroute"
    hint {
        show on
        description "USB rear channels"
    }
}

pcm.micaroute {
    type route
    slave.pcm "dsnoop:USB"
    ttable.0.0 1
}
pcm.mica {
    type plug
    slave.pcm "micaroute"
    hint {
        show on
        description "Focusrite Saffire Input 1"
    }
}

pcm.micbroute {
    type route
    slave.pcm "dsnoop:USB"
    ttable.0.1 1
}
pcm.micb {
    type plug
    slave.pcm "micbroute"
    hint {
        show on
        description "Focusrite Saffire Input 2"
    }
}

pcm.!default {
    type plug
    slave {
        pcm "hw:1,0"
    }
}

ctl.!default {
    type hw
    card 1
}

<https://gist.github.com/shiona/def87540b87466fff315c4ac805c6766>
