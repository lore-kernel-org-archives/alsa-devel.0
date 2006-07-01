From: Olivier Galibert <galibert@pobox.com>
Subject: Re: OSS driver removal, 2nd round
Date: Sat, 1 Jul 2006 09:31:33 +0200
Message-ID: <20060701073133.GA99126@dspnet.fr.eu.org>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72A0624D
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 09:31:34 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1151702966.32444.57.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> emulation, not the emu10k1 driver.

That's irrelevant.  You can't remove the oss emu10k1 driver in favor
of alsa's until alsa provides an equivalent interface.  That's a basic
compatibility requirement.


> ALSA's in-kernel OSS emulation does not have these features and
> never will.

"Never" is terribly long.

  OG.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
