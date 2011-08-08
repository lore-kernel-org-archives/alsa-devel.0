From: Liam Girdwood <lrg@ti.com>
Subject: Re: switching pcm devices dynamically when using dmix
Date: Mon, 8 Aug 2011 17:35:01 +0100
Message-ID: <1312821301.3314.7.camel@CNA0741383>
References: <CAG3SCMspSq=aVbGLwKkcp+x7syNf4a9Too+SgmQ7jJSJBH26=Q@mail.gmail.com>
	<s5hoc00f55e.wl%tiwai@suse.de>
	<CAG3SCMup3ya8NftgoYhzQM5rrMbcfEqL3xByfSGZymTHrVttmg@mail.gmail.com>
	<s5hr54vev5l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0D724567
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 18:35:07 +0200 (CEST)
In-Reply-To: <s5hr54vev5l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-08-08 at 18:16 +0200, Takashi Iwai wrote:
> At Mon, 8 Aug 2011 09:08:49 -0700,
> Baek Chang wrote:
> > 
> > Would it be possible to implement this feature in another plugin?  For
> > example, some plugin called "switch", that would take a parameter for device
> > or card name/number that would close the current device and open the new
> > requested device?  Would this be worth investigating?
> 
> The question is whether it allows the dynamic switch of the running
> PCM stream.  If yes, it'd be tough to implement, I suppose.
> OTOH, if it handles only the switch for the next open, it'd be just to
> change the configuration, so it sounds feasible.
> 

Fwiw, the ASoC dynamic PCM code does something a little similar and can
dynamically remap the PCM stream to different backend DAIs (e.g. McBSP,
McPDM, McASP etc) at runtime based on kcontrol mixer settings. This wont
help for routing between cards but could be useful for routing between
different physical DAIs on the same card.

Liam
