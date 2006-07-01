From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round
Date: Sat, 01 Jul 2006 09:52:40 -0400
Message-ID: <1151761961.11897.3.camel__1160.42242520979$1151762835$gmane$org@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
	<44A6279C.3000100@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 30896243
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 16:06:46 +0200 (MEST)
In-Reply-To: <44A6279C.3000100@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-07-01 at 08:43 +0100, James Courtier-Dutton wrote:
> Olivier Galibert wrote:
> > On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> >> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> >> emulation, not the emu10k1 driver.
> > 
> > That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> > of alsa's until alsa provides an equivalent interface.  That's a basic
> > compatibility requirement.
> > 
> > 
> >> ALSA's in-kernel OSS emulation does not have these features and
> >> never will.
> > 
> > "Never" is terribly long.
> > 
> >   OG.
> 
> "Never" probably only means terribly long. :-)
> 
> If one takes the ALSA todo list, that is massive (it is so long in fact,
> that we have not had time to write it all down!), sort it by priority,
> then divide by the amount of ALSA developers time available, for this
> particular feature, the time to implementation is getting very close to
> "Never".

The reason I say "never" is because it would either require moving
alsa-lib into the kernel (long ago rejected), or devising some system to
redirect operations on /dev/dsp back into userspace to alsa-lib.  It
seems insane for the audio path to be
userspace->kernel->userspace->kernel and I'm pretty sure this idea was
also rejected a while back.

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
