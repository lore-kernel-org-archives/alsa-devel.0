From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: distinguish events based on input ports
Date: Tue, 21 Jul 2009 15:36:35 +0200
Message-ID: <4A65C463.2030905@ladisch.de>
References: <COL110-W58CC5A84D4C828759020B5BE1C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 49285244FF
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 15:36:23 +0200 (CEST)
In-Reply-To: <COL110-W58CC5A84D4C828759020B5BE1C0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lieven Moors <lievenmoors@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lieven Moors wrote:
> I had a question regarding the use of input(read) ports.
> What I want to do is distinguish events based on the input port
> they came through. Since the destination of the event is mostly
> set to 'broadcast', I cannot extract this information from the event
> itself.

Yes you can; when delivering broadcast or to-all-subscribers events,
ALSA sets the event's destination field to the actual destination.


HTH
Clemens
