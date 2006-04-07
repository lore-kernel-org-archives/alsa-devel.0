From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [BUG ALSA 2.6.17-rc1] Oops when Gaim tries to play sound
Date: Fri, 7 Apr 2006 10:15:46 +0200
Message-ID: <20060407081546.GC3947__40134.9731059328$1144397944$gmane$org@harddisk-recovery.com>
References: <20060406132042.GF20402@harddisk-recovery.nl> <1144338706.2866.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from abra2.bitwizard.nl (dtp.xs4all.nl [80.126.206.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 83E9614B
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 10:15:49 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1144338706.2866.62.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 06, 2006 at 11:51:45AM -0400, Lee Revell wrote:
> On Thu, 2006-04-06 at 15:20 +0200, Erik Mouw wrote:
> > Could be a locking error or an ALSA error, so message posted to lkml
> > and alsa-devel lists. Feel free to ask for more information.
> 
> Already reported (several times) to both LKML and alsa-devel.
> 
> See kernel bugzilla #6329

Rene Herman pointed it out in private. I applied
http://bugzilla.kernel.org/attachment.cgi?id=7779&action=view and
everything seems to work again.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
