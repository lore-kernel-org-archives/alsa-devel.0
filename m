From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Sun, 02 Mar 2008 14:59:01 -0800
Message-ID: <1204498741.10206.26.camel@razman.gruemaster.com>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E04F324434
	for <alsa-devel@alsa-project.org>; Sun,  2 Mar 2008 23:59:03 +0100 (CET)
In-Reply-To: <16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Tellman, Steven" <Steven.Tellman@idt.com>
Cc: Armando Di Cianno <armando@goodship.net>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is possible that HDMI audio is pulled from an unknown i2c bus on the
video chip.  3dfx did that a long time ago with their 3500 card for
their tv tuner portion.

I think at this point, unless Steven knows more, this may be unsupported
until nVidia adds support in their driver or opens up part of the spec.

Tobin

On Sun, 2008-03-02 at 14:20 -0800, Tellman, Steven wrote:

> This system is NVidia (or Intel).
> 
> ________________________________
> 
> From: rlrevell@gmail.com on behalf of Lee Revell
> Sent: Sat 3/1/2008 9:03 PM
> To: Armando Di Cianno
> Cc: Tellman, Steven; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330
> 
> 
> 
> On Thu, Feb 28, 2008 at 8:29 PM, Armando Di Cianno <armando@goodship.net> wrote:
> >
> >  On Thu, 2008-02-28 at 12:55 -0800, Tellman, Steven wrote:
> >  > Notice we use the "Other Digital" as the jack. Is that possibly
> >  > causing
> >  > a problem? IEC958 shows up, but doesn't provide output to HDMI devices
> >  > (that I've tested).
> >
> >  At a user level, this is definitely what I've experienced.
> >
> >  Are there any suggestions for testing if my current ALSA
> >  install /should/ work, or how to find out if something is misconfigured,
> >  or will simply not work?
> 
> Do you have the binary ATI driver installed?  Several users have
> reported that it's required for HDMI audio to work.
> 
> Lee
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
