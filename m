From: Olaf Hering <olh@suse.de>
Subject: Re: sound/core/pcm_lib.c:158: BUG
Date: Mon, 20 Dec 2004 21:19:03 +0100
Message-ID: <20041220201903.GA24942@suse.de>
References: <20041218235359.GA3782@suse.de> <1103416452.28301.5.camel@krustophenia.net> <s5h4qihvz8v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4qihvz8v.wl@alsa2.suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 On Mon, Dec 20, Takashi Iwai wrote:

> At Sat, 18 Dec 2004 19:34:12 -0500,
> Lee Revell wrote:
> > 
> > On Sun, 2004-12-19 at 00:53 +0100, Olaf Hering wrote:
> > > Is this just debug output, or should I be worried about it?
> > > 
> > > linux-2.6.10-rc3-olh/sound/core/pcm_lib.c:158: BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x1000
> > > 
> > > This is an ibook2, playing mp3 with xmms, alsa version is 1.0.3, from sles9.
> > > I remember no failures in the last couple hours.
> > 
> > That message indicates that the hardware pointer returned by the pointer
> > callback was beyond the end of the buffer which should not be possible.
> > 
> > This could indicate an off by one error in the driver, it looks like the
> > erroneous position is one sample past the end of the buffer.
> 
> Does the patch below work?

I havent seen that warning since 2 hours, so I guess it helps.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
