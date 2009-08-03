From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pyalsa: SeqEvent.time strangeness (Was:
 synchronizing queue with MIDI clock events)
Date: Mon, 03 Aug 2009 13:55:11 +0200
Message-ID: <4A76D01F.1090603@ladisch.de>
References: <4A607468.7010300@web.de>
	<4A65C370.3030205@ladisch.de>	<4A65EADE.70007@web.de>
	<4A733753.60808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 68302103825
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 13:54:58 +0200 (CEST)
In-Reply-To: <4A733753.60808@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christopher Arndt <chris.arndt@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christopher Arndt wrote:
> I've tested this now and encountered a very strange bevahior of the
> event time set by the queue:
> 
> a) SeqEvent.time seems to be in milliseconds instead of seconds as would
> be expected by the ALSA documentation and looking at the source of
> pyalsa.alsaseq.
> 
> 5) Consecutive timestamp go up to ~1000,00 and then seem to wrap around
> and start from zereo again.

Apparently, you are the first one who tried to use this.  Fixed now:
http://git.alsa-project.org/?p=alsa-python.git;a=commitdiff;h=9a7dea33dddeb2d9d7693257323d43ccffbffed2


HTH
Clemens
