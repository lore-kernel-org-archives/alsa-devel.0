From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: sequencer queue PCM timing drift
Date: Thu, 1 Jul 2004 16:11:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407011611.43466.cannam@all-day-breakfast.com>
References: <200405131416.54774.cannam@all-day-breakfast.com> <200407011352.01194.cannam@all-day-breakfast.com> <Pine.LNX.4.58.0407011434490.1553@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vmC5AlFy2P/4fts"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0407011434490.1553@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_vmC5AlFy2P/4fts
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 01 Jul 2004 1:42 pm, Jaroslav Kysela wrote:
> It looks like a rounding problem:
> [...]
> Look to snd_pcm_timer_resolution_change() in pcm_timer.c for more
> details.

Right, that function doesn't work well for 44100/1024 in 32 bits -- it 
ends up trying to calculate 1e7 * 1024 / 441 and having to divide 
both numerator and denominator by 4 (thus losing the rather crucial 1 
at the end of 441) before it can do the calculation without overflow.

Attached is a patch against 1.0.5a that gets better results in this 
instance, by leaving the denominator alone and instead doubling the 
result back up by the same number of times as the multiplier had to 
be halved by.


Chris

--Boundary-00=_vmC5AlFy2P/4fts
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pcm_timer_drift_44100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcm_timer_drift_44100.patch"

--- pcm_timer.c.~1~	2004-03-23 08:37:09.000000000 +0000
+++ pcm_timer.c	2004-07-01 15:50:07.000000000 +0100
@@ -49,7 +49,7 @@
 
 void snd_pcm_timer_resolution_change(snd_pcm_substream_t *substream)
 {
-	unsigned long rate, mult, fsize, l;
+	unsigned long rate, mult, fsize, l, post;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	
         mult = 1000000000;
@@ -63,16 +63,17 @@
 	l = gcd(rate, fsize);
 	rate /= l;
 	fsize /= l;
+	post = 1;
 	while ((mult * fsize) / fsize != mult) {
 		mult /= 2;
-		rate /= 2;
+		post *= 2;
 	}
 	if (rate == 0) {
 		snd_printk(KERN_ERR "pcm timer resolution out of range (rate = %u, period_size = %lu)\n", runtime->rate, runtime->period_size);
 		runtime->timer_resolution = -1;
 		return;
 	}
-	runtime->timer_resolution = mult * fsize / rate;
+	runtime->timer_resolution = (mult * fsize / rate) * post;
 }
 
 static unsigned long snd_pcm_timer_resolution(snd_timer_t * timer)

--Boundary-00=_vmC5AlFy2P/4fts--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
