From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] ALSA: korg1212: cleanup of printk
Date: Mon, 24 Nov 2014 09:25:10 -0800
Message-ID: <1416849910.8797.1.camel@perches.com>
References: <1416730251-5194-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hh9xottl9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh9xottl9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-24 at 18:08 +0100, Takashi Iwai wrote:
> At Sun, 23 Nov 2014 13:40:51 +0530, Sudip Mukherjee wrote:
[]
> > replaced all references of the debug messages via printk
> > with dev_* macro (mostly dev_dbg).
> > one reference was changed to pr_err as there the card might have been
> > uninitialized.
> > 
> > this patch will generate warning from checkpatch about broken quoted
> > strings. but that was not fixed intentionally to improve the
> > readability.

I think it'd be easier to read and grep coalesced.

[]

> > in your review of v1, you said about some lines which are not ending
> > with \n. but i was not able to find them. did i miss them somewhere?
[]
> The problem is the one with multiple "\n", for example:
> 
> 	dev_dbg(korg1212->card->dev, "dspMemPhy = %08x U[%08x], "
> 		"PlayDataPhy = %08x L[%08x]\n"
> 		"korg1212: RecDataPhy = %08x L[%08x], "
> 		"VolumeTablePhy = %08x L[%08x]\n"
> 		"korg1212: RoutingTablePhy = %08x L[%08x], "
> 		"AdatTimeCodePhy = %08x L[%08x]\n",

I think these should be individual dev_dbg calls

	dev_dbg(korg1212->card->dev, "dspMemPhy = %08x U[%08x]\n", val, val2)
	dev_dbg(korg1212->card->dev, "PhyDataPhy = %08x L[%08x]\n", val, val2);
	dev_dbg(korg1212->card->dev, "RecDataPhy = %08x L[%08x]\n", val, val2);
	dev_dbg(korg1212->card->dev, "VolumeTablePhy = %08x L[%08x]\n", val, val2);

	etc..

Another possibility is to use another macro like:

#define k1212_dbg(k1212, fmt, ...)			\
	dev_dbg((k)->card->dev, fmt, ##__VA_ARGS__)

and change all these to

	k1212_dbg(korg1212, "dspMemPhy = %08x U[%08x]\n", val, val2)
	k1212_dbg(korg1212, "PhyDataPhy = %08x L[%08x]\n", val, val2);
	k1212_dbg(korg1212, "RecDataPhy = %08x L[%08x]\n", val, val2);
	k1212_dbg(korg1212, "VolumeTablePhy = %08x L[%08x]\n", val, val2);

etc.

> My biggest concern right now is, however, about the unnecessary code
> increase by this patch.  Currently, most of debug prints were simply
> not built, because of:
> 
> >  // ----------------------------------------------------------------------------
> > -// Debug Stuff
> > -// ----------------------------------------------------------------------------
> > -#define K1212_DEBUG_LEVEL		0
> > -#if K1212_DEBUG_LEVEL > 0
> > -#define K1212_DEBUG_PRINTK(fmt,args...)	printk(KERN_DEBUG fmt,##args)
> > -#else
> > -#define K1212_DEBUG_PRINTK(fmt,...)
> > -#endif
> > -#if K1212_DEBUG_LEVEL > 1
> > -#define K1212_DEBUG_PRINTK_VERBOSE(fmt,args...)	printk(KERN_DEBUG fmt,##args)
> > -#else
> > -#define K1212_DEBUG_PRINTK_VERBOSE(fmt,...)
> > -#endif
> 
> With your patch, now all these codes are compiled.

Not really.

dev_dbg is a no-op unless DEBUG is #defined
or CONFIG_DYNAMIC_DEBUG is set.

> I have no clear answer what would be the best in such a case.  I'd say
> it really depends.  If they are just silly messages that can be
> covered in a better way (like ftrace), just get rid of them.  If they
> are intended for some good register dumps, then dev_dbg() might make
> sense.

very true.
