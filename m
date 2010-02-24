From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: issues porting codec to s3c2443
Date: Wed, 24 Feb 2010 11:43:41 -0600
Message-ID: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id C19FF24422
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 18:45:00 +0100 (CET)
Received: from mail152-tx2 (localhost [127.0.0.1])	by
	mail152-tx2-R.bigfish.com (Postfix) with ESMTP id 4B1EC1028189	for
	<alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 17:44:56 +0000 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.243])	by
	mail152-tx2.bigfish.com (Postfix) with ESMTP id 62891160804C	for
	<alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 17:43:46 +0000 (UTC)
Received: from ausnt-009.ad.cirrus.com ([198.61.95.83])	by mail1.cirrus.com
	(8.13.8/8.12.11) with ESMTP id o1OHWihd013109	for
	<alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 11:32:44 -0600
Content-Class: urn:content-classes:message
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

Hello,

 

I have forward ported the CS42L52 from 2.6.26.2 to the current asoc git
tree.  The codec and smdk2443-cs42l52 drivers load correctly, at least I
think so, and would like to submit the CS42L52 driver but am having some
issues with s3c2412-i2s.  From my previous kernel version to the latest
there has been significant changes to the S3C architecture and I pretty
sure that I am missing something because of that.  The question is, is
it ok to submit the codec standalone and have someone look at it to make
sure I made the correct changes.  No compiler warnings occur.  My port
was based off of the WM8750 if that helps any

 

Here is the output from my SMDK2443 Simtec

 

Advanced Linux Sound Architecture Driver Version 1.0.18a.

No device for DAI CS42L52

No device for DAI s3c2412-i2s

SMDK2443  cs42l52 ALSA SoC driver ver1.1 10/2008

soc-audio soc-audio: RXEN: Invalid MODE in IISMOD

CS42L52: Cirrus Logic ALSA SoC codec cs42l52 driver verison 1.1 10/2008

ALSA device list:

  No soundcards found.

 

It seems that the S3C2412 I2S is not setup correctly for my platform.

 

Thanks,

Brian Austin
