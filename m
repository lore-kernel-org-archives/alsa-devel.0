From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 07:30:53 +0200
Message-ID: <4E4A008D.60907@canonical.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 8FA1C24575
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 07:30:57 +0200 (CEST)
In-Reply-To: <000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/15/2011 10:31 PM, Pierre-Louis Bossart wrote:
> - Increasing the number of packets/urbs solves my power issue but not the
> synchronization issue. If I reduce the number of urbs to reduce the
> interrupt rate, then the accuracy of the hw_pointer is decreased big time
> and it becomes difficult to synchronize with video.

I think the same thing is a problem for quite a few other devices as 
well - I wonder if we need some kind of "pointer granularity" variable 
to be exported through the ALSA API? PulseAudio could use that to 
determine whether or not to enable timer-based scheduling. And in these 
cases, maybe a call to hw_pointer could return hw_pointer and time, and 
then PulseAudio etc could use that for extrapolation (or the 
extrapolation could be done in alsa-lib).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
