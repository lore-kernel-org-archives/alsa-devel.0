From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 5 Aug 2004 21:29:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040805192913.GA509@tuba.home>
References: <s5hk6wdj4yt.wl@alsa2.suse.de> <Pine.HPX.4.33n.0408051208270.18069-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 8F738216
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 21:27:52 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0408051208270.18069-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2004 at 12:17:08PM +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > Martin Langer wrote:
> > > usbusx2yaudio.c:492: __old_i_usX2Y_urb_complete undeclared
> >
> > This one should fix.
> >
> > -#define snd_usb_complete_callback(x) __old_ ## x
> > +#define snd_usb_complete_callback(x) x ## __old_
> >  static void i_usX2Y_urb_complete__old_(struct urb *urb);
> 
> Oops, I didn't read your mail before committing my patch which changes
> the function names instead.  Well, now it's consistent with
> usbaudio.c.  :-)

Yep. It's fixed. 
Just updating my OHCI-PowerBook I detected another problem:

./cvscompile --with-cards=powermac

fails with

checking for which soundcards to compile driver for... configure: error:
Unsupported soundcard powermac


martin


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
