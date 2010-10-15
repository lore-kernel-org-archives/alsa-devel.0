From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 16:34:31 +0200
Message-ID: <4CB86677.6050005@ladisch.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>	<201010151504.56742.julian@jusst.de>	<1287149510.2344.8.camel@desktop-alex>
	<201010151624.46800.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8547E2414A
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 16:33:17 +0200 (CEST)
In-Reply-To: <201010151624.46800.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Julian Scheel wrote:
> 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> 
> Does not seem to be feedback related... Although it would be nice to know, 
> what's wrong there?

What's wrong is
1) that the driver complains about something that isn't wrong, and
2) that you're using a driver more than three months old, which is when
   I killed that message.  ;-)

> Is there any way to get some more verbosity out of alsa drivers? To check if
> it really receives the feedback information at all.

grep "Momentary freq" /proc/asounc/cardX/stream0

Or put a log message into retire_playback_sync_urb*().


Regards,
Clemens
