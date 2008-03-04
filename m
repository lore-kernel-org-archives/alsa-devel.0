From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Tue, 04 Mar 2008 17:44:22 +0800
Message-ID: <1204623862.13915.10.camel@localhost.localdomain>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
	<1204498741.10206.26.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CC90243B5
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 10:42:48 +0100 (CET)
In-Reply-To: <1204498741.10206.26.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: tiwai@suse.de, "Tellman, Steven" <Steven.Tellman@idt.com>, Lee Revell <rlrevell@joe-job.com>, Armando Di Cianno <armando@goodship.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-03-03 at 06:59 +0800, Tobin Davis wrote:
> It is possible that HDMI audio is pulled from an unknown i2c bus on
> the
> video chip.  3dfx did that a long time ago with their 3500 card for
> their tv tuner portion.
> 
> I think at this point, unless Steven knows more, this may be
> unsupported
> until nVidia adds support in their driver or opens up part of the
> spec.
> 
I googled some info about the nvidia G84** or G86** graphics core.
They got the audio signal from the external audio device through spdif.

For Dell M1330, the spdif configuration for the stac92** codec looks
well, maybe the graphic driver can control whether the audio signal is
allowed to transfer through the HDMI port?


> Tobin
> 
> On Sun, 2008-03-02 at 14:20 -0800, Tellman, Steven wrote:
> 
> > This system is NVidia (or Intel).
> >
> > ________________________________
> >
> > From: rlrevell@gmail.com on behalf of Lee Revell
> > Sent: Sat 3/1/2008 9:03 PM
> > To: Armando Di Cianno
> > Cc: Tellman, Steven; alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330
> >
> >
> >
> > On Thu, Feb 28, 2008 at 8:29 PM, Armando Di Cianno
> <armando@goodship.net> wrote:
> > >
> > >  On Thu, 2008-02-28 at 12:55 -0800, Tellman, Steven wrote:
> > >  > Notice we use the "Other Digital" as the jack. Is that possibly
> > >  > causing
> > >  > a problem? IEC958 shows up, but doesn't provide output to HDMI
> devices
> > >  > (that I've tested).
> > >
> > >  At a user level, this is definitely what I've experienced.
> > >
> > >  Are there any suggestions for testing if my current ALSA
> > >  install /should/ work, or how to find out if something is
> misconfigured,
> > >  or will simply not work?
> >
> > Do you have the binary ATI driver installed?  Several users have
> > reported that it's required for HDMI audio to work.
> >
> > Lee
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
