From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 3 Aug 2007 22:56:49 +0100
Message-ID: <200708032256.49911.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<46B33BDC.80408@superbug.co.uk> <s5hzm18ps98.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 3959E24361
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 23:56:12 +0200 (CEST)
In-Reply-To: <s5hzm18ps98.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 03 August 2007 16:11, you wrote:
> At Fri, 03 Aug 2007 15:29:48 +0100,
>
> James Courtier-Dutton wrote:
> > Alan Horstmann wrote:
> > > On Friday 27 July 2007 21:16, Jaroslav Kysela wrote:
> > >> On Fri, 27 Jul 2007, stan wrote:
> > >>> I really want to avoid rate resampling if I can, while format
> > >>> conversion has to occur somewhere in order to match the hardware in
> > >>> most cases.  I assume that any format conversion alsa does
> > >>> is at least as good as one I would do myself.  While the rate
> > >>
> > >> I answered this numerous times on this list. We have a function to
> > >> notify the plugins that resampling should be avoided - it's
> > >> snd_pcm_hw_params_set_rate_resample().
> > >
> > > Can this function be built into an ALSA configuration file in some way,
> > > or can it only be called from an app?
> > >
> > > Alan
> >
> > It is only really sensible to have the app do the call, and not a config
> > file.
> > Reason being, if the app does the call, it must also be able to handle
> > the resampling itself.
> > If the config file did it, the app might not be able to do the
> > resampling itself and therefore fail to play anything.
> > Generally, the app is the best place to do the resampling, as it can
> > handle the quality issues better.
> > The resampler in ALSA is only really there to let other apps that don't
> > do resampling limp along ok.
>
> Well, it's basically a user's choice whether he really wants only a
> fixed certain samplerate over all apps or not.  If he wants, he can
> set up his own default PCM, of course.
>
> As a hint, the plug plugin can have "slave.rate unchanged" parameter.
> For example,
>
> 	pcm.mypcm {
> 		type plug
> 		slave.pcm "myownhw"
> 		slave.rate unchanged
> 	}
>
> would wrap the slave PCM "myownhw" with plug layer but the automatic
> rate conversion is suppressed there.  This allow, however, automatic
> conversions of other parameters such as channels and format.

Thanks! I'll experiment with this when back from hols.

Alan
