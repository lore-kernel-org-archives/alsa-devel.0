From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp driver
Date: Mon, 03 Mar 2003 11:59:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18ptF1-00055f-00@sc8-sf-list1.sourceforge.net>
References: <s5hfzq4h08x.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Mar 2003 17:40:30 +0100."
             <s5hfzq4h08x.wl@alsa2.suse.de>
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

>> they aren't. that's the whole problem. on my old system (148MB of
>> RAM), allowing fsck to run would prevent memory allocation. i don't
>> know of any distribution that inserts modules that early. do you?
>
>aha, but fsck runs even before snd-hammerfall-mem, doesn't it? (unless
>you bulit it in kernel)  otherwise it's dangerous...

no. absolutely not. i just added something equivalent to this to
/etc/rc.d/rc.sysinit, right before fsck runs.

   insmod snd-hammerfall-mem

since snd-hammerfall-mem has nothing to do with filesystems on disk,
there is no danger. many other hammerfall users are doing equivalent
things, and its also necessary under windows and macos.

>now i understood the necessity of the allocation way of
>snd-hammerfall-mem.  we can merge the feature but it will be likely
>after 0.9.0, as long as the old style works.  i'd like to concentrate
>on bug fixes now.

as long as you propose to leave snd-hammerfall-mem in
place. otherwise, you will make it impossible for many people to use
their audio interfaces!

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
