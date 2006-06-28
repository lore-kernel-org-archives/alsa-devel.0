From: Lee Revell <rlrevell@joe-job.com>
Subject: Make wav the default for speaker test
Date: Wed, 28 Jun 2006 13:21:54 -0400
Message-ID: <1151515314.15513.36.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

I think it's nicer to have the sampled voice be the default for
speaker-test.  Any objections?

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- speaker-test/speaker-test.c~	2006-06-09 16:53:29.000000000 -0400
+++ speaker-test/speaker-test.c	2006-06-28 13:19:57.000000000 -0400
@@ -76,7 +76,7 @@
 static unsigned int       period_time = 0;	            /* period time in us */
 static unsigned int       nperiods    = 4;                  /* number of periods */
 static double             freq        = 440;                /* sinusoidal wave frequency in Hz */
-static int                test_type   = TEST_PINK_NOISE;    /* Test type. 1 = noise, 2 = sine wave */
+static int                test_type   = TEST_WAV;    /* Test type. 1 = noise, 2 = sine wave, 3 = voice */
 static pink_noise_t pink;
 static snd_pcm_uframes_t  buffer_size;
 static snd_pcm_uframes_t  period_size;



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
