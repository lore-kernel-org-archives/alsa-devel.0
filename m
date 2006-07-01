From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS driver removal, 2nd round
Date: Sat, 1 Jul 2006 11:26:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0607011118420.8553__19785.1278390319$1151746040$gmane$org@tm8103.perex-int.cz>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1457169
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 11:26:09 +0200 (MEST)
In-Reply-To: <20060701073133.GA99126@dspnet.fr.eu.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olivier Galibert <galibert@pobox.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Lee Revell <rlrevell@joe-job.com>, Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 1 Jul 2006, Olivier Galibert wrote:

> On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> > Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> > emulation, not the emu10k1 driver.
> 
> That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> of alsa's until alsa provides an equivalent interface.  That's a basic
> compatibility requirement.

Sorry, but the OSS interface is not an issue for the emu10k1 driver. It 
already supports multi-open, because emu10k1/emu10k2 chip supports more 
voices in hardware. Lee was speaking about cheap versions of Sound Blaster 
cards and they are not supported with the OSS emu10k1 linux driver, too.

> > ALSA's in-kernel OSS emulation does not have these features and
> > never will.
> 
> "Never" is terribly long.

The questions is which feature is missing from the ALSA emu10k1 driver. 
Personally, I don't know about any, except some extra features like 
rear/center/lfe channel binding, but the old OSS app binaries does not 
know about them, so it's no worth to care.

In my opinion, the OSS emu10k1 driver is ready to be removed unless 
someone notify us about any missing feature.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
