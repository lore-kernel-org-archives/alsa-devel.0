From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-kernel hg repo needs to include i2c-id.h
Date: Thu, 5 Oct 2006 13:01:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610051300380.9351@tm8103.perex-int.cz>
References: <1159968218.26829.60.camel@localhost.localdomain>
	<Pine.LNX.4.61.0610042032160.9297@tm8103-a.perex-int.cz>
	<s5hodsroy6n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodsroy6n.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Oct 2006, Takashi Iwai wrote:

> At Wed, 4 Oct 2006 20:33:14 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Wed, 4 Oct 2006, Liam Girdwood wrote:
> > 
> > > I'd like to request that include/linux/i2c-id.h is added to the
> > > alsa-kernel hg repo (in the same manner as the pci-ids.h). This way
> > > patches that include new i2c id's can be added to the kernel without
> > > having to span two different maintainers/trees.
> > 
> > Added.
> 
> Don't we need a compat header in alsa-driver like pci_ids.h?

Yes, added. Thanks.

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
