From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Bug in pcm_lib.c ?? (using Xmms)
Date: Mon, 09 Dec 2002 01:59:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF3EAFE.9000709@cucumelo.org>
References: <Pine.LNX.4.33.0212081905470.629-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>It's definitely a bug in CS46xx driver. I've changed the test for the ring 
>buffer pointer to be in range 0 .. buffer_size-1 . pointer equal to 
>buffer_size doesn't make any sense and it should be really zero.
>
>  
>
I guess I found a fix for this problem (at least the message disapears 
from the log)
in cs46xx_lib.c in snd_cs46xx_playback_indirect_pointer(...) function:


    if (bytes < 0)
        bytes += buffer_size;
    cpcm->hw_io = ptr;
    cpcm->hw_ready -= bytes;
    cpcm->sw_io += bytes;
-    if (cpcm->sw_io > cpcm->sw_bufsize)
+    if (cpcm->sw_io >= cpcm->sw_bufsize)
        cpcm->sw_io -= cpcm->sw_bufsize;
    snd_cs46xx_playback_transfer(substream, 0);

I cant hear any difference in sound quality, maybe it's just not posible 
to hear the difference ...
... and now it's too late, i'll continue tomorrow ...

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
