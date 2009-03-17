From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Bugs on aspire one A150
Date: Tue, 17 Mar 2009 02:52:19 +0200
Message-ID: <1237251139.7952.1.camel@maxim-laptop>
References: <s5h4oxtqy6q.wl%tiwai@suse.de>
	 <20090316160208.GB4458@rhlx01.hs-esslingen.de>
	 <s5hwsappi44.wl%tiwai@suse.de> <s5hprghphid.wl%tiwai@suse.de>
	 <20090316170015.GA9776@rhlx01.hs-esslingen.de>
	 <s5hljr5pex0.wl%tiwai@suse.de>
	 <20090316173000.GA25647@rhlx01.hs-esslingen.de>
	 <s5hiqm9pe1g.wl%tiwai@suse.de>
	 <20090316180638.GB25647@rhlx01.hs-esslingen.de>
	 <s5htz5tyzyg.wl%tiwai@suse.de>
	 <20090316212227.GA29471@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090316212227.GA29471-p/qQFhXj4MHA4IYVXhSI5GHfThorsUsI@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-03-16 at 22:22 +0100, Andreas Mohr wrote:
> Hi,
> 
> On Mon, Mar 16, 2009 at 09:28:39PM +0100, Takashi Iwai wrote:
> > At Mon, 16 Mar 2009 19:06:38 +0100,
> > Andreas Mohr wrote:
> > > I just tried connecting a headset and switching to E-Mic.
> > > What I can say is:
> > > - opposite levels does NOT happen there (E-Mic is "analog micro"-based, right?)
> > > - leaving E-Mic unplugged will actually record from i-Mic (due to properly
> > >   working EAPD mechanism, right?)
> > 
> > The record from mic-jack is via analog path.  The phase-inversion
> > appears only for digital-mic, AFAIK.
> 
> Thought so.
> 
> > > One question still: is this a hardware defect (i.e. could this possibly
> > > be swapped cables of the microphone connector in this model or so?
> > > Not plausible but...), or is this an existing property
> > > of the HDA's dig-mic base? You indicated it's the latter I think...
> > 
> > My guess is that it's a hardware implementation.
> > Maybe for the noise suppression via mic array.
> 
> Not sure what this means.
> 
> > The question is whether the left / right channels recorded from
> > digital mic are really raw data, or they are for modified data
> > (for differential, etc)...  It's hard to guess without the actual
> > data.
> 
> I don't quite follow you here. Is there anything I could do about this?
> 
> Thanks,
> 
> Andreas


What about exposing the i-mic as a mono only device to userspace?
It is mono after all?

Best regards,
	Maxim Levitsky
