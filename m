From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: RE: UDA1341TS (iPAQ H3X00) sound driver for ALSA
Date: Fri, 12 Apr 2002 20:39:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a979po$pkj$2@main.gmane.org>
References: <D99C1FB421989A40818B6370E31870940283AE36@tayexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <D99C1FB421989A40818B6370E31870940283AE36@tayexc19.americas.cpqcorp.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>, alsa-devel@lists.sourceforge.net, Linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Apr 2002, Hicks, Jamey wrote:

> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Subject: Re: UDA1341TS (iPAQ H3X00) sound driver for ALSA
> >
> > On Wed, Apr 10, 2002 at 09:55:43AM -0400, Hicks, Jamey wrote:
> > > > -----Original Message-----
> > > > From: Nicolas Pitre [mailto:nico@cam.org]
> > > >
> > > > No.  Please pick a relevant name.  H3600 is not the only
> > > > device with an UDA1341 out there.
> > >
> > > The alsa driver mentioned is iPAQ specific.  It would be useful to
> > > restructure it in the way the other SA11x0/UDA134x driver
> > is structured.
> >
> > I agree with Nico.  Nico is objecting to it being called
> > *h3600* when it
> > is for all iPAQs, ie, H3600, H3100, H3800.

This is right, I have thought about this.
>
> If that is the case, I am open to suggestions for the name should be, bearing in mind
> that not all iPAQ devices from Compaq are handheld devices.  h3xxx seems
> like a good choice at the moment, but I have a feeling we'll be sharing
> some of the same drivers with h4xxx in the near future.

I agree with "h3xxx". Jamey should say last word, because he should know
at best, what name is most descriptive both now and in (near) future.
I think h4xxx should be served with module named  h3xxx, or we should
vote for hxxxx :).

I have in mind, that the name will change, I'm just waiting for enough
opinions to do this work just once.

Bye

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
