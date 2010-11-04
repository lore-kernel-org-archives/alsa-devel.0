From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA UCM
Date: Thu, 4 Nov 2010 19:52:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CED924413
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:52:25 +0100 (CET)
In-Reply-To: <1288896461.3277.98.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Nov 2010, Liam Girdwood wrote:

> On Thu, 2010-11-04 at 19:34 +0100, Jaroslav Kysela wrote:
>> On Thu, 4 Nov 2010, Liam Girdwood wrote:
>>
>>>> 	Value {
>>>> 	      MasterPlaybackVolume "name='Headset Playback Volume' 1"
>>>> 	      MasterCaptureVolume "name='Capture Volume' 1"
>>
>> What does mean '1'? If you like to define element id index, use:
>>
>
> Ah, that looks a conversion bug from Abrahams old file format to his new
> format. I guess it caught out the parser too here.
>
> Abraham, could you check over your configuration files and send a patch
> for the parser that spits an error out here.
>
>> MasterPlaybackVolume "name='Headset Playback Volume',index=1"
>
> My preference is not to use the ID since it can sometimes change with
> driver updates. The names are pretty constant though.

You probably mean unique numid for each control? Index is just an index 
for the ASCII name to distinguish controls with same name (I think that 
you had a syntax name:index in the original code).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
