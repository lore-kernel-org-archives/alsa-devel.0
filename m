From: Gregor Jasny <jasny@vidsoft.de>
Subject: Need help with patch for #2724 (usbaudio, core)
Date: Sat, 27 Jan 2007 14:24:45 +0100
Message-ID: <20070127132445.GA11859@vidsoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've tried to write a patch for bug #2724. The problem is that some
Logitech webcams have interface alternatives with a rate of 0:

  Interface 3
    Altset 1
    Format: 0x2
    Channels: 1
    Endpoint: 6 IN (ASYNC)
    Rates: 0
  Interface 3
    Altset 2
    Format: 0x2
    Channels: 1
    Endpoint: 6 IN (ASYNC)
    Rates: 0
  Interface 3
    Altset 3
    Format: 0x2
    Channels: 1
    Endpoint: 6 IN (ASYNC)
    Rates: 16000

The ALSA Kernel driver seems to be somewhat unhappy about this and
oopses in snd_interval_list which gets called with:

i: dc4f0928 count: 3635438588 list: ffffffff mask 4294967295

I've tried to track down the origin of -1 in constraint_list->list but got
lost in the depths of the hw param stuff.

The attached patch skips all alternatives with no valid rates. With this
patch my Quickcam 5000 works like a charm. But I'm unsure if this is the
right approach to fix this bug.

I think the right way to go is to fix also the cause of the oops, so
that the ALSA core doesn't oops when no valid rate is given.

Thanks for your comments,
Gregor

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="logitech.diff"

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 19bdcc7..661e557 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2455,7 +2455,7 @@ static int parse_audio_format_rates(struct snd_usb_audio *chip, struct audioform
 		/*
 		 * build the rate table and bitmap flags
 		 */
-		int r, idx, c;
+		int r, idx, c, nonzero_rates = 0;
 		/* this table corresponds to the SNDRV_PCM_RATE_XXX bit */
 		static unsigned int conv_rates[] = {
 			5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
@@ -2478,6 +2478,7 @@ static int parse_audio_format_rates(struct snd_usb_audio *chip, struct audioform
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
 			fp->rate_table[r] = rate;
+                        nonzero_rates |= rate;
 			if (rate < fp->rate_min)
 				fp->rate_min = rate;
 			else if (rate > fp->rate_max)
@@ -2493,6 +2494,10 @@ static int parse_audio_format_rates(struct snd_usb_audio *chip, struct audioform
 			if (!found)
 				fp->needs_knot = 1;
 		}
+                if (!nonzero_rates) {
+                        hwc_debug("No rate was nonzero. Skipping format!\n");
+                        return -1;
+                }
 		if (fp->needs_knot)
 			fp->rates |= SNDRV_PCM_RATE_KNOT;
 	} else {

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--C7zPtVaVf+AK4Oqc--
