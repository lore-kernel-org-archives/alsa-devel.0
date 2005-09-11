From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [alsa-lib patch] src/pcm/pcm_hooks.c : fix segfault then hooks list is
 empty
Date: Sun, 11 Sep 2005 19:36:45 +0300
Message-ID: <20050911163645.GA28989@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de>
 <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de>
 <20050907160343.GA3375@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050907160343.GA3375@sashak.softier1.local>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


This fix prevents segfaulting then hooks list is empty.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-lib/src/pcm/pcm_hooks.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_hooks.c,v
retrieving revision 1.38
diff -u -p -r1.38 pcm_hooks.c
--- alsa-lib/src/pcm/pcm_hooks.c	23 May 2005 09:03:18 -0000	1.38
+++ alsa-lib/src/pcm/pcm_hooks.c	11 Sep 2005 14:17:29 -0000
@@ -469,7 +469,7 @@ int _snd_pcm_hooks_open(snd_pcm_t **pcmp
 		return err;
 	}
 	if (!hooks)
-		return 0;
+		goto _done;
 	snd_config_for_each(i, next, hooks) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *str;
@@ -488,6 +488,7 @@ int _snd_pcm_hooks_open(snd_pcm_t **pcmp
 			return err;
 		}
 	}
+ _done:
 	*pcmp = rpcm;
 	return 0;
 }


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
