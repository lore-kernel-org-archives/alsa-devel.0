From: Samuel S Chessman <chessman@tux.org>
Subject: alsa-driver/core hwdep patch
Date: Sat, 9 Mar 2002 15:50:47 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.30.0203091541080.697-100000@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I made the latest CVS and sbawe failed to insmod.  Tracking down the
missing definition led me to hwdep.o, which is from alsa-kernel/core
Adding the hwdep.o to the Makefile corrects the insmod failure.

Please let me know if I misunderstand. I am making in alsa-driver which
includes the ../../alsa-kernel/core/Makefile so that looks like where hwdep
should be added.

--- /u01/alsa/alsa-cvs/alsa-kernel/core/Makefile        Sat Mar  9 09:37:13 2002
+++ alsa-kernel/core/Makefile   Sat Mar  9 15:38:47 2002
@@ -79,8 +79,8 @@
 obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_OPTI93X) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_SB8) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SB16) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_SBAWE) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
+obj-$(CONFIG_SND_SB16) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_SBAWE) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ES968) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_WAVEFRONT) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ALS4000) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o


-- 
   Sam Chessman                                               chessman@tux.org
    First do what's necessary, then what's possible, finally the impossible.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
