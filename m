From: Armando Di Cianno <armando@goodship.net>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Wed, 05 Mar 2008 10:19:23 -0500
Message-ID: <1204730363.6310.45.camel@localhost>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
	<1204498741.10206.26.camel@razman.gruemaster.com>
	<1204623862.13915.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from squid9.laughingsquid.net (squid9.laughingsquid.net
	[72.32.92.32]) by alsa0.perex.cz (Postfix) with ESMTP id 572C824407
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 16:21:01 +0100 (CET)
In-Reply-To: <1204623862.13915.10.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tue, 2008-03-04 at 17:44 +0800, Jiang zhe wrote:
> I googled some info about the nvidia G84** or G86** graphics core.
> They got the audio signal from the external audio device through spdif.
> 
> For Dell M1330, the spdif configuration for the stac92** codec looks
> well, maybe the graphic driver can control whether the audio signal is
> allowed to transfer through the HDMI port?

If it's a matter of a driver twiddling a bit on and off, maybe if
someone with an @intel.com email address -- *hint hint* -- emailed
NVIDIA tech guys, we might be able to get an answer as to what bits can
be addressed to turn HDMI on and off, w/o modifying the NVIDIA binary
driver.

Does alsa-devel have a good report with NVIDIA, or any at all?

-- 
Armando Di Cianno
http://dicianno.org/blog
armando@dicianno.org
armando@goodship.net
