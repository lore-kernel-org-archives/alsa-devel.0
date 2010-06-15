From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Wed, 16 Jun 2010 08:59:25 +1000
Message-ID: <20100615225925.GJ7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
	<201006151642.32385.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 64FC310382F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 00:59:31 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOf6P-00065k-1C
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:59:29 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOf6O-0004M8-9D
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:59:28 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOf6O-0004M0-8F
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:59:28 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOf6M-00064a-LP
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:59:28 +1000
Content-Disposition: inline
In-Reply-To: <201006151642.32385.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 04:42:32PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On Tuesday 15 June 2010 08:11:10 ext Stuart Longland wrote:
> > Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
> > are implemented.  I couldn't find where in the git trees the control had
> > been added, I wound up applying this patch myself in my tree... it
> > apparently got applied in the official trees, but I cannot find it.
> 
> I'm not really sure what the SOC_DOUBLE_R_SX_TLV is for... 
> But would a simple SOC_DOUBLE_R_TLV enough for the aic3204 codec?
> I have not looked at the datasheet (if it is available), but I'll try to find 
> it.

http://focus.ti.com/docs/prod/folders/print/tlv320aic3204.html has the
datasheet.

As I mentioned; the bitfields are signed integers, 6 bits wide in the
case of the example given, there are some that are 7 bits.

In the examples that I gave (driver gain settings), they have a range of
-6dB to 29dB... which corresponds to bitfield values of 0x3a (for -6dB)
and 0x1d (for 29dB).

I did try using the regular TLV macro, and found that the volume
"wrapped" around in a very undesirable fashion.  SOC_DOUBLE_R_SX_TLV was
the suggestion made at the time[1].  The way it is now, it works okay
...  if you leave the mute untouched.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

1. http://article.gmane.org/gmane.linux.alsa.devel/73640 
