From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Gentoo alsa output
Date: Mon, 22 Mar 2010 21:29:18 +0800
Message-ID: <20100322132918.GA6257@localhost>
References: <4BA5E45A.6020703@cdstealer.com> <20100321124132.GA7308@localhost>
	<4BA6173F.4050603@cdstealer.com> <4BA65FC8.7060802@cdstealer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C6A0F243E4
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 05:24:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA65FC8.7060802@cdstealer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cdstealer <cdstealer@cdstealer.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

Hi cdstealer,

On Mon, Mar 22, 2010 at 02:04:56AM +0800, cdstealer wrote:
> Hi Fengguang,
> 	I've got HDMI sound working.  This is what I did:

Glad to hear that :)

> Steps to recreate:
> 
> Stopped alsasound (from portage)
> removed from alsasound from rc-update
> downloaded Realteks HD drivers from http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=24&PFid=24&Level=4&Conn=3&DownTypeID=3&GetDown=false <http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=24&PFid=24&Level=4&Conn=3&DownTypeID=3&GetDown=false>
> unpacked the archive and ran the install script (as root)
> replaced the /etc/conf/alsasound with the /etc/conf/aslasound.new
> rebooted as modules could not be reloaded.
> 
> This is the realtek-linux-audiopack-5.14.  So it looks like the Intel side of things are solid, it was the Realtek drivers that were the problem.  Thank you very much for you help and time.  Hopefully the correct drivers will make it into the kernel soon.

I'm a little puzzled though. HDMI audio should be independent on
Realtek HD audio. And it's normally OK to just use the in-kernel
Realtek HD audio driver.

Thanks,
Fengguang

> -------- Original Message  --------
> Subject: Re: Gentoo alsa output
> From: cdstealer <cdstealer@cdstealer.com>
> To: Wu Fengguang <fengguang.wu@intel.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W
> <shane-alsa@csy.ca>
> Date: Sun Mar 21 2010 12:55:27 GMT+0000 (BST)
> > Hi Fengguang,
> >     I ran the command as requested:
> >
> > $ speaker-test -Dhw:0,3 -c8 -twav
> >
> > speaker-test 1.0.21
> >
> > Playback device is hw:0,3
> > Stream parameters are 48000Hz, S16_LE, 8 channels
> > WAV file(s)
> > Rate set to 48000Hz (requested 48000Hz)
> > Buffer size range from 16 to 4096
> > Period size range from 8 to 2048
> > Using max buffer size 4096
> > Periods = 4
> > was set period_size = 1024
> > was set buffer_size = 4096
> >  0 - Front Left
> >  4 - Center
> >  1 - Front Right
> >  7 - Side Right
> >  3 - Rear Right
> >  2 - Rear Left
> >  6 - Side Left
> >  5 - LFE
> > Time per period = 11.306881
> >
> > Unfortunately there was no audio output. :(
> >
> > Thanks
> > Steve
> >
> > -------- Original Message  --------
> > Subject: Re: Gentoo alsa output
> > From: Wu Fengguang <fengguang.wu@intel.com>
> > To: cdstealer <cdstealer@cdstealer.com>
> > Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W
> > <shane-alsa@csy.ca>
> > Date: Sun Mar 21 2010 12:41:32 GMT+0000 (BST)
> >   
> >> Hi cdstealer,
> >>
> >> It looks all sane with HDMI audio. Would you verify HDMI playback with
> >> command
> >>
> >>         speaker-test -Dhw:0,3 -c8 -twav
> >>
> >> ?
> >>
> >> Or are there any more concerns?
> >>
> >> Thanks,
> >> Fengguang
> >>
> >> On Sun, Mar 21, 2010 at 05:18:18PM +0800, cdstealer wrote:
> >>   
> >>     
> >>> Hi fengguang,
> >>>     Many thanks for jumping on this.  I have run the script and uploaded the result to:
> >>>
> >>> http://www.alsa-project.org/db/?f=dbfb35a717aebac5b2650fb9dcf649e1a031ebc0
> >>>
> >>> If you need anything further, please don't hesitate to contact me.
> >>>
> >>> Kind regards
> >>> Steve
> >>>     
> >>>       
> >>   
> >>     
> >
> >   
> 
