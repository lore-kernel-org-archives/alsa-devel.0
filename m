From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [2.6 patch] ALSA PCI drivers: misc cleanups
Date: Mon, 22 Nov 2004 13:14:01 -0500
Message-ID: <1101147241.2873.23.camel__45853.9571417079$1101150584$gmane$org@krustophenia.net>
References: <20041121235855.GI13254@stusta.de>
	 <1101088632.5119.2.camel@krustophenia.net> <s5hsm71vlrc.wl@alsa2.suse.de>
	 <1101145386.2873.2.camel@krustophenia.net>  <s5hoehpvkdl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 6468F2BB
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 19:14:03 +0100 (MET)
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
> > Nope.  Any idea what this is/was for?  I poked around the OSS driver and
> > could not find a similar function.
> 
> IIRC, it came from the very old version of OSS emu10k1 driver.
> 

OK.  If this code was in the original opensource.creative.com driver
then there is always the chance it embodies some knowledge of the
hardware that we don't have.  For example set_loop_stop, which was also
in the OSS driver but unused, can be used to start multiple channels in
sync.  But as long as the CVS history is available this should not be a
problem.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
