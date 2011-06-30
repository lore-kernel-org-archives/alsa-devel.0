From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: What is correct way to put conditional stuff in ASoC
	codec driver?
Date: Thu, 30 Jun 2011 18:16:30 +0530
Message-ID: <1309437990.15931.67.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 0596A24476
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 14:40:35 +0200 (CEST)
Received: from mail162-tx2 (localhost.localdomain [127.0.0.1])	by
	mail162-tx2-R.bigfish.com (Postfix) with ESMTP id 19CB915503A9	for
	<alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 12:40:32 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.251])	by
	mail162-tx2.bigfish.com (Postfix) with ESMTP id B84701588052	for
	<alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 12:40:00 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
   I am working on updating ASoC codec driver for Dialog's DA7210 codec
(sound/soc/codec/da7210.c). This update would be a major functionality update in
nature. In fact we already have a feature complete driver for this codec but
there are two main issues with that driver,

(1) It was developed(and tested) for a quite old kernel version (2.6.28)
(2) It was written in custom(non standard) way and not suitable for direct 
submission to kernel

Our final goal is to pull in all missing features from this custom driver in to 
existing mainline driver. I have already created few patches for basic functions 
but I am bit confused at one point. Some of the features supported by this codec 
have inter dependency, e.g. ALC can be used only if NOISE SUPRESSION is disabled. 
So ideally, all controls related to ALC should be either disabled or not added at 
all, if NOISE SUPRESSION to be used. There are few other features having similar 
kind of dependency.

I just want to know what is the correct way to handle this in ASoC codec driver?
Looking at the existing codec drivers, it seems that having conditional defines 
is not common here. As We just want to support static configuration of such 
features, is it a good idea to add sub menu options in driver's Kconfig to 
enable/disable such features and use them within code?

Any pointer(s) to existing code are most welcome.


Thanks,

-- Ashish


----------------------------------------------------------------------------
|| Linux Is User Friendly, It's Just Selective About Who It's Friends Are ||
----------------------------------------------------------------------------
