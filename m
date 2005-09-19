From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Mon, 19 Sep 2005 17:36:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509191722130.8552@dhcp73.suse.cz>
References: <432D6C3A.4000001@superbug.co.uk> <Pine.LNX.4.61.0509191511290.8552@dhcp73.suse.cz>
 <s5hirwxw0bo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirwxw0bo.wl%tiwai@suse.de>
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

> Or, how about to define a struct like
> {
> 	snd_ctl_elem_id_t id;
> 	char key[KEY_SIZE];
> 	unsigned int size;
> 	char *value;
> }
> so that the caller always asks with the certain key?

It's also quite good method, but it avoids having multiple blocks with 
same keys. For example:

block1-mixer
key1
key2
/block1-mixer
block2-pcm
key1
key2
/block2-pcm

Maybe adding 'char group[GROUP_SIZE]' to the structure will help us.

Also, we should consider to give a possibility to obtain the full list of 
groups/keys to applications / alsa-lib. If we give the full contents the 
applications can do rest otherwise the driver must implement an arbiter 
which collects this information.

I would vote to keep the kernel space as simple as possible and give the 
whole contents to apps. They can implement reading/caching/filtering 
themselves.

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
