From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: ymfpci : four speakers with OSS-emulation
Date: Wed, 13 Mar 2002 09:29:58 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10203130929230.11120-100000@sorrow.ashke.com>
References: <s5h6640k0ea.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from sorrow.ashke.com (pcp110788pcs.wchryh01.nj.comcast.net [68.45.84.166])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA07558
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 15:32:09 +0100
In-Reply-To: <s5h6640k0ea.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: xavier.allamigeon@free.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Mar 2002, Takashi Iwai wrote:

> At Wed, 13 Mar 2002 08:01:02 -0500 (EST),
> Adam K Kirchhoff wrote:
> > 
> > The solution the Jaroslav gave in that e-mail actually requires changes to
> > the ymfpci driver, as I understand it.  Last time I pulled code from CVS,
> > this hadn't been done yet.  From the sound of it (based on your
> > experience) it looks like it still hasn't been done.  At the moment, I
> > don't really understand Alsa (or sound drivers in general) well enough to
> > make the change myself, nor do I really have the time to pick up that
> > knowledge at the moment.
> > 
> > However, it's also my impression from Jaroslav's explanation that this
> > would simply duplicate the output from the fron channel on the rear
> > channel. Can someone let me know if this is correct?
> 
> if you only need duplication, this can be done on alsa-lib without
> changing the driver itself.

<snip>

What would be required if you're looking for more than duplication?

Adam



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
