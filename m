From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Wed, 04 Feb 2009 17:01:37 +0530
Message-ID: <1233747097.5563.29.camel@localhost.localdomain>
References: <1232465902.3088.31.camel@localhost.localdomain>
	 <s5h7i4psepm.wl%tiwai@suse.de> <20090121054138.GA26551@uranus.ravnborg.org>
	 <200902032127.24526.arnd@arndb.de>
	 <1233720252.3595.5.camel@localhost.localdomain>
	 <s5hhc3ak8ns.wl%tiwai@suse.de>
	 <1233736494.3198.15.camel@localhost.localdomain>
	 <s5h4ozak20l.wl%tiwai@suse.de>
	 <1233743877.5563.7.camel@localhost.localdomain>
	 <s5hy6wma2zw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755751AbZBDLcV@vger.kernel.org>
In-Reply-To: <s5hy6wma2zw.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-02-04 at 11:52 +0100, Takashi Iwai wrote:
> At Wed, 04 Feb 2009 16:07:57 +0530,
> Jaswinder Singh Rajput wrote:
> > 
> > In kernel space we use USE_SEQ_MACROS in:
> > sound/oss/mpu401.c
> > sound/oss/midi_synth.c
> > 
> > so we can replace
> > #if (!defined(__KERNEL__) && !defined(KERNEL) && !defined(INKERNEL) && !defined(_KERNEL)) || defined(USE_SEQ_MACROS)
> > with
> > #ifdef USE_SEQ_MACROS
> 
> Then this will break user-space apps.  They don't define
> USE_SEQ_MACROS always.
> 

If userspace apps are coming through sys/soundcard.h we can define
USE_SEQ_MACROS in it 
OR 
define USE_SEQ_MACROS in linux/soundcard.h for userspace 
OR 
need to redefine better #ifdef

Thanks,
--
JSR
