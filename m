From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Fri, 14 Jan 2005 11:59:39 +0100
Message-ID: <87hdlk9sys.fsf@blackdown.de>
References: <20050106130649.GA253131@lion.gg3.net>
	<s5h1xcxy0tj.wl@alsa2.suse.de> <20050108074026.GA8595@lion.gg3.net>
	<s5h7jmlv82j.wl@alsa2.suse.de> <20050110123342.GA243173@lion.gg3.net>
	<s5hwtultnc8.wl@alsa2.suse.de> <20050110161559.GA248292@lion.gg3.net>
	<s5h7jmkt8j9.wl@alsa2.suse.de> <20050112022402.GB9290@lion.gg3.net>
	<87wtuga67g.fsf@blackdown.de> <s5h4qhk8fx8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.blackdown.de (smtp.blackdown.de [213.239.206.42])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE92E283
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2005 11:59:41 +0100 (MET)
In-Reply-To: <s5h4qhk8fx8.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
	14 Jan 2005 11:26:43 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> Hmm.  The change was to fix alignment on x86-64 on the contrary.
> When we put s64 there, it breaks.

Ah, I see.

> > OK, I'll add it with ifdef CONFIG_PPC64.

You might want to check how other architectures align long longs in
32-bit mode.  At least SPARC uses mod 8 too.
How about #ifndef CONFIG_X86_64?


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux/java2-status/


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
