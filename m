From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Fri, 11 Feb 2005 11:05:40 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502111103140.2300@pnote.perex-int.cz>
References: <420270C1.3000706@voicenet.com> <1107457227.7256.37.camel@krustophenia.net>
 <4202A72C.3000007@superbug.co.uk> <1107645609.7256.73.camel@krustophenia.net>
 <420C0C89.1010008@voicenet.com> <s5hr7jnza3t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7jnza3t.wl@alsa2.suse.de>
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
Cc: Adam K Kirchhoff <adamk@voicenet.com>, Lee Revell <rlrevell@joe-job.com>, James Courtier-Dutton <James@superbug.co.uk>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Feb 2005, Takashi Iwai wrote:

> IMO, a "Master" volume should control all volumes as it name stands.
> If it doesn't control all channels, it should be renmaed at least as
> "Front".

Yes, renaming is appropriate. I don't like to have some "abstraction" 
code in the kernel. In case of SB Live! you must take care about AC97 and 
DSP setup which is easy to do from the user space and there is a way to
do it now (via the user space controls).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
