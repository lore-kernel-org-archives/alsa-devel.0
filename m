From: "Brian J. Tarricone" <bjt23@ece.cornell.edu>
Subject: Re: [Alsa-user] sb live dma buffer alloc failure?
Date: Wed, 12 Feb 2003 18:00:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4AD20D.3070703@ece.cornell.edu>
References: <3E40BA0F.9070600@ece.cornell.edu> <s5hadh8e23e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadh8e23e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

just a quick update - i installed yesterday's cvs of alsa-driver, and i 
haven't had any problems (no alloc failures or apps locking up) since 
then.  i've tried to stress test it a bit (filling up ram, opening and 
closing the pcm device rapidly), and i'm pleased to say no problems.  i 
looked at the cvs logs, quite a bit has been done in sg_buf.c since rc7, 
perhaps something there had an impact?

even if this is just a side-effect of other work, thanks for the fix, 
guys ^_^

    -brian

Takashi Iwai wrote:

>At Wed, 05 Feb 2003 02:15:27 -0500,
>Brian J. Tarricone <bjt23@ece.cornell.edu> wrote:
>  
>
>>forgive me for cross-posting, but i've found references to this problem 
>>on both lists, so...
>>    
>>
> 
>this should go to alsa-devel, not alsa-users...
>
>  
>
>>so then i noticed rc7, and tried that (unpatched, fresh from the website).
>>
>>things are somewhat worse.  i load up xmms, and start playing mp3s.  
>>things seem fine, playing for hours until i get bored of some songs, put 
>>it on random play, and keep hitting "next song" until i find something i 
>>feel like listening to.  if i press 'next' roughly once per second, 
>>after about 15-20 songs xmms locks up hard and jumps to using 100% cpu.  
>>kill -9 doesn't work, and any other app that tries to use the pcm device 
>>locks as well.  i have to reboot to fix it.
>>    
>>
>
>which kernel version are you using?
>
>the new code on rc7 simply tries allocation via vmalloc().
>if it fails, it means that the system resource is really exhausted.
>or, there might be memory leak or so...
>
>
>Takashi
>
>  
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
