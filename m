From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Sat, 03 Nov 2007 16:51:22 +0000
Message-ID: <472CA70A.1080703@superbug.co.uk>
References: <472B4416.8060009@freescale.com>	<1194023465.19772.1219244387@webmail.messagingengine.com>
	<472B6AE0.1090109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 862CD24697
	for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2007 17:51:26 +0100 (CET)
In-Reply-To: <472B6AE0.1090109@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Clemens Ladisch wrote:
>> Timur Tabi wrote:
>>> I have a customer who says that mplayer (using OSS) does not work when he tries
>>> a kernel based on 2.6.23-rc4, but it works when he uses a kernel based on
>>> 2.6.21.  Everything else is the same (including the version of alsa-lib), so I
>>> presume something broke in the OSS emulation in the kernel.
>> It could also be a change in the driver.
>>
>> And it would be nice to know what "does not work" actually means.
> 
> I didn't want to get into a length description of the problem without first 
> seeing if there were any obvious changes.  There are still a few things I can debug.
> 
> The problem I'm seeing is that when using mplayer to play a video file through 
> the OSS interface, at some point in the movie, the driver will stop telling ALSA 
> that has finished playing a period.  It's almost as if ALSA is throttling the 
> driver incorrectly.
> 
> If I tell mplayer to just play the file through OSS, the problem occurs almost 
> immediately.  If I tell mplayer to convert the sample rate from 44100 to 48000 
> (my driver understands 48000 but not 44100), the problem doesn't always occur, 
> but when it does (about every other time I play the file), it starts to happen 
> about 5 seconds into the file.
> 
Why are you using OSS. mplayer supports ALSA direct.
