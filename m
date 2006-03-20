From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: Any missing patches?
Date: Mon, 20 Mar 2006 22:15:03 +0100
Message-ID: <87k6aoom20.fsf@blackdown.de>
References: <s5hmzfl9cql.wl%tiwai@suse.de> <877j6oq38m.fsf@blackdown.de>
	<s5h8xr4amkw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xr4amkw.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	20 Mar 2006 21:27:27 +0100")
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Mon, 20 Mar 2006 21:18:33 +0100,
> Juergen Kreileder wrote:
>> BTW: Is it normal that the dmix plug-in consumes 100% CPU?
>
> No, it's a new problem.  Looks like happening only on ppc.
> Did it happen with the older kernel, too?

I'm not sure if it started with a kernel update or with the
introduction of dmix in PMac.conf.

> Anyway, the below are two different patches as workarounds.
> Could you test if either of them has any influence?

alsa-lib-pcm-timer-tread-for-ppc.diff works.  The other patch had no
effect.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
