From: Paul Davis <pbd@op.net>
Subject: Re: ALSA crash
Date: Fri, 19 Jul 2002 08:02:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17VWQy-0005Mb-00@usw-sf-list1.sourceforge.net>
References: <3D37F5B8.AE18A86B@multitech.co.in>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 19 Jul 2002 16:49:20 +0530."
             <3D37F5B8.AE18A86B@multitech.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Shaju Abraham <shaju@multitech.co.in>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi,
>        Pls check the attached file that is dmesg of a ALSA crash. Can
>you pls tell under what conditions this happens?
>
>Another thing ... in pcm_lib.c , for the funtion  snd_pcm_update_hw_ptr.
>, there is a comment that "this should be called with interrupts
>disabled". Can you tell us who is disabling the interrupts just before
>this is called?
>
>Does spin_lock_irq do that?

sort of. but the main and usually only place where
snd_pcm_update_hw_ptr is called is from the interrupt handler for the
audio interface, which is called with interrupts disabled by the
kernel.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
