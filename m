From: Tim Goetze <tim@quitte.de>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Thu, 19 Sep 2002 17:19:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209191715140.595-100000@summer.quitte>
References: <s5h3cs6qag7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cs6qag7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 19 Sep 2002 17:06:08 +0200 (CEST),
>Tim Goetze wrote:
>> 
>> much simpler. you did a c++ style auto variable allocation, declare
>> 'ak' at the start of snd_ice1712_ews_init and it compiles cleanly.
>
>oops, never noticed that.  i relied too much upon the compiler.
>well, this means that gcc-3.2 accepts this style as normal C...?

strange that 3.2 isn't ANSI C compliant here.

anyway, driver load/unload, midi and pcm work with the audiophile
after sorting this out.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
