From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:13:07 +0000
Message-ID: <1327511587.11901.42.camel@odin>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 44DBA103BBF
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:13:16 +0100 (CET)
Received: by wgbds1 with SMTP id ds1so3756063wgb.6
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 09:13:10 -0800 (PST)
In-Reply-To: <20120125171112.GR3687@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-01-25 at 17:11 +0000, Mark Brown wrote:
> On Wed, Jan 25, 2012 at 05:07:29PM +0000, Liam Girdwood wrote:
> > On Tue, 2012-01-24 at 13:36 -0800, Pierre-Louis Bossart wrote:
> 
> > We could eventually remove steps 2 and 4 for the FE DAI link, and look
> > at hard coding the hw_params() in the mach driver for the loopback link.
> 
> That's what the CODEC<->CODEC stuff is all about, hiding the link from
> userspace.
> 

Ok, cool - Is the formatting and params hard coded ?

Liam
