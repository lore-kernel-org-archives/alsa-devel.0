From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA driver 1.0.2c: divide by zero oops
Date: Tue, 23 Mar 2004 09:49:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403230947340.2186@pnote.perex-int.cz>
References: <200403230551.i2N5pVG01799@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403230551.i2N5pVG01799@auster.physics.adelaide.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Mar 2004, Jonathan Woithe wrote:

> > Could you add exactly same initialization sequence to 
> > alsa-oss/test/testoss.c code? So we can debug easily the problem here.
> 
> Sorry, I couldn't see where this would fit in in this file - testoss.c seems
> more like it's testing the oss redirector though.  The bug I'm seeing is in
> software which uses the oss emulation layer directly (that is, it accesses
> /dev/dsp with no knowledge of ALSA).

This code uses also directly the OSS layer.

> This program's output with ALSA when XX==16 (with alsa debug mode preventing
> divide by zero):
>    params: fragments=2 fragstotal=2 fragsize=32768 bytes=65536

The reason for oops is simple: The period is too much big to store 
resolution in the 32-bit value. The bellow patch fixed the oops, but
it's still not perfect solution (PCM slave timer resolution will be broken 
in this case):


Index: pcm_timer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_timer.c,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- pcm_timer.c	13 Aug 2002 16:13:34 -0000	1.6
+++ pcm_timer.c	23 Mar 2004 08:37:09 -0000	1.7
@@ -32,9 +32,9 @@
  */
 
 /* Greatest common divisor */
-static int gcd(int a, int b)
+static unsigned long gcd(unsigned long a, unsigned long b)
 {
-	int r;
+	unsigned long r;
 	if (a < b) {
 		r = a;
 		a = b;
@@ -49,7 +49,7 @@
 
 void snd_pcm_timer_resolution_change(snd_pcm_substream_t *substream)
 {
-	unsigned int rate, mult, fsize, l;
+	unsigned long rate, mult, fsize, l;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	
         mult = 1000000000;
@@ -67,7 +67,11 @@
 		mult /= 2;
 		rate /= 2;
 	}
-	snd_assert(rate != 0, return);
+	if (rate == 0) {
+		snd_printk(KERN_ERR "pcm timer resolution out of range (rate = %u, period_size = %lu)\n", runtime->rate, runtime->period_size);
+		runtime->timer_resolution = -1;
+		return;
+	}
 	runtime->timer_resolution = mult * fsize / rate;
 }
 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
