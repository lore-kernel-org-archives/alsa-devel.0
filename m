From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 12:23:11 +0200
Message-ID: <201010161223.11635.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151624.46800.julian@jusst.de> <4CB86677.6050005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 91F3724738
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 12:23:14 +0200 (CEST)
In-Reply-To: <4CB86677.6050005@ladisch.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Freitag, 15. Oktober 2010, 16:34:31 schrieb Clemens Ladisch:
> Julian Scheel wrote:
> > 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> > 
> > Does not seem to be feedback related... Although it would be nice to
> > know, what's wrong there?
> 
> What's wrong is
> 1) that the driver complains about something that isn't wrong, and
> 2) that you're using a driver more than three months old, which is when
>    I killed that message.  ;-)

Ok, good to know (c:

> > Is there any way to get some more verbosity out of alsa drivers? To check
> > if it really receives the feedback information at all.
> 
> grep "Momentary freq" /proc/asounc/cardX/stream0
> 
> Or put a log message into retire_playback_sync_urb*().

Momemtary freq in stream0 always stays at 48000 (0x30). So feedback seems to 
be ignored?
