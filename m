From: Stephen Hassard <steve@hassard.net>
Subject: Re: Updating Linux kernel 2.5 ALSA from CVS
Date: Wed, 19 Mar 2003 09:46:27 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030319174627.GA19661@www.angio.com>
References: <20030319172028.GB19604@www.angio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030319172028.GB19604@www.angio.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey all,

I figured out what was going on.

It seems that sound/usb/Kconfig is a duplicate of sound/Kconfig and is causing the conf script to hose itself.

Also, it seems that alsa-kernel/core/memalloc.h doesn't exist anymore, but is referenced by alsa-kernel/core/memalloc.c.

Is CVS alsa-kernel support broken right now?

Thanks,
Stephen Hassard

On Wed, Mar 19, 2003 at 09:20:28AM -0800, Stephen Hassard wrote:
> Hi there,
> 
> I'm trying to update the version of Alsa in the Linux kernel v2.5.65 from CVS.
> 
> Their doesn't seem to be any documentation on how to do this the *right* way.
> 
> It seems that what one should do is copy the CVS/alsa-kernel directory into your /usr/src/linux/sound directory.
> 
> If I do this, I get the following error:
> 
> >>
> make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/conf
> make[1]: `scripts/kconfig/conf' is up to date.
> ./scripts/kconfig/conf -s arch/i386/Kconfig
> file sound/core/Kconfig already scanned?
> make: *** [include/linux/autoconf.h] Error 1
> >>
> 
> It doesn't appear as that "sound/core/Kconfig" is getting included twice.
> 
> Does anyone have any tips for doing this properly?
> 
> Thanks,
> Stephen Hassard
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Does your code think in ink? 
> You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
> What are you waiting for?
> http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
