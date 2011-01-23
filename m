From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM questions
Date: Sun, 23 Jan 2011 14:39:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101231430550.6272@eeebox2.perex-int.cz>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<1295623491.3348.284.camel@odin>
	<AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B7F0924418
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 14:39:34 +0100 (CET)
In-Reply-To: <AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Jan 2011, pl bossart wrote:

>> Originally, verbs were mapped 1:1 with cards, however Jaroslav recently
>> added support for multiple cards per verb.
>
> Does this mean for a given verb UCM will return a list of devices on
> different cards that can be used, and the application will choose from
> the list? Or are these multiple cards supposed to be used
> simultaneously?
> I probably need more expresso here..

You may have for example USB microphone and USB speakers plugged to the 
system (each represents one card for the ALSA driver with different USB 
physical links). UCM can join these two cards as one "virtual", so if an 
app asks for playback device, USB speakers are returned and for capture 
device, USB MIC is returned. Only one alsa-lib's device should be returned 
for given verb/device/modifier identifiers. I admit that the PCM 
configuration for alsa-lib allows this too, but UCM handles also the 
mixer control mapping.

Anyway, your questions are mostly about the abstract mapping. The purpose 
of UCM is to allow any abstraction, so strings in the header file like 
"HiFi" or so are just common cases. But anyone can create own abstraction 
for different purposes.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
