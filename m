From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 6 May 2015 10:24:05 +0100
Message-ID: <20150506092405.GA17710@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com> <20150504113943.GB15510@sirena.org.uk> <20150505092411.GA15549@opensource.wolfsonmicro.com> <20150505105327.GZ22845@sirena.org.uk> <20150505133129.GA26101@opensource.wolfsonmicro.com> <20150505215934.GH15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150505215934.GH15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2015 at 10:59:34PM +0100, Mark Brown wrote:
> On Tue, May 05, 2015 at 02:31:29PM +0100, Richard Fitzgerald wrote:
> 
> > We can't really tell people what the selection does because that depends on
> > the external hardware. The A setting might be a headset mic, or a line in,
> > or a builtin mic...
> 
> > All we can do is say what the selection is called generically by the codec.
> > So take the IN1L signal, on the codec it has two inputs "A" and "B". The
> > IN1L Mux control has two settings "A" and "B". That seems clear.
> 
> So you're saying that you've got a mux on a single physical input which
> has two inputs?  Are you sure that this is actually a mux and not some
> sort of mode setting that should be in platform data or DT - what do
> these settinngs actually correspond to?  The routes in the driver look
> like there's two physical pins for each one of IN1L/R which the device
> can switch between for some reason which does correspond to a mux but
> that'd more normally be named IN1AL or similar.
> 

No, I'm just saying I don't see how calling the mux positions "IN1AL"
is any clearer than calling them "A" and "B". The "IN1AL" names of the
DAPM widgets is purely an internal detail that you wouldn't see through
the ALSA interface anyway so they don't relate any more closely to what
Joe user is seeing in the control list. The IN1L mux is for IN1L
so including that information in the mux position is redundant. For me
the real benefit of the "A"/"B" naming is that if you're reading through
a configuration script and saw something like

    'IN1L Mux' = 'B'
    'IN1R Mux' = 'B'

It's much more readably obvious that both channels are set the same
rather than

    'IN1L Mux' = 'IN1BL'
    'IN1R Mux' = 'IN1BR'

The second version doesn't tell you any more information than the first
but makes it harder to scan so you have to read more carefully to check
the settings


> Though if the left and right side need to be set to the same thing
> (which IIRC a previous version had code to check for and you did mention
> in your mail) all the time then why are there two separate muxes anyway?

They only need to be set the same if the "A" input is set to digital mic
mode because that uses pins from both the left and right channel to
run the single digital interface. If the A input is analogue the two
channels are independant so the left/right muxes can be set to A or B
inputs independantly.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
