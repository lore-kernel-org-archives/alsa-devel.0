From: "David Parker" <david@neongoat.com>
Subject: Re: Trident problems.
Date: Tue, 16 Sep 2003 23:08:16 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <twig.1063753696.18196@neongoat.com>
References: <20030828005741.162b0565.david@neongoat.com>, <20030828005741.162b0565.david@neongoat.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr82ovn3u.wl@alsa2.suse.de>
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

Takashi Iwai <tiwai@suse.de> said:

> could you please try the attached patch?
> if it still doesn't solve the problem, try to increase the length of
> timeout in snd_trident_4d_dx_init(), e.g. 
> 
> 	end_time = jiffies + HZ * 2;
> 
> it will wait for 2 seconds.
> try this with and without the patch.
> 
> if the same problem happens, try to commend out the line
> "return -EIO;" in the same function, so that the probing proceeds even
> if the check fails.  let's see whether the further ac97 probing
> works.
> 
> if still fails...  remove the warm reset part.

Sorry for the slow reply... I tried the patch and it didn't work so I also
tried combining the above fixes with and without the patch. Still no luck :(
Would it be helpful to put debug messages on each line and pasting that, or
should I try something else?

Thanks,
David

-------
David Parker <david@neongoat.com>
Neon Goat Productions
http://www.neongoat.com
0xF90FFFE5 / F362 51F7 6D51 85EB AF68 75B9 D29B 1AFC F90F FFE5
-------







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
