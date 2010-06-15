From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 15:23:51 +1000
Message-ID: <20100615052351.GH7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id F27A1103867
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 07:23:56 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOOct-00088T-1U
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:23:55 +1000
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOcs-00088J-VW
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:23:54 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOOcs-00025y-MK
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:23:54 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOcs-00025v-LN
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:23:54 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOOcq-00023s-OZ
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 15:23:54 +1000
Content-Disposition: inline
In-Reply-To: <20100615051110.GG7759@www.longlandclan.yi.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 03:11:10PM +1000, Stuart Longland wrote:
> On Tue, Jun 15, 2010 at 10:27:34AM +1000, Stuart Longland wrote:
> > On Fri, Jun 11, 2010 at 11:18:04AM +0100, Mark Brown wrote:
> > > On Fri, Jun 11, 2010 at 03:55:12PM +1000, Stuart Longland wrote:
> > > 
> > > > (1)	When using the SOC_DOUBLE_R_SX_TLV controls, I notice there's an
> > > > 	odd interaction between the mute switch associated with the
> > > > 	control, and its corresponding gain setting.
> > > 
> > > > 	Nothing changes in the actual registers (except the mute bit of
> > > > 	course) but the displayed gain shoots up to infinity if the mute
> > > > 	is toggled when the gain associated with that mute control is
> > > > 	set below 0dB.  When the gain is at 0dB or above, toggling the
> > > > 	mute has no effect on the displayed gain setting.
> > > 
> > > This is almost always due to having an overlap between the bitfield for
> > > the volume and the mute bit.
> > 
> > I'll have a closer look, perhaps there's some misunderstanding on my
> > part as to how the macros work.
> 
> Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
> are implemented.  I couldn't find where in the git trees the control had
> been added, I wound up applying this patch myself in my tree... it
> apparently got applied in the official trees, but I cannot find it.
Okay... further digging, found it at
<http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-2.6.git;a=patch;h=b6f4bb383d69cac46f17e2305720f9a3d426c5ed>

Looks like what I got is pretty much identical.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
