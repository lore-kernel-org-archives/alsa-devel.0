From: Carlo Wood <carlo@alinoe.com>
Subject: [PATCH] OSS Layer: restart stream after xrun once stream is drained.
Date: Sun, 13 Jul 2003 04:38:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030713023847.GA7992@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "xvoice@yahoogroups.com" <xvoice@yahoogroups.com>, "kai.vehmanen@wakkanet.fi" <kai.vehmanen@wakkanet.fi>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2003 at 08:56:16PM +0200, Jaroslav Kysela wrote:
> Yes, but at another level - in the OSS emulation code.
> 
> > What is the correct way to recover from this, to continue
> > recording in this case, after the xrun?
> 
> Call read() or poll(POLLIN) again. I think that your problem might be that 
> poll(POLLIN) does not trigger the input in the current ALSA code. Please, 
> try this patch with ViaVoice (the patch is also in the ALSA CVS tree):

Hi Jaroslav,

I wrote a patch for sound/core/oss/pcm_oss.c, that fixes the ViaVoice
problem.

Problem:

When an xrun happens, the stream is stopped.
The OSS layer (read1) changes the xrun state into a draining state,
but never restarts the stream.

This patch restart the stream once so much had been drained
from the stream that less than one fragement remains.
It is not safe to wait till the stream is empty (although it should
be when the application only reads full fragments) because it
might be that the application only calls read() when there is
at least one fragment ... kind of a contradiction, but then
why not like this.


--- linux-2.5.74/sound/core/oss/pcm_oss.c	2003-07-13 04:01:16.000000000 +0200
+++ linux-2.5.74-debug/sound/core/oss/pcm_oss.c	2003-07-13 04:23:52.260709528 +0200
@@ -627,8 +627,21 @@
 			}
 			continue;
 		}
-		if (ret != -ESTRPIPE)
+		if (ret != -ESTRPIPE) {
+			if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+				snd_pcm_status_t status;
+				memset(&status, 0, sizeof(status));
+				int err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_STATUS, &status);
+				if (!err && status.avail < runtime->period_size) {
+					err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_PREPARE, 0);
+					if (!err)
+						snd_pcm_start(substream);
+				}
+				if (err < 0)
+					ret = err;
+			}
 			break;
+		}
 	}
 	return ret;
 }


The attached test program gives, WITHOUT this patch the following output
(This test case reads SLOW, to make sure that xruns happen frequently):

gment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 1024
Number of bytes that can be read or written immediately without blocking: 0
space: bytes = 32, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 1056, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 30635.751683
space: bytes = 928, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2016, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 16124.799227
space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
[...]

WITH the above patch it does this:

Fragment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 1024
Number of bytes that can be read or written immediately without blocking: 0
space: bytes = 32, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 1088, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 29704.837189
space: bytes = 928, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 14847.537252
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 15708.954795
space: bytes = 800, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 12830.954678
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 13536.438665
space: bytes = 832, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 12074.536003
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 12573.210712
space: bytes = 832, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11650.397069
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 12040.231304
space: bytes = 928, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11327.103292
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11590.736089
space: bytes = 928, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11034.144344
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11272.664653
space: bytes = 992, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 10823.670013
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11022.745850
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11211.084341
space: bytes = 1056, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11387.316413
space: bytes = 1056, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11569.761392
space: bytes = 960, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11186.543811
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11377.988481
space: bytes = 864, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11060.036340
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11234.400773
space: bytes = 864, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 10955.674898
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11107.524306
space: bytes = 896, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 10858.584314
space: bytes = 1024, periods = 1, fragstotal = 2, fragsize = 1024
Read 1024 bytes.  Average bytes/second read: 11011.375394
space: bytes = 864, periods = 0, fragstotal = 2, fragsize = 1024
space: bytes = 2048, periods = 2, fragstotal = 2, fragsize = 1024
[...etc...]

The real rate being 8000, we have 16 kb/s of input
from the soundcard, but only read (on average) 11 kb/s, from
which we can conclude that the stream is stopped 31% of the time.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
