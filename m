From: Andreas Mohr <andi@lisas.de>
Subject: Re: Bugs on aspire one A150
Date: Sun, 9 Nov 2008 21:09:29 +0100
Message-ID: <20081109200929.GA29333@rhlx01.hs-esslingen.de>
References: <s5h3ai11dpt.wl%tiwai@suse.de>
	<20081109151323.GA18705@rhlx01.hs-esslingen.de>
	<s5h7i7c916e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 680622432F
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 21:09:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i7c916e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 09, 2008 at 07:58:17PM +0100, Takashi Iwai wrote:
> At Sun, 9 Nov 2008 16:13:23 +0100,
> Andreas Mohr wrote:
> > OK, _THIS_ time I actually did get the correct model (last time I tried
> > modprobe with model=acer-aspire, but apparently it then used the
> > /etc/modprobe.d/ model=toshiba setting, since this time gamix showed
> > entirely different controls with i-Mic etc.) - all the more reason to
> > log the model name chosen/selected by the driver!!
> 
> Build with the debug option (why turned off even if you *are*
> debugging?).  Then the driver will show you details.

Hmm, right, that would have been an (very useful) option, but not for the
majority of users OTOH.
Especially since this is a user-visible module parameter which should thus
be confirmed in mainstream user code, via logging.
Admittedly not many modules log their settings during startup,
but for snd_hda_intel with its two myriads of codec/machine variants
and a resulting quarter myriad of issues that would be very useful.

> > --> I have to admit that usability sucks^Hcould be a lot better.
> 
> One would call it rather debuggability than usability.
> These are completely different things.

See above ;)

> > i-Mic on Ekiga with lotsa mixer fiddling didn't work either this time.
> 
> OK, then something is missing.  But you should test by arecord first
> than any complicated applications as a primary test.

Good point, will do.

Oh, and is there a way to manually alter codec registers?

> Anyway, the acer-aspire support code was written by Realtek guys, so
> it'd be best to ask them...

Indeed, and far too late (they have submitted it in September I think)
for guaranteeing non-problematic hardware behaviour...
(I'd guesstimate the Realtek submission to be based on Acer activity)
Anyway, still very nice to see that companies do submit patches after all.

Thanks,

Andreas
