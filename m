From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: crash trace under gdb
Date: Fri, 09 May 2003 11:39:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19E9uR-0003ox-00@sc8-sf-list1.sourceforge.net>
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

>how about alt-sysrq-T ?

all this "proves" is that yes, its the lock code because we're running
in interrupt context, not in process context. 

so something in the code jaroslav added is broken, at least for SMP.

i just hope sf.net will let me get my hands on an older copy so i can
keep working ...



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
