From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: crash trace under gdb
Date: Fri, 09 May 2003 10:31:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19E8qm-0005hC-00@sc8-sf-list1.sourceforge.net>
References: <s5hd6isb3m1.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 09 May 2003 16:23:50 +0200."
             <s5hd6isb3m1.wl@alsa2.suse.de>
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

>IIRC, your machine is SMP, right?
>if it's related lock, it might be related with the recent change of
>handling of linked pcm streams...

yes, its SMP. that's what i suspected. i can't compare anything right
now, because sf.net is doing its cvs-blockout stuff. when, oh when
will i remember to always archive my alsa CVS tree before updating?

>> ctrl-alt-sysreq couldn't provide a trace more than 1 call back. not
>> sure why.
>
>how about alt-sysrq-T ?

ah, right, i should have tried that. i'll see if i feel like crashing
my machine again rather than working on automation line editing for
ardour :)


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
