From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: PATCH: snd_pcm_playback_silence
Date: Thu, 11 Apr 2002 17:16:28 +0200 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204111513.g3BFDsK4093415@smtpzilla1.xs4all.nl>
References: <Pine.BSF.4.44.0203081354580.28275-100000@fest.stud.fee.vutbr.cz>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.BSF.4.44.0203081354580.28275-100000@fest.stud.fee.vutbr.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm currently porting ALSA to OS/2 and have encountered a bug in
snd_pcm_playback_silence (core\pcm_lib.c)
While playing an 8 bits stereo 44.1khz wave file the system
would trap when stopping the stream. The cause was heap
corruption caused by this function. There is no check to
see if the offset + amount of frames to silence is larger
than the buffer size.
The patch below fixes this.

Sander



--- E:\Development\ALSA.Linux\alsa-kernel\core\pcm_lib.c	Wed Apr 10 21:55:18 2002
+++ E:\Development\ALSA.OS2\GPL\alsa\core\pcm_lib.c	Thu Apr 11 17:01:38 2002
@@ -60,6 +56,12 @@
 	ofs = runtime->silenced_start % runtime->buffer_size + runtime->silenced_size;
 	if (ofs >= runtime->buffer_size)
 		ofs -= runtime->buffer_size;
+#ifdef TARGET_OS2
+        if (ofs + frames > runtime->buffer_size) {
+                frames = runtime->buffer_size - ofs;
+        }
+#endif
 	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
 		if (substream->ops->silence) {
