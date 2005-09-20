From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Tue, 20 Sep 2005 14:36:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509201430480.13414@tm8103.perex-int.cz>
References: <432D6C3A.4000001@superbug.co.uk> <Pine.LNX.4.61.0509191511290.8552@dhcp73.suse.cz>
 <s5hirwxw0bo.wl%tiwai@suse.de> <Pine.LNX.4.61.0509191722130.8552@dhcp73.suse.cz>
 <s5h8xxtdp78.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xxtdp78.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Sep 2005, Takashi Iwai wrote:

> > which collects this information.
> 
> In the case of the explicity key-value record, it's easy.  We can
> define a special key, e.g. "list", to return the list of keys, so no
> API extension is needed.
> 
> > I would vote to keep the kernel space as simple as possible and give the 
> > whole contents to apps. They can implement reading/caching/filtering 
> > themselves.
> 
> Agreed.

Ok, good ideas. I would propose this final API:

1) one key with specific delimiters like:

list		# list everything (all keys)
list/master	# list only master keys (mixer, pcm etc.)
list/mixer	# list only mixer keys
list/pcm
mixer/dB_range	# get value for mixer - dB_range
mixer/abcd
pcm/connector

2) textual representation of values

So, we need to describe the keys and value meaning and then implement it
in the driver code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
