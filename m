From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Bug in pcm_lib.c ?? (using Xmms)
Date: Sun, 08 Dec 2002 23:25:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF3C6E3.4070909@cucumelo.org>
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
I believe that this is not a new bug, just undiscovered with previous 
releases.
For the moment I got no idea what possibly could be wrong, depending on
which appl. used it only a few times when playbacking a stream.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
