From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx Phase reversal fixes and some AC3
 pass through progress
Date: Mon, 09 Dec 2002 22:06:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF505CD.5050807@cucumelo.org>
References: <3DF3DFD9.2060002@cucumelo.org> <s5hptsb8loj.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>the spdif output on my terratec x-fire seems working fine now, at
>least for the normal playback.  however, if i stop the playback in the
>  
>
>middle, it results in a constant beep.  does happen on another card?
>

It has not happen for me (yet)

Sounds like there some garbage left in some sample buffer.
Did you use the IEC958 PCM device (aplay -Dhw:0,2)  or just turn on the
SPDIF output switch in mixer ???

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
