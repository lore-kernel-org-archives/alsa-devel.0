From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: issues porting codec to s3c2443
Date: Wed, 24 Feb 2010 17:57:54 +0000
Message-ID: <1267034274.3274.595.camel@odin>
References: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F28424438
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 18:57:53 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 4so13084eyg.0
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 09:57:51 -0800 (PST)
In-Reply-To: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-02-24 at 11:43 -0600, Austin, Brian wrote:
> Hello,
> 
>  
> 
> I have forward ported the CS42L52 from 2.6.26.2 to the current asoc git
> tree.  The codec and smdk2443-cs42l52 drivers load correctly, at least I
> think so, and would like to submit the CS42L52 driver but am having some
> issues with s3c2412-i2s.  From my previous kernel version to the latest
> there has been significant changes to the S3C architecture and I pretty
> sure that I am missing something because of that.  The question is, is
> it ok to submit the codec standalone and have someone look at it to make
> sure I made the correct changes.  No compiler warnings occur.  My port
> was based off of the WM8750 if that helps any
> 
>  
> 
> Here is the output from my SMDK2443 Simtec
> 
>  
> 
> Advanced Linux Sound Architecture Driver Version 1.0.18a.
> 
> No device for DAI CS42L52
> 
> No device for DAI s3c2412-i2s
> 
> SMDK2443  cs42l52 ALSA SoC driver ver1.1 10/2008
> 
> soc-audio soc-audio: RXEN: Invalid MODE in IISMOD
> 
> CS42L52: Cirrus Logic ALSA SoC codec cs42l52 driver verison 1.1 10/2008
> 
> ALSA device list:
> 
>   No soundcards found.
> 
>  
> 
> It seems that the S3C2412 I2S is not setup correctly for my platform.
> 

Please do send your codec and machine drivers to the list. This will
make it easier to debug.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
