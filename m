From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Fri, 31 May 2002 20:14:36 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF75B1C.64F308D1@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
		<3CF5B58B.59E5A233@boosthardware.com>
		<s5hwutkhhhj.wl@alsa2.suse.de>
		<3CF7430E.F1994375@boosthardware.com>
		<s5hn0ughcx1.wl@alsa2.suse.de> <s5hlma0h9uj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Fri, 31 May 2002 11:41:46 +0200,
> I wrote:
> >
> > > > > devfs: devfs_register(): device already registered: "unknown"
> > > >
> > > > this is a bug of sound_core.c.  you can fix it by replacing
> > > > sound_core.c with the one in alsa-kernel tree.
> > > >
> > >
> > > General question. Is the above likely to cause problems if I don't swap
> > > them?
> >
> > no, it works fine on 2.4 kernel, too.  i'm using it.
> 
> err, my statement was not clear --
> 

Yep :)

> original sound_core.c is ok as long as if you don't use devfs _and_
> multiple cards.  the one in alsa-kernel is fixed for such a
> condition.  but, generally, swapping to the fixed one will cause no
> problem.  it's fully compatible.
> 

So as long as I don't use devfs I don't need it. Currently I still use
the /proc interface but I don't have concrete understanding of the
difference between the two yet. fromwhat I gathered you have to specify
devfs in the kernel for it to be used. Is that correct?

Anyway I definitely use multiple cards so I will do the change if
neccessary.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
