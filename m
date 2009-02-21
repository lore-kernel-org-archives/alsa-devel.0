From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: ALSA: fix excessive background noise introduced by OSS emulation
	rate shrink
Date: Sat, 21 Feb 2009 08:05:04 -0600
Message-ID: <1235225104.3144.114.camel@linux-1lbu.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: patch-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, DaVinci <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


Incorrect variable was used to get the next sample which caused S2
to be stuck with the same value resulting in loud background noise.

Signed-off-by: Steve Chen <schen at mvista.com>

diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
index a466443..2fa9299 100644
--- a/sound/core/oss/rate.c
+++ b/sound/core/oss/rate.c
@@ -157,7 +157,7 @@ static void resample_shrink(struct snd_pcm_plugin *plugin,
 		while (dst_frames1 > 0) {
 			S1 = S2;
 			if (src_frames1-- > 0) {
-				S1 = *src;
+				S2 = *src;
 				src += src_step;
 			}
 			if (pos & ~R_MASK) {
