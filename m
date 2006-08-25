From: Luke Ross <luke@lukeross.name>
Subject: [PATCH] Support for non-standard rates in USB audio
	driver
Date: Sat, 26 Aug 2006 00:29:59 +0100
Message-ID: <20060825232959.GA4523@lukeross.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

There's at least one USB audio chipset out there which supports only one 
non-standard rate (ID 0e6a:0310 supports 46875Hz). There's a few other 
patches for this card which are unsatisfactory because they attempt to 
map this rate to 44.1k leading to sound distortion.

The patch below uses SNDRV_PCM_RATE_KNOT to properly support the 
non-standard rates where they are available.

Cheers,

Luke

--- usbaudio.c.b4	2006-08-05 15:22:17.000000000 +0100
+++ usbaudio.c	2006-08-05 15:05:43.000000000 +0100
@@ -119,6 +119,7 @@
 	unsigned int rate_min, rate_max;	/* min/max rates */
 	unsigned int nr_rates;		/* number of rate table entries */
 	unsigned int *rate_table;	/* rate table */
+	unsigned int needs_knot;	/* any unusual rates? */
 };
 
 struct snd_usb_substream;
@@ -1727,6 +1728,8 @@
 		}
 		channels[f->format] |= (1 << f->channels);
 		rates[f->format] |= f->rates;
+		/* needs knot? */
+		if (f->needs_knot) goto __out;
 	}
 	/* check whether channels and rates match for all formats */
 	cmaster = rmaster = 0;
@@ -1767,6 +1770,35 @@
 	return err;
 }
 
+/*
+ *  If the device supports unusual bit rates, does the request meet these?
+ */
+static int snd_usb_pcm_check_knot(struct snd_pcm_runtime *runtime, struct snd_usb_substream *subs)
+{
+	struct list_head *p;
+	struct snd_pcm_hw_constraint_list constraints_rates;
+	int err;
+
+	list_for_each(p, &subs->fmt_list) {
+		struct audioformat *fp;
+		fp = list_entry(p, struct audioformat, list);
+
+		if (!fp->needs_knot) continue;
+
+		constraints_rates.count = fp->nr_rates;
+		constraints_rates.list = fp->rate_table;
+		constraints_rates.mask = 0;
+
+		err = snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_rates);
+
+		if (err < 0) return err;
+	}
+
+	return 0;
+}
+
 
 /*
  * set up the runtime hardware information.
@@ -1829,6 +1861,8 @@
 					       SNDRV_PCM_HW_PARAM_CHANNELS,
 					       -1)) < 0)
 			return err;
+		if ((err = snd_usb_pcm_check_knot(runtime, subs)) < 0)
+			return err;
 	}
 	return 0;
 }
@@ -2366,6 +2401,7 @@
 				    unsigned char *fmt, int offset)
 {
 	int nr_rates = fmt[offset];
+	int found = 0;
 	if (fmt[0] < offset + 1 + 3 * (nr_rates ? nr_rates : 2)) {
 		snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting);
@@ -2388,6 +2424,7 @@
 			return -1;
 		}
 
+		fp->needs_knot = 0;
 		fp->nr_rates = nr_rates;
 		fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
 		for (r = 0, idx = offset + 1; r < nr_rates; r++, idx += 3) {
@@ -2396,13 +2433,19 @@
 				fp->rate_min = rate;
 			else if (rate > fp->rate_max)
 				fp->rate_max = rate;
+			found = 0;
 			for (c = 0; c < (int)ARRAY_SIZE(conv_rates); c++) {
 				if (rate == conv_rates[c]) {
+					found = 1;
 					fp->rates |= (1 << c);
 					break;
 				}
 			}
+			if (!found) {
+				fp->needs_knot = 1;
+			}
 		}
+		if (fp->needs_knot) fp->rates |= SNDRV_PCM_RATE_KNOT;
 	} else {
 		/* continuous rates */
 		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
