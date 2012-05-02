From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 10:59:53 +0200
Message-ID: <4FA0F789.20708@stericsson.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
	<4FA0EBF7.2090903@stericsson.com>
	<20120502081709.GA4075@opensource.wolfsonmicro.com>
	<4FA0F008.4020108@stericsson.com>
	<20120502084104.GB4075@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id E6F1A1043E6
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 11:00:16 +0200 (CEST)
In-Reply-To: <20120502084104.GB4075@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 05/02/2012 10:41 AM, Mark Brown wrote:

> On Wed, May 02, 2012 at 10:27:52AM +0200, Ola Lilja wrote:
> 
>> I'm actually no fan of ifdefs, but let's say that the HDMI-driver is not
>> activated in menuconfig. This would lead to the point where the ASoC-driver
>> cannot be activated at all, although there is two codecs in the driver which
>> could have been used fine.
>> If this is the way forwards then I'll rewrite it this way.
> 
> The actual CODECs are supposed to be selected by the machine driver
> anyway so there should be no possibility of them not being there.


Yes, but the codec-driver has dependency to another driver. For AB8500
codec-driver it needs the MFD-driver. This AB8500-core driver can be deselected
in menuconfig and then our whole ASoC-driver will be unavailable, even though
the other two codec-drivers actually could be used.
