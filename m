From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Fri, 14 Dec 2018 16:54:13 +0200
Message-ID: <CAEnQRZBnzqMVv86wAqXB9kRtKpkC=R7fLbpE1Avyw6364Cwgfg@mail.gmail.com>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk> <1544696446.7700.31.camel@nxp.com>
 <20181213143144.GH10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4402678D5
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 15:54:26 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id f23so5188043edb.3
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 06:54:26 -0800 (PST)
In-Reply-To: <20181213143144.GH10669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 13, 2018 at 4:31 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 10:20:47AM +0000, Cosmin Samoila wrote:
> > On Mi, 2018-12-12 at 18:14 +0000, Mark Brown wrote:
>
> > > > +static const char * const micfil_hwvad_rate[] = {
> > > > + "48KHz", "44.1KHz",
> > > > +};
>
> > > > +static const int micfil_hwvad_rate_ints[] = {
> > > > + 48000, 44100,
> > > > +};
> > > Can the driver not determine this automatically from sample rates?
>
> > I think I could add "48000", "44100" instead of "48KHz", "44.1KHz" and
> > use kstrtol()
>
> No, you're missing the point - why not set the sample rate based on the
> sample rate the interface is running at?

Hmm, definitely we somehow miss the point here. So what happens
if we only do Voice Activity Detection (VAD) ?

This means that there is no sample rate yet configured, so for this reason
we get the sampling rate as above via ALSA kcontrol interface.

My feeling is that somehow we will need to create maybe another type
of stream (VAD?).

This is a thing that we need to think. Suggestions are welcomed!

>
> > > > +static const char * const micfil_clk_src_texts[] = {
> > > > + "Auto", "AudioPLL1", "AudioPLL2", "ExtClk3",
> > > > +};
>
> > > Is this something that should be user selectable or is it going to be
> > > controlled by the board design?
>
> > User should be able to select the clock source since, in theory,
> > hardware could support any custom rate as long as you can provide the
> > clock on extclk.
>
> What I'm saying is that this should not be selectable by the user at
> runtime.  It's not like the user is going to open their system and start
> soldering links onto the board or anything.

Of course, so would this be a better option to select it from dts?

>
> > > What happens if this gets changed while a stream is active - the user
> > > will think they changed the configuration but it won't take effect
> > > until
> > > the next stream is started AFAICT?
>
> > If the stream is active, the configuration will indeed take efect on
> > the next stream but this is the desired behavior. If we would want to
> > do the config on the fly, we should use sync functions that also resets
> > the pdm module which is not what we intend.
> > User must first configure the module then start the recording since
> > this seems to be the natural flow.
>
> If the user can't reconfigure the stream while it's running the user
> shouldn't be able to reconfigure the stream while it's running - we
> should block the change if it can't be implemented.  Then the user can
> make the change while the interface is idle and and
>
> > > Are you *sure* you need to and want to use atomic_set() here and that
> > > there's no race conditions resulting from trying to use an atomic
> > > variable?  It's much simpler and clearer to use mutexes, if for some
> > > reason atomic variables make sense then the reasoning needs to be
> > > clearly documented as they're quite tricky and easy to break or
> > > misunderstand.

We can go back to mutexes no problem, but we thought that atomic vars
are lighter.

>
> > We want to keep track of the recording state and the hwvad state since
> > recording and voice detection can work in parallel. The main reason why
> > we want to keep track is because the recording and hwvad share the same
> > clock and we should not touch the clock when one or another is on.
> > Another restriction is that we want to make sure we use the same rate
> > for recording and voice detection when doing it in parallel.
> > This was the only solution we found viable at that time and it worked
> > in any supported scenarios but we are open for suggestions if the
> > functionality is kept and code will have a better quality.
>
> This explains what the data is but not why you have chosen to use
> atomics to do this; what other concurrency primitives were considered,
> why were they rejected and what's the analysis that shows how the use of
> atomics is safe?

We first used mutexes but I suggested switching to atomic vars because
AFAIK they are lighter than mutexes.
