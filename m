From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp driver
Date: Mon, 03 Mar 2003 14:11:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18pvIk-0002G6-00@sc8-sf-list1.sourceforge.net>
References: <s5h7kbggyy9.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Mar 2003 18:08:30 +0100."
             <s5h7kbggyy9.wl@alsa2.suse.de>
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

>> since snd-hammerfall-mem has nothing to do with filesystems on disk,
>> there is no danger.
>
>as long as the snd-hammerfall-mem module itself on the filesystem is 
>not broken.  it may happen not rarely if the filesystem crashed just
>after (or during) installing the new module files.

when this is done (pre-fsck), only / is mounted, and its mounted
read-only. nothing can happen.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
