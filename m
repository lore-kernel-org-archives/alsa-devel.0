From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core rawmidi.c,1.40,1.41
Date: Mon, 2 Feb 2004 09:41:06 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402020932230.1872@pnote.perex-int.cz>
References: <E1AnKYI-0000sI-Hg@sc8-pr-cvs1.sourceforge.net> <401D318E.4020100@tin.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401D318E.4020100@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@tin.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Feb 2004, Abramo Bagnara wrote:

> Jaroslav Kysela ha scritto:
> > Modified Files:
> > 	rawmidi.c 
> > Log Message:
> > copy_*_user() function cannot be called from spinlock context
> > 
> > Index: rawmidi.c
> > ===================================================================
> > RCS file: /cvsroot/alsa/alsa-kernel/core/rawmidi.c,v
> > retrieving revision 1.40
> > retrieving revision 1.41
> > diff -u -r1.40 -r1.41
> > --- rawmidi.c	23 Oct 2003 14:34:52 -0000	1.40
> > +++ rawmidi.c	1 Feb 2004 16:34:28 -0000	1.41
> > @@ -909,10 +909,11 @@
> >  		if (kernel) {
> >  			memcpy(buf + result, runtime->buffer + runtime->appl_ptr, count1);
> >  		} else {
> > +			spin_unlock_irqrestore(&runtime->lock, flags);
> >  			if (copy_to_user(buf + result, runtime->buffer + runtime->appl_ptr, count1)) {
> > -				spin_unlock_irqrestore(&runtime->lock, flags);
> >  				return result > 0 ? result : -EFAULT;
> >  			}
> > +			spin_lock_irqsave(&runtime->lock, flags);
> >  		}
> >  		runtime->appl_ptr += count1;
> >  		runtime->appl_ptr %= runtime->buffer_size;
> > @@ -1133,10 +1134,13 @@
> >  		if (kernel) {
> >  			memcpy(runtime->buffer + runtime->appl_ptr, buf, count1);
> >  		} else {
> > +			spin_unlock_irqrestore(&runtime->lock, flags);
> >  			if (copy_from_user(runtime->buffer + runtime->appl_ptr, buf, count1)) {
> > +				spin_lock_irqsave(&runtime->lock, flags);
> >  				result = result > 0 ? result : -EFAULT;
> >  				goto __end;
> >  			}
> > +			spin_lock_irqsave(&runtime->lock, flags);
> >  		}
> >  		runtime->appl_ptr += count1;
> >  		runtime->appl_ptr %= runtime->buffer_size;
> 
> 
> With this patch you break write and read atomicity, you should:
> 
> 1) read and save appl_ptr
> 2) update appl_ptr and avail
> 3) leave critical area
> 4) copy from/to user using saved appl_ptr

But hardware can overwrite data (read) or send data which are not yet 
available (write) when we are not in the spinlock context and data are not 
copied.

If we need atomic read() and write() we must probably add a semaphore.

> 5) reenter critical area
> 
> I've just checked and a similar mistake has been done too for PCM (and 
> other places?).

Yes, but the question is, in which case is atomicity necessary. So far,
I see the problem only for the O_APPEND mode (rawmidi).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
