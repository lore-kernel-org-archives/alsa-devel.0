From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: TLV
Date: Fri, 23 Jun 2006 11:16:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606231103050.10283@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0606212015120.11678@tm8103-a.perex-int.cz>
	<449A7BED.8010402@superbug.co.uk> <s5hbqslcr25.wl%tiwai@suse.de>
	<449A8D98.1060303@superbug.co.uk> <s5h8xnpcqji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B66622F
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 11:16:06 +0200 (MEST)
In-Reply-To: <s5h8xnpcqji.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Jun 2006, Takashi Iwai wrote:

> > Or worse, finding out that we have to be backwards compatible with an 
> > API that was never used!
> 
> If it was never used, we can simply abandon the old ioctl :)
> (Of course, better not to have such one.)

I think that the situation with the out-of-tree development is not ideal. 
I commited my first TLV patch as soon as possible to show the way. It's 
really a smart patch without any additonal code to show the simplest way 
to implement TLV. The callback enhancement is also a quick and smart 
evolution for the TLV implementation so I'd like to commit it also now, 
but reactions like "we should wait more time" prevents me to do it. I 
think that the policy should be: Send a patch proposal to alsa-devel and 
if none has serious objections in two weeks, put it to the HG repo, 
otherwise we'll end with huge changes which can be hardly verified in the 
commit time. I would prefer a step-by-step evolution and bug-fixing in 
several commits rather than a big patch which does all at once.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
