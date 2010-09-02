From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RESENT] [PATCH - Fix Fast Track Ultra series:
 44.1/88.1 kHz 1/Fix playback/capture issues and related	chrashes at 44100
 Hz and 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 2 Sep 2010 11:16:49 +0200
Message-ID: <20100902091649.GK17833@buzzloop.caiaq.de>
References: <4C32E3B2.5080707@web.de> <4C7E1376.9030208@web.de>
	<s5hk4n4zgrn.wl%tiwai@suse.de> <4C7F6A9B.5010707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EB45A245E3
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 11:16:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C7F6A9B.5010707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 02, 2010 at 11:12:59AM +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > I myself find it's OK to apply since it's pretty local change.
> > Clemens, what was your objection at that time?
> 
> No objection per se, I wanted to find out what descriptor field is
> changed by the quirk, and where the crashes come from exactly.  The
> latter is still unclear, but it seems a quirk like this is required.
> 
> I've committed the patch now.
> 
> > > Also, the Interface Class protocol for the device defaults to Vendor 
> > > Specific Class, but the driver only recognizes Class 1 or 2. The device 
> > > is really Class 1, so we have to force it to reflect this. There are 4 
> > > places that we need to set this."
> 
> Daniel, this seems to be a regression introduced with the UAC2 changes.
> The old driver accepted vendor-specific interfaces, if some quirk forced
> it to look at them.

Hmm, I don't follow. What's the problem, and why should that be caused
by the UAC2 changes? Sorry, but I seem to have missed that thread.


Thanks,
Daniel
