From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 19 Aug 2004 11:48:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040819114831.187b00b0@mango.fruits.de>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
	<1092842830.13603.3.camel@localhost.localdomain>
	<20040818181350.2b38e875@mango.fruits.de>
	<Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
	<20040818201535.1f49a128@mango.fruits.de>
	<Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 787A51B9
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2004 11:37:52 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Shaya Potter <spotter@cs.columbia.edu>, Clemens Ladisch <clemens@ladisch.de>, Mauro Romano Trajber <trajber@terra.com.br>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Aug 2004 10:58:04 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> > But fixing the mmap issue was over my head [sorry], so i didn't go
> > after it further.
> 
> Yep, but most bug reports are for quake or similar games. I don't play
> them and also I don't have useable supported hardware with the OpenGL,
> so I cannot test them. If you trace the code (I think that open source
> variants have similar OSS code) and create a simple test utility which
> can be run from the command line, I'll try to fix aoss.

I think there are opensourced versions of _some_ of these old games.
I'll take a look. If i don't find anything i'll try to write an oss test
app that uses mmap and fails similarly. 

> > yes, you're right. Btw: i also think there needs to be a predefined
> > asym device which makes fullduplex access available for nultiple
> > apps, too..
> 
> I agree. Do you have a nice idea for the PCM name? My ideas:
> 
> mix
> xmulti (we have already multi plugin)
> shs (SHared Stream)
> shd (SHared Device)

simply "shared" maybe? "mix" doesn't quite fit it, since it only
describes the playback direction and it's maybe too similar to "dmix".
Or stick to the way it was done with the dmix plugin. Call the
predefined device using asym simply "asym".


> > a] fixing aoss to support all legacy oss apps [even those which
> > cannot be changed at source code level]
> > 
> > b] create a kernel module like the beforementioned which would just
> > eliminate the issue for most users since they can just use the
> > kernel level oss emu..
> 
> My plan is fix aoss and create a network sound device inside kernel,
> so we can reroute OSS streams from kernel to userspace, too.

May i ask, why your planning to make this networked? I read some
articles about user space file systems [which get utilized
by kernel modules] a while back. I think that networking introduces
another layer of complexity. You think this is nessecary?

hmm, some links i found in my bookmarks:

http://okmij.org/ftp/syscall-interpose.html
http://www.circlemud.org/~jelson/software/fusd/

regards,
flo


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
