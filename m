From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and
	front channels via fxbus 8,9
Date: Tue, 22 Feb 2005 17:04:16 -0500
Message-ID: <1109109856.31071.44.camel@krustophenia.net>
References: <421A3A3A.6070009@glocalnet.net>
	 <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 1CC0F1C4
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 23:04:18 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-02-22 at 09:31 +0100, Jaroslav Kysela wrote:
> On Mon, 21 Feb 2005, Mikael Magnusson wrote:
> 
> > This is the first in a set of five patches that add master volume and 
> > switch controls and front pcm channels via fxbus 8,9 to SB Live.
> 
> I still feel that it's broken idea. We have also problems with AC97
> where the surround/center&lfe volumes are separate from AC97 Master Volume
> control, too (at least for Sigmatel codecs).
> 
> We need a layer in user space to handle these issues where we can express
> the control relations in very easy way and not mess the kernel with more 
> dust which is not necessary.
> 
> It might be easy to write a small daemon which will create "Master Volume" 
> control for SB cards at this time until a decent solution in alsa-lib is 
> finished.

I believe Mikael's patch is correct.  At least, partially.

There are two separate issues that the patch addresses.  One is that
unlike the Audigy configuration, the driver does not use separate FX
buses for front output and PCM.  So attenuating the front channels will
attenuate *all* PCM samples.  This has to be fixed in the driver.  And
it's essentially zero cost as the extra FX buses and GPRs are available.

The other issue is the lack of a master volume control.  Provided the
first issue is addressed, perex is correct in that this can be solved in
userspace.

Personally I feel that the entire patch should be applied, until the
required abstraction layer exists in alsa-lib.  The second part of the
patch can be trivially reverted when this is available.

Mikael, can you split your patch into the part that moves PCM and front
to separate FX buses, and the part that adds the master volume?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
