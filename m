From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: Re: Alsa 0.9.0 RC5 + RH8 + GnomeMeeting
Date: Fri, 08 Nov 2002 15:43:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCBCD7F.3050604@gmx.at>
References: <1036673221.17759.28.camel@heraclite>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000503020207020607080704"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Damien Sandras <dsandras@seconix.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000503020207020607080704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Damien Sandras wrote:
> I subscribed to this mailing list, because GnomeMeeting users have
> reported a problem using ALSA 0.9.0RC5 together with GnomeMeeting and
> RedHat 8.0.
> 
> Actually, the problem is simple to explain, hard to fix, at least for
> me. Several users complained that using GnomeMeeting was freezing their
> machine. This corresponds to a driver bug, somewhere, as "user-space"
> programs can't crash a machine directly. The only particularity of
> GnomeMeeting is that it is reading and writing to the device at the same
> time.

I had similar problems. A patch from Jaroslav Kysela fixed the problem 
for me (see attachment).

> 
> Thanks,

bye,
Wilfried

--------------000503020207020607080704
Content-Type: text/plain;
 name="pcm_oss.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_oss.c.diff"

===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
retrieving revision 1.21
retrieving revision 1.22
diff -u -r1.21 -r1.22
--- alsa/alsa-kernel/core/oss/pcm_oss.c	2002/10/21 18:28:20	1.21
+++ alsa/alsa-kernel/core/oss/pcm_oss.c	2002/10/30 20:29:15	1.22
@@ -564,7 +564,15 @@
 		} else {
 			ret = snd_pcm_lib_read(substream, ptr, frames);
 		}
-		if (ret != -EPIPE && ret != -ESTRPIPE)
+		if (ret == -EPIPE) {
+			if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+				ret = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, 0);
+				if (ret < 0)
+					break;
+			}
+			continue;
+		}
+		if (ret != -ESTRPIPE)
 			break;
 	}
 	return ret;

--------------000503020207020607080704--



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
