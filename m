From: Olaf Christ <olaf-Cb7RZHV19h6Y/VGTjfr9Sg@public.gmane.org>
Subject: Firewire Audio Card Support
Date: Thu, 18 Nov 2004 15:15:52 +0100
Message-ID: <200411181515.52218.olaf@solutionworks.de>
References: <31148074.1100630541337.JavaMail.root@scooter.psp.pas.earthlink.net>
	<419C9D47.4090606@x-i.net>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <419C9D47.4090606-l4pODZ2nMLw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

as the owner of a firewire audio card (Motu 828mkII) I was disappointed when 
trying to use it under linux. Asking Motu to provide tech docs and/or linux 
drivers is useless: "We will possibly release linux drivers in the future, 
but we never release any kind of technical documentation."
Is there any effort to join forces for putting pressure on the manufacturers 
yet? I am willing to create an address list ordered by audio card 
manufacturer/model to make the manufacturers realize there is a need for 
linux support.

Any comments?

Olaf



On Thursday 18 November 2004 14:01, derek holzer wrote:
> Of course, the Firewire subsystem for Linux works fine. But AFAIK there
> are no drivers existing for any firewire audio cards. Bug the various
> manufacurers to release more technical info and they might eventually
> show up.
>
> d.
>
> Victor LaLoggia wrote:
> > Hello Frank;
> >
> >   Thank you for your response, and I do not mean to be contrary, but what
> > about the work the folks at http://www.linux1394.org/ are doing?
> >
> >   I see that their subsystem has been included Linux kernel sources since
> > version 2.3.40.  Does the subsystem not work?
> >
> >   Thanks,
> >   vic
> >
> > -----Original Message-----
> > From: Frank Barknecht <fbar-T1uUCcFPrxNAfugRpC6u6w@public.gmane.org>
> > Sent: Nov 15, 2004 12:14 PM
> > To: linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
> > Subject: Re: [linux-audio-user] Using Linux Laptop for Live Performance
> >
> > Hallo,
> >
> > Victor LaLoggia hat gesagt: // Victor LaLoggia wrote:
> >>  I am just beginning my research into the available software and
> >>  hardware, and would greatly appreciate any information. Especially
> >>  on hardware - what would be the best usb/ firewire interface for
> >>  live performance?
> >
> > No Firewire audio yet on Linux. The best in your case is PCMCIA, which
> > has the lowest latency. VX-Pocket or RME cards are good choices. Also
> > try, if your internal soundcard is enough.
> >
> > Ciao
