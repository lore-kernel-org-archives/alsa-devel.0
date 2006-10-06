From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Driver core: Don't ignore error returns
 from probing
Date: Fri, 6 Oct 2006 13:46:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061338230.8573@tm8103.perex-int.cz>
References: <20061005175852.GC15180@suse.de>
	<Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
	<20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.61.0610061138580.8573@tm8103.perex-int.cz>
	<20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F07FF1A2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 13:46:52 +0200 (MEST)
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Alan Stern <stern@rowland.harvard.edu>, Castet Matthieu <castet.matthieu@free.fr>
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
> > 
> > Yes, but it might be better to check dev->is_registered flag in 
> > bus_remove_device() before device_release_driver() call to save some code, 
> > rather than reuse most of code in bus_delete_device().
> 
> If we undid things (symlinks et al.) in the order we added them, we can
> factor out bus_delete_device() from bus_remove_device() and avoid both
> code duplication and calling bus_remove_device() if bus_attach_device()
> failed. Something like the patch below (untested).

It looks better, but I think that having only one function with if 
(is_registered) saves a few bytes of instruction memory. Anyway, I do not 
feel myself to judge what's the best.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
