From: Gregor Jasny <jasny@vidsoft.de>
Subject: Re: Need help with patch for #2724 (usbaudio, core)
Date: Wed, 31 Jan 2007 12:22:19 +0100
Message-ID: <45C07BEB.1050209@vidsoft.de>
References: <20070127132445.GA11859@vidsoft.de> <s5hbqkgv4eu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070605000903000100050604"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqkgv4eu.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070605000903000100050604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> This is the right fix, too.  Of course, pcm-core should be more
> robust, but the cause of the bug is the bogus entry.

Your patch does not change anything. I've enabled 
CONFIG_SND_VERBOSE_PRINTK, CONFIG_SND_DEBUG and CONFIG_SND_DEBUG_DETECT 
in the kernel config.

None of your snd_printd output gets triggered. I've placed a test output 
in pcm-native, so debugging works.

Note that I've applied your patch to 2.6.19.2.

> The patch looks fine to me.  Please provide a proper changelog and a
> sign-off for merging.

Done. The patch is against the current hg snapshot of alsa-kernel.

Gregor

--------------070605000903000100050604
Content-Type: text/plain;
 name="prevent-zero-rates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prevent-zero-rates.diff"

From: Gregor Jasny <gjasny@web.de>

This is a patch for ALSA Bug #2724. Some webcams provide bogus
settings with no valid rates. With this patch those are skipped.

Signed-off-by: Gregor Jasny <gjasny@web.de>
diff -r b4265ee02e26 usb/usbaudio.c
--- a/usb/usbaudio.c	Wed Jan 31 10:35:19 2007 +0100
+++ b/usb/usbaudio.c	Wed Jan 31 12:20:29 2007 +0100
@@ -2463,6 +2463,7 @@ static int parse_audio_format_rates(stru
 		 * build the rate table and bitmap flags
 		 */
 		int r, idx, c;
+		unsigned int nonzero_rates = 0;
 		/* this table corresponds to the SNDRV_PCM_RATE_XXX bit */
 		static unsigned int conv_rates[] = {
 			5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
@@ -2485,6 +2486,7 @@ static int parse_audio_format_rates(stru
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
 			fp->rate_table[r] = rate;
+			nonzero_rates |= rate;
 			if (rate < fp->rate_min)
 				fp->rate_min = rate;
 			else if (rate > fp->rate_max)
@@ -2499,6 +2501,10 @@ static int parse_audio_format_rates(stru
 			}
 			if (!found)
 				fp->needs_knot = 1;
+		}
+		if (!nonzero_rates) {
+			hwc_debug("All rates were zero. Skipping format!\n");
+			return -1;
 		}
 		if (fp->needs_knot)
 			fp->rates |= SNDRV_PCM_RATE_KNOT;

--------------070605000903000100050604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------070605000903000100050604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070605000903000100050604--
