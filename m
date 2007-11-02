From: Timur Tabi <timur@freescale.com>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Fri, 02 Nov 2007 13:22:24 -0500
Message-ID: <472B6AE0.1090109@freescale.com>
References: <472B4416.8060009@freescale.com>
	<1194023465.19772.1219244387@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E49B624396
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 19:22:29 +0100 (CET)
In-Reply-To: <1194023465.19772.1219244387@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Timur Tabi wrote:
>> I have a customer who says that mplayer (using OSS) does not work when he tries
>> a kernel based on 2.6.23-rc4, but it works when he uses a kernel based on
>> 2.6.21.  Everything else is the same (including the version of alsa-lib), so I
>> presume something broke in the OSS emulation in the kernel.
> 
> It could also be a change in the driver.
> 
> And it would be nice to know what "does not work" actually means.

I didn't want to get into a length description of the problem without first 
seeing if there were any obvious changes.  There are still a few things I can debug.

The problem I'm seeing is that when using mplayer to play a video file through 
the OSS interface, at some point in the movie, the driver will stop telling ALSA 
that has finished playing a period.  It's almost as if ALSA is throttling the 
driver incorrectly.

If I tell mplayer to just play the file through OSS, the problem occurs almost 
immediately.  If I tell mplayer to convert the sample rate from 44100 to 48000 
(my driver understands 48000 but not 44100), the problem doesn't always occur, 
but when it does (about every other time I play the file), it starts to happen 
about 5 seconds into the file.

-- 
Timur Tabi
Linux kernel developer at Freescale
