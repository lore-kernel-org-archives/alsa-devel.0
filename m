From: Luke Ross <luke@lukeross.name>
Subject: Re: "Unable to handle kernel paging request"
	panic	in	snd-usb-audio on x86_64
Date: Tue, 26 Sep 2006 11:13:15 +0100
Message-ID: <20060926101315.GB28386@lukeross.name>
References: <20060920225128.GG19215@lukeross.name>
	<s5hvenhcb8v.wl%tiwai@suse.de>
	<20060922104850.GA20850@lukeross.name>
	<s5hodt3j4fm.wl%tiwai@suse.de>
	<20060924234858.GA23432@lukeross.name>
	<s5hpsdir3bx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsdir3bx.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Sep 26, 2006 at 06:37:54PM +0200, Takashi Iwai wrote:
> 
> > > I still couldn't find a proper way to reproduce this bug...
> > 
> > So I can compare, which kernel version are you using? As touched on 
> > before, it only happens to me on x86_64, and it may be SMP dependent 
> > (my i386 machine is uniprocessor, my x86_64 one is SMP).
> 
> My test machine is an Intel x86-64 single core running (almost)
> vanilla 2.6.18 SMP kernel with HT.  ALSA 1.0.13rc3 is now built on
> that, and seems working with mpg321, at least.
> The whole ALSA stuff is built as modules.

Sorry if I've jumped to an incorrect conclusion here, but you are 
including the patch and/or Hg pull? Neither 2.6.18 nor 1.0.13rc3 
incorporate the patch in question, as it went in after both of these 
were released. The patch is in Hg and also the latest -mm, although I 
can also reproduce the problem by taking a stock kernel and applying the 
patch as posted to the mailing list[1]

Regards,

Luke

[1] 
http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=d55e9f78b1c4fbff1cd5d4c6462ec111aaea9267;style=raw
-- 
``Avoid employing unlucky people - throw half of the pile of CVs in the bin
  without reading them'' (David Brent)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
