From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer	reads
Date: Fri, 25 Jan 2008 17:29:28 +0100
Message-ID: <20080125162928.GH9123@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
	<20080125002514.GA9015@lemon.iwr.uni-heidelberg.de>
	<s5h3asm2nib.wl%tiwai@suse.de>
	<20080125160727.GF9123@lemon.iwr.uni-heidelberg.de>
	<s5hy7adj2s7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
	[129.206.100.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 55B7D2482A
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 17:29:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy7adj2s7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2008 at 05:19:52PM +0100, Takashi Iwai wrote:

> > If I interpreted my tests output correctly, the last byte of a period
> > is written by the DMA engine after the interrupt occurs. So the
> > hw pointer probably has to be decremented by one and is then
> > pointing to the last frame (Or even that before: Has the hw pointer to point
> > at the frame which is written at the moment or the one which is
> > guaranteed to be written completely by the hardware ?)
> 
> This sounds a bit odd.  Isn't it rather the setup of the hardware
> parameter wrong?  I mean, the count calculation in *_prepare() can be
> the size - 1?  

At least according to the datasheet the size calculation is correct.
Could you please tell me where the hw pointer exactly should point to ?

Thanks,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
