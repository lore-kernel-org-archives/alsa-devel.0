From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Driver core: Don't ignore error returns
 from probing
Date: Fri, 6 Oct 2006 14:12:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
References: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.rowland.org (mx2.rowland.org [192.131.102.7])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 891CA1A0
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 20:12:51 +0200 (MEST)
In-Reply-To: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Oct 2006, Cornelia Huck wrote:

> On Fri, 6 Oct 2006 11:41:05 +0200 (CEST),
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > Hm, I don't think we should call device_release_driver if
> > > bus_attach_device failed (and I think calling bus_remove_device if
> > > bus_attach_device failed is unintuitive). I did a patch that added a
> > > function which undid just the things bus_add_device did (here:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
> > > which unfortunately got lost somewhere... (I'll rebase and resend.)

I'm still not sure why bus_attach_device() was split off from 
bus_add_device() in the first place.  Was it just so that the 
kobject_uevent() call could go in between?

Is there any reason they couldn't be recombined into a single function?

> > Yes, but it might be better to check dev->is_registered flag in 
> > bus_remove_device() before device_release_driver() call to save some code, 
> > rather than reuse most of code in bus_delete_device().

Agreed; I don't like the duplication of code.  It's wasteful and 
error-prone (somebody might change one routine and not the other).

> If we undid things (symlinks et al.) in the order we added them, we can
> factor out bus_delete_device() from bus_remove_device() and avoid both
> code duplication and calling bus_remove_device() if bus_attach_device()
> failed. Something like the patch below (untested).

This looks okay, but it would be better if bus_remove_device() did not
directly call bus_delete_device().  Just add an extra call inside
device_del(), so that everything remains symmetrical.

While I'm harping on style issues, you should also capitalize AttachError
so that it matches the form of the other statement labels nearby.  And in
bus_remove_device() you should put all the code inside the "if" block
instead of returning when dev->bus isn't set, just as the neighboring
subroutines do.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
