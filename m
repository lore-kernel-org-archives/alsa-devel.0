From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Wed, 21 Jan 2009 05:55:28 +0530
Message-ID: <1232497528.3123.32.camel@localhost.localdomain>
References: <1232465902.3088.31.camel@localhost.localdomain>
	 <s5h7i4psepm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932142AbZAUA0M@vger.kernel.org>
In-Reply-To: <s5h7i4psepm.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Sam,

On Wed, 2009-01-21 at 01:08 +0100, Takashi Iwai wrote:
> At Tue, 20 Jan 2009 21:08:22 +0530,
> Jaswinder Singh Rajput wrote:
> > 
> > usr/include/linux/soundcard.h is giving following warnings for 'make headers_check':
> >  usr/include/linux/soundcard.h:1047: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1048: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1049: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1050: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1051: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1053: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1055: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1056: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1061: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1062: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1078: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1079: extern's make no sense in userspace
> > 
> > Do we need to fix these warnings.
> 
> No, these are declarations for OSS-lib.
> It doesn't belong to kernel, but it's better to keep it for
> compatibility in some way.
> 

Do you have some plan where extern is required like in this case.

--
JSR
