From: Vince Busam <vince@sixpak.org>
Subject: Fix for slow snd-ali5451 initialization
Date: Sat, 5 Nov 2005 11:38:03 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The snd-ali5451 driver takes 10 seconds to load, which is quite annoying 
on a laptop that boots every day.  This patch lowers that to a much more 
managable time, and still works fine on my laptop.

Vince

     Summary: Speed up ali5451 initialization

     The patch speeds up loading the ali5451 driver by lowering the
     wait time in snd_ali_codec_ready()

     Author: Vince Busam <vince@sixpak.org
     Signed-off-by: Vince Busam <vince@sixpak.org>

--- linux-source-2.6.12/sound/pci/ali5451/ali5451.c	2005-10-10 05:12:34.000000000 -0700
+++ linux-source-2.6.12-new/sound/pci/ali5451/ali5451.c	2005-11-05 11:25:11.000000000 -0800
@@ -399,7 +399,7 @@ static int snd_ali_codec_ready(	ali_t *c
  	unsigned long end_time;
  	unsigned int res;

-	end_time = jiffies + 10 * (HZ >> 2);
+	end_time = jiffies + 10 * (HZ >> 6);
  	do {
  		res = snd_ali_5451_peek(codec,port);
  		if (! (res & 0x8000))

-- 
Vince Busam
vince@sixpak.org
http://sixpak.org/vince/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
