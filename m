From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Tue, 5 May 2015 14:31:29 +0100
Message-ID: <20150505133129.GA26101@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com> <20150504113943.GB15510@sirena.org.uk> <20150505092411.GA15549@opensource.wolfsonmicro.com> <20150505105327.GZ22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150505105327.GZ22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> 
> > > > +static const char * const wm8998_inmux_texts[] = {
> > > > +	"A",
> > > > +	"B",
> 
> > > Those are some fun input names...
> 
> > ... that's what the mux positions are called and it seems nice to have consistent
> > naming for all similar muxes across channels and across future codecs. Like for
> > example to switch both muxes of a stereo input you set them both to the same
> > position name (both "A" or both "B") is clearer, and quicker to spot in a dump
> > of ALSA control settings, than having the two muxes set to different enumeration
> > strings that actually mean the same mux position.
> 
> Equally when setting the muxes settings called A and B that's not really
> telling people what they do.

We can't really tell people what the selection does because that depends on
the external hardware. The A setting might be a headset mic, or a line in,
or a builtin mic...

All we can do is say what the selection is called generically by the codec.
So take the IN1L signal, on the codec it has two inputs "A" and "B". The
IN1L Mux control has two settings "A" and "B". That seems clear.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
