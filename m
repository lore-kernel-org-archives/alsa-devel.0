From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp driver
Date: Mon, 03 Mar 2003 11:37:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18pst9-00007a-00@sc8-sf-list1.sourceforge.net>
References: <s5hk7fgh1iw.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Mar 2003 17:12:55 +0100."
             <s5hk7fgh1iw.wl@alsa2.suse.de>
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

>At Mon, 03 Mar 2003 11:11:16 -0500,
>Paul Davis wrote:
>> 
>> >although the former doesn't allocate the buffer in advance by checking
>> >the pci id, but it will preserve the buffers at alsasound stop or
>> >restart operations just like the latter does.
>> 
>> so when does it allocate them?
>
>when the allocator function (snd_malloc_xxx) is called from the
>driver.  so, it wouldn't work exactly like snd-hammerfall-mem, which
>allocates by itself without call from the sound drivers.
>snd-page-alloc module just "caches" the buffer after the module
>unload/reload.
>
>but i don't think this would make so big difference, since the sound
>drivers are loaded likely in the early stage, anyway.

they aren't. that's the whole problem. on my old system (148MB of
RAM), allowing fsck to run would prevent memory allocation. i don't
know of any distribution that inserts modules that early. do you?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
