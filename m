From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [2.6 patch] ALSA PCI drivers: misc cleanups
Date: Mon, 22 Nov 2004 13:02:36 -0500
Message-ID: <1101146556.2873.14.camel__27377.7423929007$1101150737$gmane$org@krustophenia.net>
References: <20041121235855.GI13254@stusta.de>
	 <1101088632.5119.2.camel@krustophenia.net> <s5hsm71vlrc.wl@alsa2.suse.de>
	 <1101145386.2873.2.camel@krustophenia.net>  <s5hoehpvkdl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 236EE172
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 19:02:37 +0100 (MET)
In-Reply-To: <s5hoehpvkdl.wl@alsa2.suse.de>
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
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-11-22 at 18:55 +0100, Takashi Iwai wrote:
> At Mon, 22 Nov 2004 12:43:05 -0500,
> Lee Revell wrote:
> > 
> > On Mon, 2004-11-22 at 18:25 +0100, Takashi Iwai wrote:
> > > At Sun, 21 Nov 2004 20:57:12 -0500,
> > > Lee Revell wrote:
> > > > 
> > > > On Mon, 2004-11-22 at 00:58 +0100, Adrian Bunk wrote:
> > > > >   - emu10k1/io.c: snd_emu10k1_voice_set_loop_stop
> > > > 
> > > > Please do not remove this function.  I am working on an enhancement to
> > > > the emu10k1 driver that uses it.
> > > 
> > > Do you need snd_emu10k1_sum_vol_attn, too?
> > > 
> > 
> > Nope.  Any idea what this is/was for?  I poked around the OSS driver and
> > could not find a similar function.
> 
> IIRC, it came from the very old version of OSS emu10k1 driver.
> 

OK.  I have added James to the cc.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
