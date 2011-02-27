From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Sun, 27 Feb 2011 15:54:30 -0800
Message-ID: <4D6AE436.6000201@localhost>
References: <4D69A0FC.60400@localhost> <20110227111708.GK15327@ltw.loris.tv>
	<4D6AA448.7050401@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp3.Stanford.EDU [171.67.219.83])
	by alsa0.perex.cz (Postfix) with ESMTP id EB6551037EE
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 00:54:37 +0100 (CET)
In-Reply-To: <4D6AA448.7050401@localhost>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Craig Bourne <craigbourne@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/27/2011 11:21 AM, Fernando Lopez-Lezcano wrote:
> On 02/27/2011 03:17 AM, Adrian Knoth wrote:
>> On Sat, Feb 26, 2011 at 04:55:24PM -0800, Fernando Lopez-Lezcano wrote:
>>
>>> Hi, I'm getting a segfault from hdspmixer using the current git
>>> alsa-tools (1.0.23 works, 1.0.24+ does not). See below for a backtrace.
>>> I'm running 2.6.33.x rt30, could this be the problem? (a dependency on
>>> newer kernels?)
>>
>> I have fixed this bug a couple of days ago:
>>
>>      http://thread.gmane.org/gmane.linux.alsa.devel/82452
>>
>> They still need to be applied to the alsa-tools.git, but if you like,
>> you can grab the patches and verify they work for you.
>
> They do work in a first (remote) test. Thanks very much!!

But one of my users (in Planet CCRMA) still has problems with his 9652, 
apparently the output labels for that card are missing and that is 
confirmed by looking at the source (his card works fine with the 1.0.23 
hdspmixer). I applied all your patches to current git except for the 
version number so ignore the 1.6 version printed. I'm waiting for a 
backtrace from his computer about the subsequent crash. See below for 
his message (and thanks for all the help!).

-- Fernando


-------- Original Message --------
Subject: 	[PlanetCCRMA] updated hdspmixer
Date: 	Sun, 27 Feb 2011 15:52:51 -0500
From: 	Craig Bourne <craigbourne@gmail.com>
To: 	planetccrma@ccrma.Stanford.EDU



I updated to alsa-tools 1.0.24.1-1.3.fc14.ccrma per today's note. This
does not yet fix hdspmixer as the following command-line invocation and
response shows.

-- 
Craig Bourne

*# hdspmixer*

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org
<mailto:thomas@undata.org>>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for RME cards:
Card 0: RME Hammerfall HDSP 9652 at 0xfdee0000, irq 17
HDSP 9652 found!
1 RME cards card found.
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Initializing default presets
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Unknown card type for output labels
Segmentation fault (core dumped)
