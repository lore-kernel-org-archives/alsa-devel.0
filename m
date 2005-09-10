From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Current alsa-driver CVS fails to compile.
Date: Sat, 10 Sep 2005 13:45:29 +0100
Message-ID: <4322D569.3030206@superbug.co.uk>
References: <4322A508.6080904@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4322A508.6080904@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have just fixed this in CVS.
diff -u -r1.13 sound.inc
--- alsa-driver/acore/sound.inc 9 Sep 2005 12:52:51 -0000       1.13
+++ alsa-driver/acore/sound.inc 10 Sep 2005 12:43:12 -0000
@@ -40,7 +40,7 @@
  EXPORT_SYMBOL(snd_compat_kstrdup);
  #endif
  #endif
-#ifndef CONFIG_HAVE_KCALLOC
+#ifndef CONFIG_HAVE_KZALLOC
  #ifndef CONFIG_SND_DEBUG_MEMORY
  EXPORT_SYMBOL(snd_compat_kzalloc);
  #endif


James Courtier-Dutton wrote:
> Here are the messages:
> I am running vanilla 2.6.13 kernel.
> 
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/synth/snd-util-mem.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/synth/emux/snd-emux-synth.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/pci/emu10k1/snd-emu10k1.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/pci/ac97/snd-ac97-codec.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/snd-timer.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/snd-rawmidi.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/snd-pcm.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/snd-hwdep.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/snd-seq.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/snd-seq-virmidi.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/snd-seq-midi.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/snd-seq-midi-event.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/snd-seq-device.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/seq/oss/snd-seq-oss.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/oss/snd-pcm-oss.ko] undefined!
> *** Warning: "snd_compat_kzalloc" 
> [/u/alsacvs/alsa-driver/acore/oss/snd-mixer-oss.ko] undefined!
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
