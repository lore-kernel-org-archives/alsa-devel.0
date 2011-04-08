From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: SSM2602: add
	SPI support
Date: Thu, 7 Apr 2011 22:32:21 -0400
Message-ID: <BANLkTi=JYxMHf5_Xd_1VfXD=RZ8Pzb64Xw@mail.gmail.com>
References: <1302156311-16536-1-git-send-email-vapier@gentoo.org>
	<20110408003504.GG9827@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 48CA11038C4
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 04:32:43 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1456464gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2011 19:32:41 -0700 (PDT)
In-Reply-To: <20110408003504.GG9827@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 7, 2011 at 20:35, Mark Brown wrote:
> On Thu, Apr 07, 2011 at 02:05:11AM -0400, Mike Frysinger wrote:
>> The ssm2602 codec has a SPI interface as well as I2C, so add the simple
>> bit of glue to make it usable.
>
> Applied, but the patch didn't apply cleanly - please check that I
> resolved it OK.

sorry about that ... i was thinking there shouldnt be any conflicts in
the codec since i'm the only one sending patches ;).  but i guess
you're referring to just the Kconfig ?

what git tree / branch did you merge into ?  i checked tiwai's
sound-2.6.git and the linux-2.6-asoc.git on
opensource.wolfsonmicro.com, but couldnt see this changeset ...
-mike
