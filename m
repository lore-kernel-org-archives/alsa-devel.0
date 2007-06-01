From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_dai_link.init()
Date: Fri, 01 Jun 2007 15:41:20 +0100
Message-ID: <1180708880.26032.79.camel@localhost.localdomain>
References: <465DFBF5.9040800@freescale.com>
	<1180630964.29590.83.camel@a10072.wolfsonmicro.main>
	<465F0025.4010008@freescale.com>
	<1180631362.29590.90.camel@a10072.wolfsonmicro.main>
	<465F56D2.70201@freescale.com>
	<1180705118.26032.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 280C02469F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 16:41:22 +0200 (CEST)
In-Reply-To: <1180705118.26032.72.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-01 at 14:38 +0100, Liam Girdwood wrote:
> On Thu, 2007-05-31 at 18:14 -0500, Timur Tabi wrote:
> > Liam Girdwood wrote:
> > 
> > > http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=summary
> > > 
> > > Master branch should be up to date with mainline, for-alsa-kernel branch
> > > should be close to alsa-kernel Hg.
> > 
> > Does the http:// protocol work with your git repo?  Our corporate firewall doesn't allow 
> > the git:// protocol.
> > 
> > 
> > 
> 
> Sorry, we've just added http support now.
> 
> I'm going to create a new branch off dev called ppc-dev (will be visible
> in a few hours). This will be the best place for ppc dev.

http:// URL is :-

 git-clone http://opensource.wolfsonmicro.com/~git/linux-2.6-asoc/

This will be pull/clone access only. I've created a separate ppc-dev
(will show up in a few hours) branch as it will be easier to merge
changes in without affecting any of the current working dev tree for
other platforms.

I'm going to move the I2C probing out of a codec driver tonight.

Liam 
